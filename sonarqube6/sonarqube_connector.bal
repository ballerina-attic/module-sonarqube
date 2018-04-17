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

public type SonarQubeConnector object {
    private {
        http:Client client;
    }

    public function getProject(string projectName) returns (Project|error);
    public function getAllProjects() returns (Project[]|error);
    public function getDuplicatedCodeBlocksCount(string projectKey) returns (int|error);
    public function getDuplicatedFilesCount(string projectKey) returns (int|error);
    public function getDuplicatedLinesCount(string projectKey) returns (int|error);
    public function getBlockerIssuesCount(string projectKey) returns (int|error);
    public function getCriticalIssuesCount(string projectKey) returns (int|error);
    public function getMajorIssuesCount(string projectKey) returns (int|error);
    public function getMinorIssuesCount(string projectKey) returns (int|error);
    public function getOpenIssuesCount(string projectKey) returns (int|error);
    public function getConfirmedIssuesCount(string projectKey) returns (int|error);
    public function getReopenedIssuesCount(string projectKey) returns (int|error);
    public function getLinesOfCode(string projectKey) returns (int|error);
    public function getLineCoverage(string projectKey) returns (string)|error;
    public function getComplexity(string projectKey) returns (int|error);
    public function getCoveredLinesCount(string projectKey) returns (int|error);
    public function getBranchCoverage(string projectKey) returns (string|error);
    public function getCodeSmellsCount(string projectKey) returns (int|error);
    public function getSQALERating(string projectKey) returns (string|error);
    public function getTechnicalDebt(string projectKey) returns (string|error);
    public function getTechnicalDebtRatio(string projectKey) returns (string|error);
    public function getVulnerabilitiesCount(string projectKey) returns (int|error);
    public function getSecurityRating(string projectKey) returns (string|error);
    public function getReliabilityRating(string projectKey) returns (string|error);
    public function getBugsCount(string projectKey) returns (int|error);
    public function getIssues(string projectKey) returns (Issue[])|error;
    public function getMetricValues(string projectKey, string[] metricKeys) returns (map|error);
    function getMeasure(string projectKey, string metricName) returns string|error;
};

documentation{Returns a Project record.
    R{{Project}} Project record
    R{{error}} error record
}
public function SonarQubeConnector::getProject(string projectName) returns Project|error {
    endpoint http:Client httpEndpoint = self.client;

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                // check the results in the first page of Project List
                json[] allComponentsInPage = check getJsonArrayByKey(response, COMPONENTS);
                foreach component in allComponentsInPage {
                    Project project = convertJsonToProject(component);
                    if (projectName == project.name) {
                        return project;
                    }
                }
                // Cannot find results in the first page.Iterate through other pages
                json paging = check getJsonValueByKey(response, PAGING);
                // get the total project count
                float totalProjectsCount = check <float>(paging[TOTAL].toString() but { () => "0.0" });
                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = new;
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    endpointResponse = httpEndpoint -> get(requestPath, request);
                    match endpointResponse{
                        http:Response newResponse => {
                            endpointErrors = checkResponse(newResponse);
                            if (endpointErrors.message == ""){
                                allComponentsInPage = check getJsonArrayByKey(newResponse, COMPONENTS);
                                foreach component in allComponentsInPage {
                                    Project project = convertJsonToProject(component);
                                    if (projectName == project.name) {
                                        return project;
                                    }
                                }
                            } else {
                                return endpointErrors;
                            }
                        }
                        http:HttpConnectorError err => {
                            error connectionError = {message:err.message};
                            return connectionError;
                        }
                    }
                    count += 1;
                }
            }
            return endpointErrors;
        }
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}

documentation{Returns an array of all projects.
    R{{Project}} Project record
    R{{error}} error record
}
public function SonarQubeConnector::getAllProjects() returns (Project[]|error) {
    endpoint http:Client httpEndpoint = self.client;

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                Project[] projects = [];
                // check the results in the first page of Project List
                json[] allComponentsInPage = check getJsonArrayByKey(response, COMPONENTS);
                int projectCount = 0;
                foreach component in allComponentsInPage {
                    Project project = convertJsonToProject(component);
                    projects[projectCount] = project;
                    projectCount += 1;
                }
                // Cannot find results in the first page.Iterate through other pages
                json paging = check getJsonValueByKey(response, PAGING);
                // get the total project count
                float totalProjectsCount = check <float>(paging[TOTAL].toString() but { () => "0.0" });
                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = new;
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    endpointResponse = httpEndpoint -> get(requestPath, request);
                    match endpointResponse{
                        http:Response newResponse => {
                            endpointErrors = checkResponse(newResponse);
                            if (endpointErrors.message == ""){
                                allComponentsInPage = check getJsonArrayByKey(newResponse, COMPONENTS);
                                foreach component in allComponentsInPage {
                                    Project project = convertJsonToProject(component);
                                    projects[projectCount] = project;
                                    projectCount += 1;
                                }
                            } else {
                                return endpointErrors;
                            }
                        }
                        http:HttpConnectorError err => {
                            error connectionError = {message:err.message};
                            return connectionError;
                        }
                    }
                    count += 1;
                }
                return projects;
            }
            return endpointErrors;
        }
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}

