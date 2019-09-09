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
import ballerina/http;

SonarQubeBasicAuthProvider outboundBasicAuthProvider = new({
    username: "9784bd93cd85c2242c0eae1c5b53f1c969dfef4b"
});

http:BasicAuthHandler outboundBasicAuthHandler = new(outboundBasicAuthProvider);

SonarQubeConfiguration sonarqubeConfig = {
    baseUrl: "https://sonarcloud.io",
    clientConfig: {
        auth: {
            authHandler: outboundBasicAuthHandler
        },
        secureSocket: {
        trustStore: {
            path: "/usr/lib/ballerina/ballerina-1.0.0-rc1-SNAPSHOT/distributions/jballerina-1.0.0-rc1-SNAPSHOT/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
        }
    }
};

Client sonarqube = new(sonarqubeConfig);

@test:Config {
    groups: ["network-calls"]
}
function testGetProject() {
    log:printInfo("sonarqubeEndpoint -> getProject()");
    var projectDetails = sonarqube->getProject("ScalablePress4j");
    if (projectDetails is Project) {
        boolean hasParameter = (projectDetails.name == "") ? false : true;
        test:assertEquals(hasParameter, true, msg = "Failed getProject()");
    } else {
        test:assertFail(msg = <string>projectDetails.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetAllProjects() {
    log:printInfo("sonarqubeEndpoint -> getAllProjects()");
    var value = sonarqube->getAllProjects();
    if (value is error) {
        test:assertFail(msg = <string>value.detail()?.message);
    } else {
        boolean hasParameter = (value.length() > 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getAllProjects()");
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetComplexity() {
    log:printInfo("sonarqubeEndpoint -> getComplexity(projectKey)");
    var value = sonarqube->getComplexity("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getComplexity(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedCodeBlocksCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedCodeBlocksCount((projectKey)");
    var value = sonarqube->getDuplicatedCodeBlocksCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedCodeBlocksCount((projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedFilesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedFilesCount(projectKey)");
    var value = sonarqube->getDuplicatedFilesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedFilesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetDuplicatedLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedLinesCount(projectKey)");
    var value = sonarqube->getDuplicatedLinesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedLinesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCoveredLinesCount() {
    log:printInfo("sonarqubeEndpoint -> getCoveredLinesCount(projectKey)");
    var value = sonarqube->getCoveredLinesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCoveredLinesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetBlockerIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getBlockerIssuesCount(projectKey)");
    var value = sonarqube->getBlockerIssuesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBlockerIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCriticalIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getCriticalIssuesCount(projectKey)");
    var value = sonarqube->getCriticalIssuesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCriticalIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetMajorIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getMajorIssuesCount(projectKey)");
    var value = sonarqube->getMajorIssuesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getMajorIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetOpenIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getOpenIssuesCount(projectKey)");
    var value = sonarqube->getOpenIssuesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getOpenIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetConfirmedIssuesCount() {
    log:printInfo("sonarqubeEndpoint -> getConfirmedIssuesCount(projectKey)");
    var value = sonarqube->getConfirmedIssuesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getConfirmedIssuesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetLinesOfCode() {
    log:printInfo("sonarqubeEndpoint -> getLinesOfCode(projectKey)");
    var value = sonarqube->getLinesOfCode("mailgun");
    if (value is int) {
        boolean hasParameter = (value > 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getLinesOfCode(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetCodeSmellsCount() {
    log:printInfo("sonarqubeEndpoint -> getCodeSmellsCount(projectKey)");
    var value = sonarqube->getCodeSmellsCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getCodeSmellsCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}


@test:Config {
    groups: ["network-calls"]
}
function testGetVulnerabilitiesCount() {
    log:printInfo("sonarqubeEndpoint -> getVulnerabilitiesCount(projectKey)");
    var value = sonarqube->getVulnerabilitiesCount("mailgun");
    if (value is int) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getVulnerabilitiesCount(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetBugsCount() {
    log:printInfo("sonarqubeEndpoint -> getBugsCount(projectKey)");
    var value = sonarqube->getBugsCount("mailgun");
    if (value is int ) {
        boolean hasParameter = (value >= 0) ? true : false;
        test:assertEquals(hasParameter, true, msg = "Failed getBugsCount(projectKey)");
    } else {
    test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetLineCoverage() {
    log:printInfo("sonarqubeEndpoint -> getLineCoverage(projectKey)");
    var value = sonarqube->getLineCoverage("mailgun");
    if (value is string) {
        boolean hasCharacter = (value.indexOf("%") != -1) ? true : false;
        test:assertEquals(hasCharacter, true, msg = "Failed getLineCoverage(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetSQALERating() {
    log:printInfo("sonarqubeEndpoint -> getSQALERating(projectKey)");
    var value = sonarqube->getSQALERating("mailgun");
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getSQALERating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetTechnicalDebt() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebt(projectKey)");
    var value = sonarqube->getTechnicalDebt("mailgun");
    if (value is string ) {
        boolean notEmpty = (value != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebt(projectKey)");
    } else {
    test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetTechnicalDebtRatio() {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebtRatio(projectKey)");
    var value = sonarqube->getTechnicalDebtRatio("mailgun");
    if (value is string) {
        boolean notEmpty = (value != "") ? true : false;
        test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebtRatio(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetSecurityRating() {
    log:printInfo("sonarqubeEndpoint -> getSecurityRating(projectKey)");
    var value = sonarqube->getSecurityRating("mailgun");
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getSecurityRating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

@test:Config {
    groups: ["network-calls"]
}
function testGetReliability() {
    log:printInfo("sonarqubeEndpoint -> getReliabilityRating(projectKey)");
    var value = sonarqube->getReliabilityRating("mailgun");
    if (value is string) {
        boolean hasCharacters = false;
        if (value == "A" || value == "B" || value == "C" || value == "D" || value == "E") {
            hasCharacters = true;
        }
        test:assertEquals(hasCharacters, true, msg = "Failed getReliabilityRating(projectKey)");
    } else {
        test:assertFail(msg = <string>value.detail()?.message);
    }
}

