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

@Description {value:"Initialize SonarQube endpoint."}
@Param {value:"sonarqubeConfig:Configuration from SonarQube."}
public function SonarQubeClient::init(SonarQubeConfiguration sonarqubeConfig) {
    http:HttpClient httpClient = http:createHttpClient(sonarqubeConfig.uri, sonarqubeConfig.clientConfig);
    sonarqubeConnector.token = sonarqubeConfig.token;
    sonarqubeConnector.clientEndpoint.httpClient = httpClient;
}

@Description {value:"Returns the connector that client code uses"}
@Return {value:"The connector that client code uses"}
function SonarQubeClient::getClient() returns SonarQubeConnector {
    return sonarqubeConnector;
}

@Description {value:"Start SonarQube connector endpoint."}
public function SonarQubeClient::start() {}

@Description {value:"Stop SonarQube connector endpoint."}
public function SonarQubeClient::stop() {}

@Description {value:"Register SonarQube connector endpoint."}
@Param {value:"typedesc: Accepts types of data (int, float, string, boolean, etc)"}
public function SonarQubeClient::register(typedesc serviceType) {}
