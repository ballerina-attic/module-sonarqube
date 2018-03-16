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

import ballerina.config;
import ballerina.net.http;
import ballerina.util;

http:HttpClient sonarqubeHTTPClient;

@Description {value:"get sonarqube http client object."}
@Return {value:"sonarqubeHTTPClient: sonarqube http client object."}
public function getHTTPClient () (http:HttpClient) {
    if (sonarqubeHTTPClient == null) {
        sonarqubeHTTPClient = create http:HttpClient(config:getGlobalValue(SERVER_URL), {chunking:"never"});
    }
    return sonarqubeHTTPClient;
}

@Description {value:"Add authentication headers to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function constructAuthenticationHeaders (http:OutRequest request) {
    string authType = config:getGlobalValue(AUTH_TYPE);
    error err = {};
    if (authType == USER) {
        string username = config:getGlobalValue(USERNAME);
        string password = config:getGlobalValue(PASSWORD);
        if (username == null || password == null) {
            if (username == null) {
                err = {message:"Username should be provided."};
                throw err;
            }
            if (password != null) {
                err = {message:"Password should be provided."};
                throw err;
            }
        } else {
            request.addHeader("Authorization", "Basic " + util:base64Encode(username + ":" + password));
        }
    } else if (authType == TOKEN) {
        string token = config:getGlobalValue(TOKEN);
        if (token == null) {
            err = {message:"Token should be provided."};
            throw err;
        } else {
            request.addHeader("Authorization", "Basic " + util:base64Encode(token + ":"));
        }
    } else {
        err = {message:"AuthType should be user or token."};
        throw err;
    }
}

