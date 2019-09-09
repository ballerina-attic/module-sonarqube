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

function getJsonValueByKey(http:Response response, string key) returns @tainted (json|error) {
    var value = response.getJsonPayload();
    if (value is map<json>) {
        return value[key];
    } else {
        error err = error(SONARQUBE_ERROR_CODE,  message = "Error occured when extracting payload from response" );
        return err;
    }
}

function getJsonArrayByKey(http:Response response, string key) returns @tainted json[]|error {
    var payload = response.getJsonPayload();
    if (payload is map<json>) {
        var jsonArr = payload[key];
        if (jsonArr is json[]){
            json[] array = check json[].constructFrom(<json[]>jsonArr);
            return array;
        } else {
            json[] output =[];
            return output;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, message="Error occured while extracting the payload from response.");
        return err;
    }
}

function checkResponse(http:Response response) returns  @tainted error {
    json[] responseJson = check getJsonArrayByKey(response, ERRORS);
    error err = error(SONARQUBE_ERROR_CODE, message = "" );
    if (responseJson.length() > 0) {
        foreach json item in responseJson {
            string errorMessage = item.msg.toString();
            err = error(SONARQUBE_ERROR_CODE, message=errorMessage);
            return err;
        }
        return err;
    }
    return err;
}

# Log and prepare `error` as a `Error`.
#
# + message - Error message
# + err - `error` instance
# + return - Prepared `Error` instance
public function prepareError(string message, error? err = ()) returns Error {
    Error authError;
    if (err is error) {
        authError = error(AUTH_ERROR, message = message, cause = err);
    } else {
        authError = error(AUTH_ERROR, message = message);
    }
    return authError;
}