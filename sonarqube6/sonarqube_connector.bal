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
    http:Client client;

    # Returns a Project record.
    # + return - If the execution is successful returns a Project record else an error
    public function getProject(string projectName) returns (Project|error);

    # Returns an array of all projects.
    # + return - If the execution is successful returns an array of Project records else an error
    public function getAllProjects() returns (Project[]|error);

    # Get number of duplicated code blocks.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated code blocks else an error
    public function getDuplicatedCodeBlocksCount(string projectKey) returns (int|error);

    # Get Number of duplicated files.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated files else an error
    public function getDuplicatedFilesCount(string projectKey) returns (int|error);

    # Get Number of duplicated lines.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated lines else an error
    public function getDuplicatedLinesCount(string projectKey) returns (int|error);

    # Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
    # the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be
    # immediately fixed..
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of blocker issues else an error
    public function getBlockerIssuesCount(string projectKey) returns (int|error);

    # Number of critical issues in a project.Either a bug with a low probability to impact the behavior
    # of the application in production or an issue which represents a security flaw: empty catch block, SQL injection,
    # The code MUST be immediately reviewed..
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of critical issues else an error
    public function getCriticalIssuesCount(string projectKey) returns (int|error);

    # Number of major issues in a project.Quality flaw which can highly impact the developer productivity:
    # uncovered piece of code, duplicated blocks, unused parameters, ...
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of major issues else an error
    public function getMajorIssuesCount(string projectKey) returns (int|error);

    # Number of minor issues in a project.Quality flaw which can slightly impact the developer
    # productivity: lines should not be too long, switch statements should have at least 3 cases, ....
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of minor issues else an error
    public function getMinorIssuesCount(string projectKey) returns (int|error);

    # Number of open issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of open issues else an error
    public function getOpenIssuesCount(string projectKey) returns (int|error);

    # Number of confirmed issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of confirmed issues else an error
    public function getConfirmedIssuesCount(string projectKey) returns (int|error);

    # Number of reopened issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of repoened issues else an error
    public function getReopenedIssuesCount(string projectKey) returns (int|error);

    # Get lines of code of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns lines of code else an error
    public function getLinesOfCode(string projectKey) returns (int|error);

    # Get line coverage of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns line coverage else an error
    public function getLineCoverage(string projectKey) returns (string)|error;

    # Get complexity of a project.Complexity calculated based on the number of paths through the code.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns complexity else an error
    public function getComplexity(string projectKey) returns (int|error);

    # Get number of lines covered by unit tests.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of covered lines else an error
    public function getCoveredLinesCount(string projectKey) returns (int|error);

    # Get branch coverage of a project.
    # + projectKey - Key of a project
    # + return - branch Coverage of a project or an error if an exception raised in getting branch coverage
    public function getBranchCoverage(string projectKey) returns (string|error);

    # Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
    # of a program that possibly indicates a deeper problem.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of code smells else an error
    public function getCodeSmellsCount(string projectKey) returns (int|error);

    # Get SQALE rating of a project.This is the rating given to your project related to the value of your
    # Technical Debt Ratio.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns SQALE rating else an error
    public function getSQALERating(string projectKey) returns (string|error);

    # Get technical debt of a project.Technical debt is the effort to fix all maintainability issues.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns technical debt else an error
    public function getTechnicalDebt(string projectKey) returns (string|error);

    # Get technical debt ratio of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns technical debt ratio else an error
    public function getTechnicalDebtRatio(string projectKey) returns (string|error);

    # Get number of vulnerablities of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of vulnerabilities else an error
    public function getVulnerabilitiesCount(string projectKey) returns (int|error);

    # Get security rating of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns security rating else an error
    public function getSecurityRating(string projectKey) returns (string|error);

    # Get reliability rating of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns reliability rating else an error
    public function getReliabilityRating(string projectKey) returns (string|error);

    # Get number of bugs in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of bugs else an error
    public function getBugsCount(string projectKey) returns (int|error);

    # Get details of project issues.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns an array of Issue records else an error
    public function getIssues(string projectKey) returns (Issue[])|error;

    # Get values for provided metrics relavant to a project key.
    # + projectKey - Key of a project
    # + metricKeys - string array of metric keys
    # + return - Returns a mapping  of metric name and
    # Returns error if an exception raised in getting project metric values
    public function getMetricValues(string projectKey, string[] metricKeys) returns (map|error);
    function getMeasure(string projectKey, string metricName) returns string|error;
};

function SonarQubeConnector::getProject(string projectName) returns Project|error {
    endpoint http:Client httpEndpoint = self.client;

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = httpEndpoint->get(requestPath);

    // match endpointResponse
    match endpointResponse {
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
                float totalProjectsCount = check <float>(paging[TOTAL].toString() but {
                    () => "0.0"
                });
                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = new;
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    endpointResponse = httpEndpoint->get(requestPath);
                    match endpointResponse {
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
                        error err => {
                            error connectionError = { message: err.message };
                            return connectionError;
                        }
                    }
                    count += 1;
                }
            }
            return endpointErrors;
        }
        error err => {
            error connectionError = { message: err.message };
            return connectionError;
        }
    }
}

