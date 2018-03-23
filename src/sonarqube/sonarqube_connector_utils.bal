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

package src;

import ballerina/net.http;
import ballerina/util;

@Description {value:"Setup SonarQue environment."}
public function <Connector connector> initConnection (string serverURL, string username, string password) {
    endpoint http:ClientEndpoint clientEP {targets:[{uri:DEFAULT_URL}]};
    connector.sonarqubeEP = clientEP;
    connector.setUser(username);
    connector.setPassword(password);
}

@Description {value:"Add authentication headers to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function constructAuthenticationHeaders (http:Request request,string username,string password) {
    if (username != "" && password != "") {
        request.addHeader("Authorization", "Basic " + util:base64Encode(username + ":" + password));
    } else {
        error err = {message:"Username and password should be provided."};
        throw err;
    }
}
