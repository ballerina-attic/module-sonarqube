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

import ballerina/log;
import ballerina/test;
import ballerina/config;

endpoint Client sonarqube {
    clientConfig:{
        url:config:getAsString(SONARQUBE_URI),
        auth:{
            scheme:"basic",
            username:config:getAsString(SONARQUBE_TOKEN),
            password:""
        }
    }
};

@test:Config {
    groups:["network-calls"]
}
function testGetProject() {
    log:printInfo("sonarqubeEndpoint -> getProject()");
    var projectDetails = sonarqube -> getProject(config:getAsString(PROJECT_NAME));
    match projectDetails {
        Project project => {
            boolean hasParameter = (project.name == "") ? false : true;
            test:assertEquals(hasParameter, true, msg = "Failed getProject()");
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetAllProjects() {
    log:printInfo("sonarqubeEndpoint -> getAllProjects()");
    var value = sonarqube -> getAllProjects();
    match value {
        Project[] projects => {
            boolean hasParameter = (lengthof projects > 0) ? true : false;
            test:assertEquals(hasParameter, true, msg = "Failed getAllProjects()");
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetMetricValues() {
    log:printInfo("sonarqubeEndpoint -> getMetricValues(projectKey,metricKeys[])");
    string[] metricKeys = [LINE_COVERAGE, LINES_OF_CODE];
    var value = sonarqube -> getMetricValues(config:getAsString(PROJECT_KEY), metricKeys);
    match value {
        map val => {
            boolean hasParameter = (lengthof val == lengthof metricKeys) ? true : false;
            test:assertEquals(hasParameter, true, msg = "Failed getMetricValues(projectKey,metricKeys[])");
        }
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetComplexity() {
    log:printInfo("sonarqubeEndpoint -> getComplexity(projectKey)");
    var value = sonarqube -> getComplexity(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getComplexity(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedCodeBlocksCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedCodeBlocksCount((projectKey)");
    var value = sonarqube -> getDuplicatedCodeBlocksCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedCodeBlocksCount((projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedFilesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedFilesCount(projectKey)");
    var value = sonarqube -> getDuplicatedFilesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedFilesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedLinesCount(projectKey)");
    var value = sonarqube -> getDuplicatedLinesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedLinesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetCoveredLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getCoveredLinesCount(projectKey)");
    var value = sonarqube -> getCoveredLinesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCoveredLinesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetBlockerIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getBlockerIssuesCount(projectKey)");
    var value = sonarqube -> getBlockerIssuesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBlockerIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetCriticalIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getCriticalIssuesCount(projectKey)");
    var value = sonarqube -> getCriticalIssuesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCriticalIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetMajorIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getMajorIssuesCount(projectKey)");
    var value = sonarqube -> getMajorIssuesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getMajorIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetOpenIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getOpenIssuesCount(projectKey)");
    var value = sonarqube -> getOpenIssuesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getOpenIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetConfirmedIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getConfirmedIssuesCount(projectKey)");
    var value = sonarqube -> getConfirmedIssuesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getConfirmedIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetLinesOfCode() {
    log:printInfo("sonarqubeEndpoint -> getLinesOfCode(projectKey)");
    var value = sonarqube -> getLinesOfCode(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val > 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getLinesOfCode(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetCodeSmellsCount() {
    log:printInfo("sonarqubeEndpoint -> getCodeSmellsCount(projectKey)");
    var value = sonarqube -> getCodeSmellsCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCodeSmellsCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}


@test:Config {
    groups:["network-calls"]
}
function testGetVulnerabilitiesCount() {
    log:printInfo("sonarqubeEndpoint -> getVulnerabilitiesCount(projectKey)");
    var value = sonarqube -> getVulnerabilitiesCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getVulnerabilitiesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetBugsCount() {
    log:printInfo("sonarqubeEndpoint -> getBugsCount(projectKey)");
    var value = sonarqube -> getBugsCount(config:getAsString(PROJECT_KEY));
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBugsCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetLineCoverage() {
    log:printInfo("sonarqubeEndpoint -> getLineCoverage(projectKey)");
    var value = sonarqube -> getLineCoverage(config:getAsString(PROJECT_KEY));
    match value {
        string val => {boolean hasCharacter = (val.indexOf("%") != -1) ? true : false;
        test:assertEquals(hasCharacter, true, msg = "Failed getLineCoverage(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetSQALERating() {
    log:printInfo("sonarqubeEndpoint -> getSQALERating(projectKey)");
    var value = sonarqube -> getSQALERating(config:getAsString(PROJECT_KEY));
    match value {
        string val => {
            boolean hasCharacters = false;
            if (val == "A" || val == "B" || val == "C" || val == "D" || val == "E") {
                hasCharacters = true;
            }
            test:assertEquals(hasCharacters, true, msg = "Failed getSQALERating(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetTechnicalDebt() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebt(projectKey)");
    var value = sonarqube -> getTechnicalDebt(config:getAsString(PROJECT_KEY));
    match value {
        string val => {boolean notEmpty = (val != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebt(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetTechnicalDebtRatio() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebtRatio(projectKey)");
    var value = sonarqube -> getTechnicalDebtRatio(config:getAsString(PROJECT_KEY));
    match value {
        string val => {boolean notEmpty = (val != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebtRatio(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetSecurityRating() {
    log:printInfo("sonarqubeEndpoint -> getSecurityRating(projectKey)");
    var value = sonarqube -> getSecurityRating(config:getAsString(PROJECT_KEY));
    match value {
        string val => {boolean hasCharacters = false;
        if (val == "A" || val == "B" || val == "C" || val == "D" || val == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getSecurityRating(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetReliability() {
    log:printInfo("sonarqubeEndpoint -> getReliabilityRating(projectKey)");
    var value = sonarqube -> getReliabilityRating(config:getAsString(PROJECT_KEY));
    match value {
        string val => {boolean hasCharacters = false;
        if (val == "A" || val == "B" || val == "C" || val == "D" || val == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getReliabilityRating(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

//-------------------Constants-------------------//
@final string SONARQUBE_TOKEN = "sonarqube_token";
@final string SONARQUBE_URI = "sonarqube_uri";
@final string PROJECT_KEY = "project_key";
@final string PROJECT_NAME = "project_name";
