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

SonarQubeConfiguration sonarqubeConfig = {
    baseUrl: config:getAsString(SONARQUBE_URI),
    clientConfig: {
        auth: {
            scheme: http:BASIC_AUTH,
            username: config:getAsString(SONARQUBE_TOKEN),
            password: ""
        }
    }
};

Client sonarqube = new(sonarqubeConfig);

@test:Config {
    groups: ["network-calls"]
}
function testGetProject() {
    log:printInfo("sonarqubeEndpoint -> getProject()");
    var projectDetails = sonarqube->getProject(config:getAsString(PROJECT_NAME));
    if (projectDetails is Project) {
        boolean hasParameter = (projectDetails.name == "") ? false : true;
        test:assertEquals(hasParameter, true, msg = "Failed getProject()");
    } else {
        test:assertFail(msg = <string>projectDetails.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetAllProjects() {
    log:printInfo("sonarqubeEndpoint -> getAllProjects()");
    var value = sonarqube->getAllProjects();
    if (value is error) {
        test:assertFail(msg = <string>value.detail().message);
    } else {
        boolean hasParameter = (value.length() > 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getAllProjects()");
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetMetricValues() {
    log:printInfo("sonarqubeEndpoint -> getMetricValues(projectKey,metricKeys[])");
    string[] metricKeys = [LINE_COVERAGE, LINES_OF_CODE];
    var value = sonarqube->getMetricValues(config:getAsString(PROJECT_KEY), metricKeys);
    if (value is error) {
        test:assertFail(msg = <string>value.detail().message);
    } else {
        boolean hasParameter = (value.length() == metricKeys.length()) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getMetricValues(projectKey,metricKeys[])");
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetComplexity() {
    log:printInfo("sonarqubeEndpoint -> getComplexity(projectKey)");
    var value = sonarqube->getComplexity(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getComplexity(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedCodeBlocksCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedCodeBlocksCount((projectKey)");
    var value = sonarqube->getDuplicatedCodeBlocksCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedCodeBlocksCount((projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedFilesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedFilesCount(projectKey)");
    var value = sonarqube->getDuplicatedFilesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedFilesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedLinesCount(projectKey)");
    var value = sonarqube->getDuplicatedLinesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedLinesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCoveredLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getCoveredLinesCount(projectKey)");
    var value = sonarqube->getCoveredLinesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCoveredLinesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetBlockerIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getBlockerIssuesCount(projectKey)");
    var value = sonarqube->getBlockerIssuesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBlockerIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCriticalIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getCriticalIssuesCount(projectKey)");
    var value = sonarqube->getCriticalIssuesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCriticalIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetMajorIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getMajorIssuesCount(projectKey)");
    var value = sonarqube->getMajorIssuesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getMajorIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOpenIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getOpenIssuesCount(projectKey)");
    var value = sonarqube->getOpenIssuesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getOpenIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetConfirmedIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getConfirmedIssuesCount(projectKey)");
    var value = sonarqube->getConfirmedIssuesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getConfirmedIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetLinesOfCode() {
    log:printInfo("sonarqubeEndpoint -> getLinesOfCode(projectKey)");
    var value = sonarqube->getLinesOfCode(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value > 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getLinesOfCode(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCodeSmellsCount() {
    log:printInfo("sonarqubeEndpoint -> getCodeSmellsCount(projectKey)");
    var value = sonarqube->getCodeSmellsCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCodeSmellsCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}


@test:Config {
    groups: ["network-calls"]
}
function testGetVulnerabilitiesCount() {
    log:printInfo("sonarqubeEndpoint -> getVulnerabilitiesCount(projectKey)");
    var value = sonarqube->getVulnerabilitiesCount(config:getAsString(PROJECT_KEY));
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getVulnerabilitiesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetBugsCount() {
    log:printInfo("sonarqubeEndpoint -> getBugsCount(projectKey)");
    var value = sonarqube->getBugsCount(config:getAsString(PROJECT_KEY));
    if (value is int ) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBugsCount(projectKey)");
    } else {
    test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetLineCoverage() {
    log:printInfo("sonarqubeEndpoint -> getLineCoverage(projectKey)");
    var value = sonarqube->getLineCoverage(config:getAsString(PROJECT_KEY));
    if (value is string) {
        boolean hasCharacter = (value.indexOf("%") != -1) ? true : false;
        test:assertEquals(hasCharacter, true, msg = "Failed getLineCoverage(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetSQALERating() {
    log:printInfo("sonarqubeEndpoint -> getSQALERating(projectKey)");
    var value = sonarqube->getSQALERating(config:getAsString(PROJECT_KEY));
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getSQALERating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetTechnicalDebt() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebt(projectKey)");
    var value = sonarqube->getTechnicalDebt(config:getAsString(PROJECT_KEY));
    if (value is string ) {
        boolean notEmpty = (value != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebt(projectKey)");
    } else {
    test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetTechnicalDebtRatio() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebtRatio(projectKey)");
    var value = sonarqube->getTechnicalDebtRatio(config:getAsString(PROJECT_KEY));
    if (value is string) {
        boolean notEmpty = (value != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebtRatio(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetSecurityRating() {
    log:printInfo("sonarqubeEndpoint -> getSecurityRating(projectKey)");
    var value = sonarqube->getSecurityRating(config:getAsString(PROJECT_KEY));
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getSecurityRating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetReliability() {
    log:printInfo("sonarqubeEndpoint -> getReliabilityRating(projectKey)");
    var value = sonarqube->getReliabilityRating(config:getAsString(PROJECT_KEY));
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getReliabilityRating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail().message);
    }
}

