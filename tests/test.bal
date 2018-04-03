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

package tests;

import ballerina/log;
import ballerina/test;
import sonarqube67;

endpoint sonarqube67:SonarQubeEndpoint sonarqube {
    token:TOKEN,
    uri:URI
};

@test:Config {
    groups:["network-calls"]
}
function testGetProject () {
    log:printInfo("sonarqubeEndpoint -> getProject()");
    sonarqube67:Project project = {};
    var projectDetails = sonarqube -> getProject("siddhi");
    match projectDetails {
        sonarqube67:Project projectInfo => project = projectInfo;
        error err => test:assertFail(msg = err.message);
    }
    boolean hasParameter = (project.name == "") ? false : true;
    test:assertEquals(hasParameter, true, msg = "Failed getProject()");
}

@test:Config {
    groups:["network-calls"]
}
function testGetComplexity () {
    log:printInfo("sonarqubeEndpoint -> getComplexity(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getComplexity(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getComplexity(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedCodeBlocksCount () {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedCodeBlocksCount((projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getDuplicatedCodeBlocksCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedCodeBlocksCount((projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedFilesCount () {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedFilesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getDuplicatedFilesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedFilesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetDuplicatedLinesCount () {
    log:printInfo("sonarqubeEndpoint -> getDuplicatedLinesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getDuplicatedLinesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getDuplicatedLinesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetBlockerIssuesCount () {
    log:printInfo("sonarqubeEndpoint -> getBlockerIssuesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getBlockerIssuesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getBlockerIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetCriticalIssuesCount () {
    log:printInfo("sonarqubeEndpoint -> getCriticalIssuesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getCriticalIssuesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getCriticalIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetMajorIssuesCount () {
    log:printInfo("sonarqubeEndpoint -> getMajorIssuesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getMajorIssuesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getMajorIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetOpenIssuesCount () {
    log:printInfo("sonarqubeEndpoint -> getOpenIssuesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getOpenIssuesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getOpenIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetConfirmedIssuesCount () {
    log:printInfo("sonarqubeEndpoint -> getConfirmedIssuesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getConfirmedIssuesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getConfirmedIssuesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetLinesOfCode () {
    log:printInfo("sonarqubeEndpoint -> getLinesOfCode(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getLinesOfCode(project.key);
    match value {
        int val => {boolean hasParameter = (val > 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getLinesOfCode(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetCodeSmellsCount () {
    log:printInfo("sonarqubeEndpoint -> getCodeSmellsCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getCodeSmellsCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getCodeSmellsCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}


@test:Config {
    groups:["network-calls"]
}
function testGetVulnerabilitiesCount () {
    log:printInfo("sonarqubeEndpoint -> getVulnerabilitiesCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getVulnerabilitiesCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getVulnerabilitiesCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetBugsCount () {
    log:printInfo("sonarqubeEndpoint -> getBugsCount(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getBugsCount(project.key);
    match value {
        int val => {boolean hasParameter = (val >= 0) ? true : false;
                    test:assertEquals(hasParameter, true, msg = "Failed getBugsCount(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetLineCoverage () {
    log:printInfo("sonarqubeEndpoint -> getLineCoverage(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getLineCoverage(project.key);
    match value {
        string val => {boolean hasCharacter = (val.indexOf("%") != -1) ? true : false;
                       test:assertEquals(hasCharacter, true, msg = "Failed getLineCoverage(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetSQALERating () {
    log:printInfo("sonarqubeEndpoint -> getSQALERating(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getSQALERating(project.key);
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
function testGetTechnicalDebt () {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebt(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getTechnicalDebt(project.key);
    match value {
        string val => {boolean notEmpty = (val != "") ? true : false;
                       test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebt(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetTechnicalDebtRatio () {
    log:printInfo("sonarqubeEndpoint -> getTechnicalDebtRatio(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getTechnicalDebtRatio(project.key);
    match value {
        string val => {boolean notEmpty = (val != "") ? true : false;
                       test:assertEquals(notEmpty, true, msg = "Failed getTechnicalDebtRatio(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}

@test:Config {
    groups:["network-calls"]
}
function testGetSecurityRating () {
    log:printInfo("sonarqubeEndpoint -> getSecurityRating(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getSecurityRating(project.key);
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
function testGetReliability () {
    log:printInfo("sonarqubeEndpoint -> getReliabilityRating(projectKey)");
    sonarqube67:Project project = {key:PROJECT_KEY};
    var value = sonarqube -> getReliabilityRating(project.key);
    match value {
        string val => {boolean hasCharacters = false;
                       if (val == "A" || val == "B" || val == "C" || val == "D" || val == "E") {
                           hasCharacters = true;
                       }
                       test:assertEquals(hasCharacters, true, msg = "Failed getReliabilityRating(projectKey)");}
        error err => test:assertFail(msg = err.message);
    }
}