documentation{Get values for provided metrics relavant to a project key.
    P{{projectKey}} Key of a project
    P{{metricKeys}} string array of metric keys
    R{{^"map"}} Returns a mapping  of metric name
    R{{error}} Returns error if an exception raised in getting project metric values
}
public function SonarQubeConnector::getMetricValues(string projectKey, string[] metricKeys) returns (map|error) {
    endpoint http:Client httpEndpoint = self.client;
    string keyList = "";
    foreach key in metricKeys {
        keyList = keyList + key + ",";
    }

    http:Request request = new;
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + keyList;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                map values;
                json component = check getJsonValueByKey(response, COMPONENT);
                json[] metrics = check < json[]>component[MEASURES];
                foreach metric in metrics {
                    string metricKey = metric[METRIC].toString() but { () => "" };
                    if (metricKey != ""){
                        string value = metric[VALUE].toString() but { () => "" };
                        values[metricKey] = value;
                    } else {
                        values[metricKey] = "Not defined for the product.";
                    }
                }
                return values;
            }
            return endpointErrors;
        }
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}

documentation{Get complexity of a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} Returns complexity of a project.Complexity calculated based on the number of paths through
 the code.
    R{{error}} Returns error if an exception raised in getting project metric values
}
public function SonarQubeConnector::getComplexity(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, COMPLEXITY);
    return <int>value;
}

documentation{Get number of duplicated code blocks.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of duplicated code blocks in a project the code
    R{{error}} Returns error if an exception raised in getting duplicated blocks count
}
public function SonarQubeConnector::getDuplicatedCodeBlocksCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_BLOCKS_COUNT);
    return <int>value;
}

documentation{Get Number of duplicated files.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of duplicated files in a project the code
    R{{error}} Returns error if an exception raised in getting dupl
}
public function SonarQubeConnector::getDuplicatedFilesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_FILES_COUNT);
    return <int>value;
}

documentation{Get Number of duplicated lines.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of duplicated lines in a project the code
    R{{error}} Returns error if an exception raised in getting duplicated files count
}
public function SonarQubeConnector::getDuplicatedLinesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_LINES_COUNT);
    return <int>value;
}

documentation{Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately
fixed.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of blocker issues in a project the code
    R{{error}} Returns error if an exception raised in getting blocker issues count
}
public function SonarQubeConnector::getBlockerIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, BLOCKER_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of critical issues in a project.Either a bug with a low probability to impact the behavior
of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ...
The code MUST be immediately reviewed.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of critical issues in a project the code
    R{{error}} Returns error if an exception raised in getting critical issues count
}
public function SonarQubeConnector::getCriticalIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CRITICAL_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of major issues in a project.Quality flaw which can highly impact the developer productivity:
uncovered piece of code, duplicated blocks, unused parameters, ...
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of major issues in a project the code
    R{{error}} Returns error if an exception raised in getting major issues count
}
public function SonarQubeConnector::getMajorIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, MAJOR_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of minor issues in a project.Quality flaw which can slightly impact the developer
productivity: lines should not be too long, switch statements should have at least 3 cases, ....
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of minor issues in a project the code
    R{{error}} Returns error if an exception raised in getting minor issues count
}
public function SonarQubeConnector::getMinorIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, MINOR_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of open issues in a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of open issues in a project the code
    R{{error}} Returns error if an exception raised in getting open issues count
}
public function SonarQubeConnector::getOpenIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, OPEN_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of confirmed issues in a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of confirmed issues in a project the code
    R{{error}} Returns error if an exception raised in getting confirmed issues count
}
public function SonarQubeConnector::getConfirmedIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CONFIRMED_ISSUES_COUNT);
    return <int>value;
}

