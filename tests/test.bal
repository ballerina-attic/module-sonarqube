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

package test;

import ballerina/io;
import sonarqube;

public function main (string[] args) {

    endpoint sonarqube:SonarQubeEndpoint sonarqubeEP {
        token:args[1],
        uri:args[0],
        clientConfig:{}
    };

    //Get project
    sonarqube:Project project = {};
    var projectDetails = sonarqubeEP -> getProject(args[2]);
    match projectDetails {
        sonarqube:Project projectInfo => project = projectInfo;
        error err => io:println(err);
    }

    //Get project complexity
    var complexity = sonarqubeEP -> getComplexity(project.key);
    match complexity {
        string value => io:println("Complexity - " + value);
        error err => io:println(err);
    }

    //Get duplicated blocks count of the project
    var duplicatedBlocksCount = sonarqubeEP -> getDuplicatedCodeBlocksCount(project.key);
    match duplicatedBlocksCount {
        int value => io:println("Duplicated blocks count - " + value);
        error err => io:println(err);
    }

    //Get duplicated files count of the project
    var duplicatedFilesCount = sonarqubeEP -> getDuplicatedFilesCount(project.key);
    match duplicatedBlocksCount {
        int value => io:println("Duplicated Files count - " + value);
        error err => io:println(err);
    }

    //Get duplicated lines count of the project
    var duplicatedLinesCount = sonarqubeEP -> getDuplicatedLinesCount(project.key);
    match duplicatedLinesCount {
        int value => io:println("Duplicated lines count - " + value);
        error err => io:println(err);
    }

    //Get blocker issues count of the project
    var blockerIssueCount = sonarqubeEP -> getBlockerIssuesCount(project.key);
    match blockerIssueCount {
        int value => io:println("Blocker issues count - " + value);
        error err => io:println(err);
    }

    //Get critical issues count of the project
    var criticalIssueCount = sonarqubeEP -> getCriticalIssuesCount(project.key);
    match criticalIssueCount {
        int value => io:println("Critical issues count - " + value);
        error err => io:println(err);
    }

    //Get major issues count of the project
    var majorIssueCount = sonarqubeEP -> getMajorIssuesCount(project.key);
    match majorIssueCount {
        int value => io:println("Major issues count - " + value);
        error err => io:println(err);
    }

    //Get open issues count of the project
    var openIssuesCount = sonarqubeEP -> getOpenIssuesCount(project.key);
    match openIssuesCount {
        int value => io:println("Open issues count - " + value);
        error err => io:println(err);
    }

    //Get confirmed issues count count of the project
    var confirmedIssueCount = sonarqubeEP -> getConfirmedIssuesCount(project.key);
    match confirmedIssueCount {
        int value => io:println("Confirmed issues count - " + value);
        error err => io:println(err);
    }

    //Get project LOC
    var lines = sonarqubeEP -> getLinesOfCode(project.key);
    match lines {
        int value => io:println("LOC - " + value);
        error err => io:println(err);
    }

    //Get uncovered lines count
    var uncoveredLinesCount = sonarqubeEP -> getUncoveredLinesCount(project.key);
    match uncoveredLinesCount {
        int value => io:println("Number of lines not covered by unit tests - " + value);
        error err => io:println(err);
    }

    //Get number of lines should be covered by unit tests
    var linesToCover = sonarqubeEP -> getNumberOfLinesToCover(project.key);
    match linesToCover {
        int value => io:println("Lines should be covered by unit tests - " + value);
        error err => io:println(err);
    }

    //Get code smells count of the project
    var codeSmellsCount = sonarqubeEP -> getCodeSmellsCount(project.key);
    match codeSmellsCount {
        int value => io:println("Code smells  - " + value);
        error err => io:println(err);
    }

    //Get SQALE rating of the project
    var sqaleRating = sonarqubeEP -> getSQALERating(project.key);
    match sqaleRating {
        string value => io:println("SQALE rating  - " + value);
        error err => io:println(err);
    }

    //Get technical debt of the project
    var technicalDebt = sonarqubeEP -> getTechnicalDebt(project.key);
    match technicalDebt {
        string value => io:println("Technical Debt  - " + value);
        error err => io:println(err);
    }

    //Get technical debt ratio of the project
    var technicalDebtRatio = sonarqubeEP -> getTechnicalDebtRatio(project.key);
    match technicalDebtRatio {
        string value => io:println("Technical debt ratio  - " + value);
        error err => io:println(err);
    }

    //Get vulnerabilities count of the project
    var vulnerabilities = sonarqubeEP -> getVulnerabilitiesCount(project.key);
    match vulnerabilities {
        int value => io:println("Vulnerabilities  - " + value);
        error err => io:println(err);
    }

    //Get security rating of the project
    var securityRating = sonarqubeEP -> getSecurityRating(project.key);
    match securityRating {
        string value => io:println("Security Rating  - " + value);
        error err => io:println(err);
    }

    //Get bugs count of the project
    var bugsCount = sonarqubeEP -> getBugsCount(project.key);
    match bugsCount {
        int value => io:println("Bugs count  - " + value);
        error err => io:println(err);
    }

    //Get reliability rating of the project
    var reliabilityRating = sonarqubeEP -> getReliabilityRating(project.key);
    match codeSmellsCount {
        int value => io:println("Reliability rating  - " + value);
        error err => io:println(err);
    }

    //Get project issues
    var projectIssues = sonarqubeEP -> getIssues(project.key);
    match projectIssues {
        sonarqube:Issue[] issueList => io:println(issueList);
        error err => io:println(err);
    }
}
