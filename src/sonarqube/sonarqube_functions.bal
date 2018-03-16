//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

package src.sonarqube;

import ballerina.net.http;

@Description {value:"Check whether the response from sonarqube server has an error field."}
@Param {value:"response: http InResponse."}
function checkResponse (http:InResponse response) {
    json responseJson = getContentByKey(response, ERRORS);
    if (responseJson != null) {
        error err = {message:""};
        foreach item in responseJson {
            err.message = err.message + ((item.msg != null) ? item.msg.toString() : "") + ".";
        }
        throw err;
    }
}

@Description {value:"Get content from a json."}
@Param {value:"response: http InResponse."}
@Return {value:"jsonPayload: response Json payload."}
function getContent (http:InResponse response) (json) {
    var jsonPayload, err = response.getJsonPayload();
    if (err != null) {
        throw err;
    }
    if (jsonPayload == null) {
        if (response.reasonPhrase != null) {
            err = {message:response.reasonPhrase};
            throw err;
        }
        err = {message:"Server response payload is null."};
        throw err;
    }
    return jsonPayload;
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http InResponse."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content (of type json) specified by the key."}
function getContentByKey (http:InResponse response, string key) (json) {
    var jsonPayload, err = response.getJsonPayload();
    if (err != null) {
        throw err;
    }
    if (jsonPayload == null) {
        if (response.reasonPhrase != null) {
            err = {message:response.reasonPhrase};
            throw err;
        }
        err = {message:"Server response payload is null."};
        throw err;
    }
    return jsonPayload[key];
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http InResponse."}
@Return {value:"value: Value of the metric field in json."}
@Return {value:"err: if error occured in getting value of the measures field in the json."}
function getMetricValue (string projectKey, string metricName) (string, error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError connectionError;
    constructAuthenticationHeaders(request);
    string requestPath = API_MEASURES + "?" + COMPONENT_KEY + "=" + projectKey + "&" + METRIC_KEY + "=" + metricName;
    response, connectionError = sonarqubeEP.get(requestPath, request);
    string value;
    error err;
    try {
        if (connectionError != null) {
            err = {message:connectionError.message};
            throw err;
        }
        checkResponse(response);
        json component = getContentByKey(response, COMPONENT);
        json metricValue = component[MEASURES][0][VALUE];
        value = (metricValue != null) ? metricValue.toString() : null;
        if (value == null) {
            err = {message:"Cannot find " + metricName.replace("_", " ") + " for this project."};
            throw err;
        }
    } catch (error getValueError) {
        return null, getValueError;
    }
    return value, err;
}

@Description {value:"Perform operations in Issues and get the output."}
@Param {value:"name:Operation name."}
@Param {value:"requestPath:Request path of the operation."}
@Param {value:"payload:Outgoing Payload."}
@Return {value:"err: Returns if an error raised in doing operation."}
function doOpertion (string name, string requestPath, json payload) (error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError connectionError;
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, APPLICATION_JSON);
    request.setJsonPayload(payload);
    response, connectionError = sonarqubeEP.post(requestPath, request);
    error err = null;
    try {
        if (connectionError != null) {
            err = {message:name + " is unsuccessful " + connectionError.message};
            throw err;
        }
        checkResponse(response);
    } catch (error doOperationError) {
        doOperationError.message = name + " is unsuccessful." + doOperationError.message;
        return doOperationError;
    }
    return err;
}

@Description {value:"Get project specified by name from SonarQube server."}
@Param {value:"projectName:Name of the project."}
@Return {value:"project:Details of the project specified by name."}
function getProjectDetails (string projectName) (Project) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError connectionError;
    constructAuthenticationHeaders(request);
    response, connectionError = sonarqubeEP.get(API_RESOURCES + PAGE_SIZE, request);
    error err;
    if (connectionError != null) {
        if (connectionError != null) {
            err = {message:connectionError.message};
            throw err;
        }
    }
    checkResponse(response);
    json paging = getContentByKey(response, PAGING);
    var value, err = <int>((paging[TOTAL] != null) ? paging[TOTAL].toString() : "0");
    if (err != null || value == 0) {
        err = {message:"Projects cannot be found in SonarQube server."};
        throw err;
    }
    if (value <= PAGE_SIZE) {
        json allProducts = getContentByKey(response, COMPONENTS);
        Project project = getProjectFromList(projectName, allProducts);
        if (project == null) {
            err = {message:"Project specified by " + projectName + " cannot be found in the SonarQube server."};
            throw err;
        }
        return project;
    }
    json allProducts = getContentByKey(response, COMPONENTS);
    Project project = getProjectFromList(projectName, allProducts);
    if (project != null) {
        return project;
    }
    int totalPages = (value % PAGE_SIZE > 0) ? (value / PAGE_SIZE + 1) : value / PAGE_SIZE;
    int count = 0;
    while (count < totalPages - 1) {
        request = {};
        response = {};
        constructAuthenticationHeaders(request);
        response, connectionError = sonarqubeEP.get(API_RESOURCES + PAGE_SIZE + "&" + PAGE_NUMBER + "=" + (count + 1), request);
        if (connectionError != null) {
            if (connectionError != null) {
                err = {message:connectionError.message};
                throw err;
            }
        }
        checkResponse(response);
        allProducts = getContentByKey(response, COMPONENTS);
        project = getProjectFromList(projectName, allProducts);
        if (project != null) {
            return project;
        }
        count = count + 1;
    }
    return null;
}

@Description {value:"Return the project from a json array of projects."}
@Param {value:"projectName:Name of the project."}
@Param {value:"projectList:Project List."}
@Return {value:"project:Details of the project specified by name."}
function getProjectFromList (string projectName, json projectList) (Project) {
    foreach projectData in projectList {
        Project project = <Project, getProjectDetails()>projectData;
        if (project.name == projectName) {
            var projectVersion, description = getProjectVersionAndDescription(project.key);
            project.|version| = projectVersion;
            project.description = description;
            return project;
        }
    }
    return null;
}

@Description {value:"Get project version and description."}
@Param {value:"projectKey:Key of the project."}
@Return {value:"projectVersion:Version of the project."}
function getProjectVersionAndDescription (string projectKey) (string, string) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError connectionError;
    constructAuthenticationHeaders(request);
    response, connectionError = sonarqubeEP.get(API_SHOW_COMPONENT + projectKey, request);
    if (connectionError != null) {
        if (connectionError != null) {
            return null, null;
        }
    }
    json component;
    json |version|;
    json description;
    try {
        component = getContentByKey(response, COMPONENT);
        if (component != null) {
            |version| = component[VERSION];
            description = component[DESCRIPTION];
        }
    } catch (error getVersionError) {
        return null, null;
    }
    return (|version| != null) ? |version|.toString() : null, (description != null) ? description.toString() : null;
}