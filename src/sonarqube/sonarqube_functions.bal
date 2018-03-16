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
    http:HttpConnectorError httpError;
    constructAuthenticationHeaders(request);
    request.setHeader(CONTENT_TYPE, APPLICATION_JSON);
    request.setJsonPayload(payload);
    response, httpError = sonarqubeEP.post(requestPath, request);
    error err = null;
    try {
        if (httpError != null) {
            err = {message:name + " is unsuccessful " + httpError.message};
            throw err;
        }
        checkResponse(response);
    } catch (error doOperationError) {
        doOperationError.message = name + " is unsuccessful." + doOperationError.message;
        return doOperationError;
    }
    return err;
}