documentation{Number of reopened issues in a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of reopened issues in a project the code
    R{{error}} Returns error if an exception raised in getting reopened issues count
}
public function SonarQubeConnector::getReopenedIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, REOPENED_ISSUES_COUNT);
    return <int>value;
}

documentation{Get lines of code of a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns returns project LOC
    R{{error}} Returns error if an exception raised in getting lines of code issues count
}
public function SonarQubeConnector::getLinesOfCode(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, LINES_OF_CODE);
    return <int>value;
}

documentation{Get line coverage of a project.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns line coverage of a project
    R{{error}} Returns error if an exception raised in getting line coverage
}
public function SonarQubeConnector::getLineCoverage(string projectKey) returns (string)|error {
    string value = check self.getMeasure(projectKey, LINE_COVERAGE);
    return value + "%";
}

documentation{Get number of lines covered by unit tests.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of covered lines
    R{{error}} Returns error if an exception raised in getting lines covered by unit tests
}
public function SonarQubeConnector::getCoveredLinesCount(string projectKey) returns (int|error) {
    int linesToCover = check <int>check self.getMeasure(projectKey, LINES_TO_COVER);
    int uncoveredLines = check <int>check self.getMeasure(projectKey, UNCOVERED_LINES);
    return linesToCover - uncoveredLines;
}

documentation{Get branch coverage of a project.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns branch Coverage of a project
    R{{error}} Returns error if an exception raised in getting branch coverage
}
public function SonarQubeConnector::getBranchCoverage(string projectKey) returns (string|error) {
    string value = check self.getMeasure(projectKey, BRANCH_COVERAGE);
    return value + "%";
}

documentation{Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
 of a program that possibly indicates a deeper problem.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of code smells in a project
    R{{error}} Returns error if an exception raised in getting number of code smells
}
public function SonarQubeConnector::getCodeSmellsCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CODE_SMELLS);
    return <int>value;
}

documentation{Get SQALE rating of a project.This is the rating given to your project related to the value of your
 Technical Debt Ratio.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns sqale rating of a project
    R{{error}} Returns error if an exception raised in getting SQALE rating
}
public function SonarQubeConnector::getSQALERating(string projectKey) returns (string|error) {
    float floatValue = check <float>check self.getMeasure(projectKey, SQALE_RATING);
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

documentation{Get technical debt of a project.Technical debt is the effort to fix all maintainability issues.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns technical debt of a project
    R{{error}} Returns error if an exception raised in getting technical debt
}
public function SonarQubeConnector::getTechnicalDebt(string projectKey) returns (string|error) {
    return self.getMeasure(projectKey, TECHNICAL_DEBT);
}

documentation{Get technical debt ratio of a project.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns technical debt ratio of a project
    R{{error}} Returns error if an exception raised in getting technical debt ratio
}
public function SonarQubeConnector::getTechnicalDebtRatio(string projectKey) returns (string|error) {
    return self.getMeasure(projectKey, TECHNICAL_DEBT_RATIO);
}

documentation{Get number of vulnerablities of a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of vulnerabilities of  project
    R{{error}} Returns error if an exception raised in getting vulnerabilities count
}
public function SonarQubeConnector::getVulnerabilitiesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, VULNERABILITIES);
    return <int>value;
}

documentation{Get security rating of a project.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns 	security rating of a project
    R{{error}} Returns error if an exception raised in getting security rating
}
public function SonarQubeConnector::getSecurityRating(string projectKey) returns (string|error) {
    string value = check self.getMeasure(projectKey, SECURITY_RATING);
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

documentation{Get number of bugs in a project.
    P{{projectKey}} Key of a project
    R{{^"int"}} returns number of bugs of  project
    R{{error}} Returns error if an exception raised in getting bugs count
}
public function SonarQubeConnector::getBugsCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, BUGS_COUNT);
    return <int>value;
}

documentation{Get reliability rating of a project.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns reliability rating of a project
    R{{error}} Returns error if an exception raised in getting reliability rating
}
public function SonarQubeConnector::getReliabilityRating(string projectKey) returns (string|error) {
    string value = check self.getMeasure(projectKey, RELIABILITY_RATING);
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

documentation{Get details of project issues.
    P{{projectKey}} Key of a project
    R{{^"string"}} returns array of project issues
    R{{error}} Returns error if an exception raised in getting project issues
}
public function SonarQubeConnector::getIssues(string projectKey) returns (Issue[]|error) {
    endpoint http:Client httpEndpoint = self.client;
    http:Request request = new;
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
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}
