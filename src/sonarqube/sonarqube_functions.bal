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

package src/sonarqube;

@Description {value:"Get project specified by name from SonarQube server."}
@Param {value:"projectName:Name of the project."}
@Return {value:"project:Details of the project specified by name."}
function getProjectDetails (string projectName) returns (Project) {
    http:Request request = {};
    http:Response response = {};
    http:HttpConnectorError connectionError = {};
    constructAuthenticationHeaders(request);
    var endpointResponse = clientEP -> get(API_RESOURCES + PAGE_SIZE, request);
    match endpointResponse {
        http:Response res => response = res;
        http:HttpConnectorError connectErr => connectionError = connectErr;
    }
    error err = {};
    if (connectionError.message != "") {
        err = {message:connectionError.message};
        throw err;
    }
    checkResponse(response);
    json paging = getContentByKey(response, PAGING);
    string pagingTotal = !isAnEmptyJson(paging[TOTAL]) ? paging[TOTAL].toString() : "0";
    var convertedValue = <int>pagingTotal;
    int value = 0;
    match convertedValue{
        int val => value = val;
        error castError => throw castError;
    }
    if (value <= PAGE_SIZE) {
        json allProducts = getContentByKey(response, COMPONENTS);
        Project project = getProjectFromList(projectName, allProducts);
        if (project.key != "") {
            err = {message:"Project specified by " + projectName + " cannot be found in the SonarQube server."};
            throw err;
        }
        return project;
    }
    json allProducts = getContentByKey(response, COMPONENTS);
    Project project = getProjectFromList(projectName, allProducts);
    if (project.key != "") {
        return project;
    }
    int totalPages = (value % PAGE_SIZE > 0) ? (value / PAGE_SIZE + 1) : value / PAGE_SIZE;
    int count = 0;
    while (count < totalPages - 1) {
        request = {};
        constructAuthenticationHeaders(request);
        endpointResponse = clientEP -> get(API_RESOURCES + PAGE_SIZE + "&" + PAGE_NUMBER + "=" + (count + 1), request);
        match endpointResponse {
            http:Response res => response = res;
            http:HttpConnectorError connectErr => connectionError = connectErr;
        }
        if (connectionError.message != "") {
            err = {message:connectionError.message};
            throw err;
        }
        checkResponse(response);
        allProducts = getContentByKey(response, COMPONENTS);
        project = getProjectFromList(projectName, allProducts);
        if (project.key != "") {
            return project;
        }
        count = count + 1;
    }
    return {};
}
@Description {value:"Check whether the response from sonarqube server has an error field."}
@Param {value:"response: http Response."}
function checkResponse (http:Response response) {
    json responseJson = getContentByKey(response, ERRORS);
    if (!isAnEmptyJson(responseJson)) {
        error err = {message:""};
        foreach item in responseJson {
            err.message = err.message + ((item.msg != null) ? item.msg.toString() : "") + ".";
        }
        throw err;
    }
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http Response."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content (of type json) specified by the key."}
function getContentByKey (http:Response response, string key) returns (json) {
    var getContent = response.getJsonPayload();
    json jsonPayload = {};
    error jsonErr = {};
    match getContent {
        json content => jsonPayload = content;
        error endpointErr => jsonErr = endpointErr;
    }
    if (isAnEmptyJson(jsonPayload)) {
        error err = {};
        if (response.reasonPhrase != "") {
            err = {message:response.reasonPhrase};
            throw err;
        }
        err = {message:"Server response payload is null."};
        throw err;
    } else if (jsonErr.message != "") {
        throw jsonErr;
    }
    return jsonPayload[key];
}

@Description {value:"Check whether a json is empty."}
@Return {value:"True if json is empty false otherwise."}
function isAnEmptyJson (json jsonValue) returns (boolean) {
    try {
        string stringVal = jsonValue.toString();
        if (stringVal == "{}") {
            return true;
        }
        return false;
    } catch (error e) {
        return true;
    }
    return false;
}

@Description {value:"Return the project from a json array of projects."}
@Param {value:"projectName:Name of the project."}
@Param {value:"projectList:Project List."}
@Return {value:"project:Details of the project specified by name."}
function getProjectFromList (string projectName, json projectList) returns (Project) {
    foreach projectData in projectList {
        var projectData = <Project, getProjectDetails()>projectData;
        match projectData {
            Project project => {if (project.name == projectName) {
                                    return project;
                                }
            }
            error conversionError => throw conversionError;
        }
    }
    return {};
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http Response."}
@Return {value:"value: Value of the metric field in json."}
@Return {value:"err: if error occured in getting value of the measures field in the json."}
function getMetricValue (string projectKey, string metricName) returns (string) {
    http:Response response = {};
    http:Request request = {};
    http:HttpConnectorError connectionError = {};
    constructAuthenticationHeaders(request);
    string requestPath = API_MEASURES + "?" + COMPONENT_KEY + "=" + projectKey + "&" + METRIC_KEY + "=" + metricName;
    var endpointResponse = clientEP -> get(requestPath, request);
    match endpointResponse {
        http:Response res => response = res;
        http:HttpConnectorError connectErr => connectionError = connectErr;
    }
    error err = {};
    if (connectionError.message != "") {
        err = {message:connectionError.message};
        throw err;
    }
    checkResponse(response);
    json component = getContentByKey(response, COMPONENT);
    json metricValue = component[MEASURES][0][VALUE];
    if (isAnEmptyJson(metricValue)) {
        err = {message:"Cannot find " + metricName.replace("_", " ") + " for this project."};
        throw err;
    }
    return metricValue.toString();
}

