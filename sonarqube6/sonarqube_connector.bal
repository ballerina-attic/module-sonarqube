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
import ballerina/log;
import ballerina/math;
import ballerina/io;

@Description {value:"Get project details."}
@Param {value:"projetName:Name of the project."}
@Return {value:"project:Project struct with project details."}
@Return {value:"err: Returns error if an exception raised in getting project details."}
public function SonarQubeConnector::getProject(string projectName) returns Project|error {
    endpoint http:ClientEndpoint httpEndpoint = clientEndpoint;

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = check constructAuthenticatedRequest();
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                // check the results in the first page of Project List
                json[] allComponents = check getJsonArrayByKey(response, COMPONENTS);
                Project project = getProjectFromList(projectName, allComponents);
                if (project.key != "") {
                    return project;
                }
                // Cannot find results in the first page.Iterate through other pages
                json paging = check getJsonValueByKey(response, PAGING);
                // get the total project count
                float totalProjectsCount = check <float>(paging[TOTAL].toString() but { () => "0.0" });
                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;
                project = {};

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = check constructAuthenticatedRequest();
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    endpointResponse = httpEndpoint -> get(requestPath, request);
                    match endpointResponse{
                        http:Response newResponse => {
                            endpointErrors = checkResponse(newResponse);
                            if (endpointErrors.message == ""){
                                json[] pageResult = check getJsonArrayByKey(newResponse, COMPONENTS);
                                Project sonarqubeProject = getProjectFromList(projectName, pageResult);
                                if (sonarqubeProject.key != "") {
                                    project = sonarqubeProject;
                                    break;
                                }
                            } else {
                                return endpointErrors;
                            }
                        }
                        http:HttpConnectorError err => return err;
                    }
                    count = count + 1;
                }
                return project;
            } else {
                return endpointErrors;
            }
        }
        http:HttpConnectorError err => return err;
    }
}

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project.Complexity calculated based on the number of paths through
 the code."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function SonarQubeConnector::getComplexity(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, COMPLEXITY);
    return <int>value;
}

@Description {value:"Get number of duplicated code blocks."}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated code blocks count."}
public function SonarQubeConnector::getDuplicatedCodeBlocksCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, DUPLICATED_BLOCKS);
    return <int>value;
}

@Description {value:"Get Number of duplicated files."}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated files count."}
public function SonarQubeConnector::getDuplicatedFilesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, DUPLICATED_FILES);
    return <int>value;
}

@Description {value:"Number of duplicated lines."}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated lines count."}
public function SonarQubeConnector::getDuplicatedLinesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, DUPLICATED_LINES);
    return <int>value;
}

@Description {value:"Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately
fixed."}
@Return {value:"blockerIssue:returns number of blocker issues in a project."}
@Return {value:"err: returns error if an exception raised in getting blocker issues count."}
public function SonarQubeConnector::getBlockerIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_BLOCKER);
    return <int>value;
}

@Description {value:"Number of critical issues in a project.Either a bug with a low probability to impact the behavior
of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ...
The code MUST be immediately reviewed. "}
@Return {value:"criticalIssue:returns number of critical issues in a project."}
@Return {value:"err: returns error if an exception raised in getting critical issues count."}
public function SonarQubeConnector::getCriticalIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_CRITICAL);
    return <int>value;
}

@Description {value:"Number of major issues in a project.Quality flaw which can highly impact the developer
 productivity: uncovered piece of code, duplicated blocks, unused parameters, ..."}
@Return {value:"minorIssue:returns number of minor issues in a project."}
@Return {value:"err: returns error if an exception raised in getting major issues count."}
public function SonarQubeConnector::getMajorIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_MAJOR);
    return <int>value;
}

@Description {value:"Number of minor issues in a project.Quality flaw which can slightly impact the developer
productivity: lines should not be too long, switch statements should have at least 3 cases, ..."}
@Return {value:"majorIssue:returns number of major issues in a project."}
@Return {value:"err: returns error if an exception raised in getting minor issues count."}
public function SonarQubeConnector::getMinorIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_MINOR);
    return <int>value;
}

@Description {value:"Number of open issues in a project."}
@Return {value:"issuesCount:returns number of open issues in a project."}
@Return {value:"err: returns error if an exception raised in getting open issues count."}
public function SonarQubeConnector::getOpenIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_OPEN);
    return <int>value;
}

@Description {value:"Number of confirmed issues in a project."}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised in getting confirmed issue count."}
public function SonarQubeConnector::getConfirmedIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_CONFIRMED);
    return <int>value;
}

@Description {value:"Number of reopened issues in a project."}
@Return {value:"reopenedIssues:returns number of reopened issues in a project."}
@Return {value:"err: returns error if an exception raised in getting re-opened issue count."}
public function SonarQubeConnector::getReopenedIssuesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, ISSUE_REOPENED);
    return <int>value;
}

@Description {value:"Get lines of code of a project."}
@Return {value:"loc: returns project LOC."}
@Return {value:"err: returns error if an exception raised in getting project LOC."}
public function SonarQubeConnector::getLinesOfCode(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, LOC);
    return <int>value;
}

@Description {value:"Get line coverage of a project."}
@Return {value:"lineCoverage:returns line coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting line coverage."}
public function SonarQubeConnector::getLineCoverage(string projectKey) returns (string)|error {
    string value = check getMeasure(projectKey, LINE_COVERAGE);
    return value + "%";
}