function SonarQubeConnector::getAllProjects() returns (Project[]|error) {
    endpoint http:Client httpEndpoint = self.client;

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = httpEndpoint->get(requestPath);

    // match endpointResponse
    match endpointResponse {
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
                float totalProjectsCount = check <float>(paging[TOTAL].toString() but {
                    () => "0.0"
                });
                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = new;
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    endpointResponse = httpEndpoint->get(requestPath);
                    match endpointResponse {
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
                        error err => {
                            error connectionError = { message: err.message };
                            return connectionError;
                        }
                    }
                    count += 1;
                }
                return projects;
            }
            return endpointErrors;
        }
        error err => {
            error connectionError = { message: err.message };
            return connectionError;
        }
    }
}

function SonarQubeConnector::getMetricValues(string projectKey, string[] metricKeys) returns (map|error) {
    endpoint http:Client httpEndpoint = self.client;
    string keyList = "";
    foreach key in metricKeys {
        keyList = keyList + key + ",";
    }

    http:Request request = new;
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + keyList;
    var endpointResponse = httpEndpoint->get(requestPath);

    // match endpointResponse
    match endpointResponse {
        http:Response response => {
            // checking whether the response has errors
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                map values;
                json component = check getJsonValueByKey(response, COMPONENT);
                match <json[]>component[MEASURES]{
                    json[] metrics => {
                        foreach metric in metrics {
                            string metricKey = metric[METRIC].toString();
                            if (metricKey != ""){
                                string value = metric[VALUE].toString();
                                values[metricKey] = value;
                            } else {
                                values[metricKey] = "Not defined for the product.";
                            }
                        }
                        return values;
                    }
                    error err => {
                        string errorMessage = err.message;
                        err = { message: "The " + keyList + " cannot be found for the " + projectKey + "." +
                            errorMessage };
                        return err;
                    }
                }
            }
            return endpointErrors;
        }
        error err => {
            error connectionError = { message: err.message };
            return connectionError;
        }
    }
}

function SonarQubeConnector::getComplexity(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, COMPLEXITY);
    return <int>value;
}

function SonarQubeConnector::getDuplicatedCodeBlocksCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_BLOCKS_COUNT);
    return <int>value;
}

function SonarQubeConnector::getDuplicatedFilesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_FILES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getDuplicatedLinesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, DUPLICATED_LINES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getBlockerIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, BLOCKER_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getCriticalIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CRITICAL_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getMajorIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, MAJOR_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getMinorIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, MINOR_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getOpenIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, OPEN_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getConfirmedIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CONFIRMED_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getReopenedIssuesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, REOPENED_ISSUES_COUNT);
    return <int>value;
}

function SonarQubeConnector::getLinesOfCode(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, LINES_OF_CODE);
    return <int>value;
}

function SonarQubeConnector::getLineCoverage(string projectKey) returns (string)|error {
    string value = check self.getMeasure(projectKey, LINE_COVERAGE);
    return value + "%";
}

function SonarQubeConnector::getCoveredLinesCount(string projectKey) returns (int|error) {
    int linesToCover = check <int>check self.getMeasure(projectKey, LINES_TO_COVER);
    int uncoveredLines = check <int>check self.getMeasure(projectKey, UNCOVERED_LINES);
    return linesToCover - uncoveredLines;
}

function SonarQubeConnector::getBranchCoverage(string projectKey) returns (string|error) {
    string value = check self.getMeasure(projectKey, BRANCH_COVERAGE);
    return value + "%";
}

function SonarQubeConnector::getCodeSmellsCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, CODE_SMELLS);
    return <int>value;
}

function SonarQubeConnector::getSQALERating(string projectKey) returns (string|error) {
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

function SonarQubeConnector::getTechnicalDebt(string projectKey) returns (string|error) {
    return self.getMeasure(projectKey, TECHNICAL_DEBT);
}

function SonarQubeConnector::getTechnicalDebtRatio(string projectKey) returns (string|error) {
    return self.getMeasure(projectKey, TECHNICAL_DEBT_RATIO);
}

function SonarQubeConnector::getVulnerabilitiesCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, VULNERABILITIES);
    return <int>value;
}

function SonarQubeConnector::getSecurityRating(string projectKey) returns (string|error) {
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

function SonarQubeConnector::getBugsCount(string projectKey) returns (int|error) {
    string value = check self.getMeasure(projectKey, BUGS_COUNT);
    return <int>value;
}

function SonarQubeConnector::getReliabilityRating(string projectKey) returns (string|error) {
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

function SonarQubeConnector::getIssues(string projectKey) returns (Issue[]|error) {
    endpoint http:Client httpEndpoint = self.client;
    http:Request request = new;
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + projectKey + "&" + EXTRA_CONTENT;
    var endpointResponse = httpEndpoint->get(requestPath);

    // match endpointResponse
    match endpointResponse {
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
        error err => {
            error connectionError = { message: err.message };
            return connectionError;
        }
    }
}
