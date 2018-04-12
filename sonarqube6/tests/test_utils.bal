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

import ballerina/config;

@Description {value:"Get SonarQube server URI."}
@Return {value:"returns SonarQube server URI."}
function getURI() returns string {
    return config:getAsString(SONARQUBE_URI);
}

@Description {value:"Get SonarQube server token."}
@Return {value:"returns SonarQube server token."}
function getToken() returns string {
    return config:getAsString(SONARQUBE_TOKEN);
}

@Description {value:"Get project key."}
@Return {value:"returns key of a project."}
function getProjectKey() returns string {
    return config:getAsString(PROJECT_KEY);
}

@Description {value:"Get project name."}
@Return {value:"returns name of a project."}
function getProjectName() returns string {
    return config:getAsString(PROJECT_NAME);
}

//-------------------Constants-------------------//
@final string SONARQUBE_TOKEN = "sonarqube_token";
@final string SONARQUBE_URI = "sonarqube_uri";
@final string PROJECT_KEY = "project_key";
@final string PROJECT_NAME = "project_name";