@Description {value:"Get number of lines covered by unit tests."}
@Return {value:"coveredLinesCount:returns number of covered lines."}
@Return {value:"err: returns error if an exception raised in getting covered lines count."}
public function SonarQubeConnector::getCoveredLinesCount(string projectKey) returns (int|error) {
    int linesToCover = check <int>check getMeasure(projectKey, LINES_TO_COVER);
    int uncoveredLines = check <int>check getMeasure(projectKey, UNCOVERED_LINES);
    return linesToCover - uncoveredLines;
}

@Description {value:"Get branch coverage of a project."}
@Return {value:"branchCoverage:returns branch Coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting branch coverage."}
public function SonarQubeConnector::getBranchCoverage(string projectKey) returns (string|error) {
    string value = check getMeasure(projectKey, BRANCH_COVERAGE);
    return value + "%";
}

@Description {value:"Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
 of a program that possibly indicates a deeper problem."}
@Return {value:"codeSmells: returns number of code smells in a project."}
@Return {value:"err: returns error if an exception raised in getting code smells count."}
public function SonarQubeConnector::getCodeSmellsCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, CODE_SMELLS);
    return <int>value;
}

@Description {value:"Get SQALE rating of a project.This is the rating given to your project related to the value of your
 Technical Debt Ratio."}
@Return {value:"sqaleRating:returns sqale rating of a project."}
@Return {value:"err: returns error if an exception raised in getting SQALE rating."}
public function SonarQubeConnector::getSQALERating(string projectKey) returns (string|error) {
    float floatValue = check <float>check getMeasure(projectKey, SQALE_RATING);
    int value = math:round(floatValue);
    if (value <= 5) {
        return "A";
    } else if (value <= 10) {
        return "B";
    } else if (value <= 20) {
        return "C";
    } else if (value <= 50) {
        return "D";
    }
    return "E";
}

@Description {value:"Get technical debt of a project.Technical debt is the effort to fix all maintainability issues."}
@Return {value:"technicalDebt: returns technical debt of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt."}
public function SonarQubeConnector::getTechnicalDebt(string projectKey) returns (string|error) {
    return getMeasure(projectKey, TECHNICAL_DEBT);
}

@Description {value:"Get technical debt ratio of a project."}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt ratio."}
public function SonarQubeConnector::getTechnicalDebtRatio(string projectKey) returns (string|error) {
    return getMeasure(projectKey, TECHNICAL_DEBT_RATIO);
}

@Description {value:"Get number of vulnerablities of a project."}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project."}
@Return {value:"err: returns error if an exception raised in getting vulnerabilities count."}
public function SonarQubeConnector::getVulnerabilitiesCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, VULNERABILITIES);
    return <int>value;
}

@Description {value:"Get security rating of a project."}
@Return {value:"securityRating:returns 	security rating of a project."}
@Return {value:"err: returns error if an exception raised in getting security rating."}
public function SonarQubeConnector::getSecurityRating(string projectKey) returns (string|error) {
    string value = check getMeasure(projectKey, SECURITY_RATING);
    if (value == NO_VULNERABILITY) {
        return "A";
    } else if (value == MINOR_VULNERABILITY) {
        return "B";
    } else if (value == MAJOR_VULNERABILITY) {
        return "C";
    } else if (value == CRITICAL_VULNERABILITY) {
        return "D";
    }
    return "E";
}

@Description {value:"Get number of bugs in a project."}
@Return {value:"bugs: returns number of bugs of  project."}
@Return {value:"err: returns error if an exception raised in getting bugs count."}
public function SonarQubeConnector::getBugsCount(string projectKey) returns (int|error) {
    string value = check getMeasure(projectKey, BUGS);
    return <int>value;
}

@Description {value:"Get reliability rating of a project."}
@Return {value:"securityRating:returns reliability rating of a project."}
@Return {value:"err: returns error if an exception raised in getting reliability rating."}
public function SonarQubeConnector::getReliabilityRating(string projectKey) returns (string|error) {
    string value = check getMeasure(projectKey, RELIABILITY_RATING);
    if (value == NO_BUGS) {
        return "A";
    } else if (value == MINOR_BUGS) {
        return "B";
    } else if (value == MAJOR_BUGS) {
        return "C";
    } else if (value == CRITICAL_BUGS) {
        return "D";
    }
    return "E";
}

@Description {value:"Get details of project issues."}
@Return {value:"issues: returns array of project issues."}
@Return {value:"err: returns error if an exception raised in getting project issues."}
public function SonarQubeConnector::getIssues(string projectKey) returns (Issue[]|error) {
    endpoint http:ClientEndpoint httpEndpoint = clientEndpoint;
    http:Request request = check constructAuthenticatedRequest();
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + projectKey + "&" + EXTRA_CONTENT;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            Issue[] issues = [];
            if (endpointErrors.message == ""){
                int i = 0;
                json issueList = check getJsonArrayByKey(response, ISSUES);
                foreach issue in issueList {
                    Issue issueStruct = convertJsonToIssue(issue);
                    issues[i] = issueStruct;
                    i = i + 1;
                }
            } else {
                return endpointErrors;
            }
            return issues;
        }
        http:HttpConnectorError err => return err;
    }
}
