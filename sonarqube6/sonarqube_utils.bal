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

import ballerina/http;

function getJsonValueByKey(http:Response response, string key) returns (json|error) {
    var value = response.getJsonPayload();
    if (value is json) {
        return value[key];
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occured when extracting payload from response" });
        return err;
    }
}

function getJsonArrayByKey(http:Response response, string key) returns json[]|error {
    var payload = response.getJsonPayload();
    if (payload is json) {
        if (payload[key] != ()){
            json[] array = check json[].convert(payload[key]);
            return array;
        } else {
            json[] output =[];
            return output;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message:"Error occured while extracting the payload from response."});
        return err;
    }
}

function checkResponse(http:Response response) returns error {
    json[] responseJson = check getJsonArrayByKey(response, ERRORS);
    error err = error(SONARQUBE_ERROR_CODE, { message: "" });
    if (responseJson.length() > 0) {
        foreach json item in responseJson {
            string errorMessage = item.msg.toString();
            err.detail().message = errorMessage;
        }
        return err;
    }
    return err;
}

function Client.getMeasure(string projectKey, string metricName) returns string|error {
    string value = "";
    http:Request request = new;
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + metricName;
    var endpointResponse = self.sonarQubeClient->get(requestPath);

    // match endpointResponse
    if (endpointResponse is http:Response) {
        error endpointErrors = checkResponse(endpointResponse);
        if (<string>endpointErrors.detail().message == "") {
            return endpointErrors;
        } else {
            json component = check getJsonValueByKey(endpointResponse, COMPONENT);
            var result = json[].convert(component[MEASURES]);
            if (result is json[]) {
                json[] metricArray = result;
                if (result.length() == 0) {
                    error err = error(SONARQUBE_ERROR_CODE, { message: "Metric array is empty" });
                    return err;
                }
                json metricValue = metricArray[0][VALUE];
                return metricValue.toString();
            } else {
                error err = error(SONARQUBE_ERROR_CODE
                , { message: " Error occurred while invoking the sonarqube API" });
                return err;
            }
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: " Error occurred while invoking the sonarqube API" });
        return err;
    }
}
