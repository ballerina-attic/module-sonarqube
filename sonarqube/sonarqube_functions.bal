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

package sonarqube;

import ballerina/mime;
import ballerina/net.http;

@Description {value:"Get project specified by name from SonarQube server."}
@Param {value:"projectName:Name of the project."}
@Return {value:"project:Details of the project specified by name."}
function getProjectDetails (string projectName, Connector connector) returns (Project) {
    endpoint http:ClientEndpoint clientEP = connector.sonarqubeEP;
    http:Request request = {};
    http:Response response = {};
    http:HttpConnectorError connectionError = {};
    string username = connector.getUser();
    string password = connector.getPassword();
    constructAuthenticationHeaders(request, username, password);
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
    match convertedValue {
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
        project.setConnectionFactory(clientEP,username,password);
        return project;
    }
    json allProducts = getContentByKey(response, COMPONENTS);
    Project project = getProjectFromList(projectName, allProducts);
    if (project.key != "") {
        project.setConnectionFactory(clientEP,username,password);
        return project;
    }
    int totalPages = (value % PAGE_SIZE > 0) ? (value / PAGE_SIZE + 1) : value / PAGE_SIZE;
    int count = 0;
    while (count < totalPages - 1) {
        request = {};
        constructAuthenticationHeaders(request, username, password);
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
            project.setConnectionFactory(clientEP,username,password);
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
    mime:EntityError jsonErr = {};
    match getContent {
        mime:EntityError endpointErr => jsonErr = endpointErr;
        json content => jsonPayload = content;
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
        error err = {message:"Error in retrieving json payload."};
        throw err;
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
        Project project = <Project, getProjectDetails()>projectData;
        if (projectName == project.name) {
            return project;
        }
    }
    return {};
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http Response."}
@Return {value:"value: Value of the metric field in json."}
@Return {value:"err: if error occured in getting value of the measures field in the json."}
function getMetricValue (Project project, string metricName) returns (string) {
    endpoint http:ClientEndpoint clientEP = project.getConnectionFactory().sonarqubeEP;
    string username = project.getConnectionFactory().username;
    string password = project.getConnectionFactory().password;
    http:Response response = {};
    http:Request request = {};
    http:HttpConnectorError connectionError = {};
    constructAuthenticationHeaders(request,username,password);
    string requestPath = API_MEASURES + "?" + COMPONENT_KEY + "=" + project.key + "&" + METRIC_KEY + "=" + metricName;
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

