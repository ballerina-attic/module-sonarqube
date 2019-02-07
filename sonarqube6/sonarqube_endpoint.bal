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

# Google Sonarqube Client object.
#
# + sonarQubeClient - The HTTP Client
# + baseUrl - The base url of your SonarQube server.
public type Client client object {

    public http:Client sonarQubeClient;
    public string baseUrl;

    public function __init(SonarQubeConfiguration sonarqubeConfig) {
        self.sonarQubeClient = new(sonarqubeConfig.baseUrl, config = sonarqubeConfig.clientConfig);
        self.baseUrl = sonarqubeConfig.baseUrl;
    }

    # Returns a Project record.
    # + return - If the execution is successful returns a Project record else an error
    public remote function getProject(string projectName) returns Project|error;

    # Returns an array of all projects.
    # + return - If the execution is successful returns an array of Project records else an error
    public remote function getAllProjects() returns Project[]|error;

    # Get number of duplicated code blocks.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated code blocks else an error
    public remote function getDuplicatedCodeBlocksCount(string projectKey) returns int|error;

    # Get Number of duplicated files.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated files else an error
    public remote function getDuplicatedFilesCount(string projectKey) returns int|error;

    # Get Number of duplicated lines.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of duplicated lines else an error
    public remote function getDuplicatedLinesCount(string projectKey) returns int|error ;

    # Number of blocker issues in a project. Blocker issue may be a bug with a high probability to impact.
    # The behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be
    # immediately fixed.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of blocker issues else an error
    public remote function getBlockerIssuesCount(string projectKey) returns int|error;

    # Number of critical issues in a project.Either a bug with a low probability to impact the behavior
    # of the application in production or an issue which represents a security flaw: empty catch block, SQL injection,
    # The code MUST be immediately reviewed.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of critical issues else an error
    public remote function getCriticalIssuesCount(string projectKey) returns int|error;

    # Number of major issues in a project.Quality flaw which can highly impact the developer productivity:
    # uncovered piece of code, duplicated blocks, unused parameters.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of major issues else an error
    public remote function getMajorIssuesCount(string projectKey) returns int|error;

    # Number of minor issues in a project.Quality flaw which can slightly impact the developer
    # productivity: lines should not be too long, switch statements should have at least 3 cases, ....
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of minor issues else an error
    public remote function getMinorIssuesCount(string projectKey) returns int|error;

    # Number of open issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of open issues else an error
    public remote function getOpenIssuesCount(string projectKey) returns int|error;

    # Number of confirmed issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of confirmed issues else an error
    public remote function getConfirmedIssuesCount(string projectKey) returns int|error;

    # Number of reopened issues in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of repoened issues else an error
    public remote function getReopenedIssuesCount(string projectKey) returns int|error;

    # Get lines of code of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns lines of code else an error
    public remote function getLinesOfCode(string projectKey) returns int|error;

    # Get line coverage of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns line coverage else an error
    public remote function getLineCoverage(string projectKey) returns string|error;

    # Get complexity of a project. Complexity calculated based on the number of paths through the code.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns complexity else an error
    public remote function getComplexity(string projectKey) returns int|error;

    # Get number of lines covered by unit tests.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of covered lines else an error
    public remote function getCoveredLinesCount(string projectKey) returns int|error ;

    # Get branch coverage of a project.
    # + projectKey - Key of a project
    # + return - branch Coverage of a project or an error if an exception raised in getting branch coverage
    public remote function getBranchCoverage(string projectKey) returns (string|error);

    # Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
    # of a program that possibly indicates a deeper problem.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of code smells else an error
    public remote function getCodeSmellsCount(string projectKey) returns int|error;

    # Get SQALE rating of a project.This is the rating given to your project related to the value of your
    # Technical Debt Ratio.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns SQALE rating else an error
    public remote function getSQALERating(string projectKey) returns (string|error);

    # Get technical debt of a project.Technical debt is the effort to fix all maintainability issues.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns technical debt else an error
    public remote function getTechnicalDebt(string projectKey) returns string|error ;

    # Get technical debt ratio of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns technical debt ratio else an error
    public remote function getTechnicalDebtRatio(string projectKey) returns string|error;

    # Get number of vulnerablities of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of vulnerabilities else an error
    public remote function getVulnerabilitiesCount(string projectKey) returns int|error;

    # Get security rating of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns security rating else an error
    public remote function getSecurityRating(string projectKey) returns string|error;

    # Get reliability rating of a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns reliability rating else an error
    public remote function getReliabilityRating(string projectKey) returns string|error;

    # Get number of bugs in a project.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns number of bugs else an error
    public remote function getBugsCount(string projectKey) returns int|error;

    # Get details of project issues.
    # + projectKey - Key of a project
    # + return - If the execution is successful returns an array of Issue records else an error
    public remote function getIssues(string projectKey) returns Issue[]|error;

    # Get values for provided metrics relavant to a project key.
    # + projectKey - Key of a project
    # + metricKeys - string array of metric keys
    # + return - Returns a mapping  of metric name and
    # Returns error if an exception raised in getting project metric values
    public remote function getMetricValues(string projectKey, string[] metricKeys) returns map<string>|error;

    function getMeasure(string projectKey, string metricName) returns string|error;
};

public remote function Client.getProject(string projectName) returns Project|error {

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = self.sonarQubeClient->get(requestPath);

    if (endpointResponse is http:Response) {
        // checking whether the response has errors
        error endpointErrors = checkResponse(endpointResponse);
        if (<string>endpointErrors.detail().message == "") {
            // check the results in the first page of Project List
            json[] allComponentsInPage = check getJsonArrayByKey(endpointResponse, COMPONENTS);
                foreach var component in allComponentsInPage {
                    Project project = convertJsonToProject(component);
                    if (projectName == project.name) {
                        return project;
                    }
                }
                // Cannot find results in the first page.Iterate through other pages
                json paging = check getJsonValueByKey(endpointResponse, PAGING);
                // get the total project count
                float totalProjectsCount = paging[TOTAL].toString() == "" ? 0.0 :
                check float.convert(paging[TOTAL].toString());

                // get the total number of projects which have the project details
                int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
                int count = 0;

                // iterate through pages up-to total pages
                while (count < totalPages - 1) {
                    request = new;
                    requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                    var response = self.sonarQubeClient->get(requestPath);
                    if (response is http:Response) {
                        error responseErrors = checkResponse(response);
                        if (<string>responseErrors.detail().message == "") {
                            allComponentsInPage = check getJsonArrayByKey(response, COMPONENTS);
                            foreach var component in allComponentsInPage {
                                Project project = convertJsonToProject(component);
                                if (projectName == project.name) {
                                    return project;
                                }
                            }
                        } else {
                            return responseErrors;
                        }
                    } else {
                        error err = error(SONARQUBE_ERROR_CODE
                        , { message: "Error occurred while invoking the Sonarqube API." });
                        return err;
                    }
                count += 1;
                }
            }
        return endpointErrors;
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred while invoking the Sonarqube API." });
        return err;
    }
}

public remote function Client.getAllProjects() returns Project[]|error {

    // get the first page of the project details
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = new;
    var endpointResponse = self.sonarQubeClient->get(requestPath);

    if (endpointResponse is http:Response) {
        // checking whether the response has errors
        error endpointErrors = checkResponse(endpointResponse);
        if (<string>endpointErrors.detail().message == "") {
            Project[] projects = [];
            // check the results in the first page of Project List
            json[] allComponentsInPage = check getJsonArrayByKey(endpointResponse, COMPONENTS);
            int projectCount = 0;
            foreach var component in allComponentsInPage {
                Project project = convertJsonToProject(component);
                projects[projectCount] = project;
                projectCount += 1;
            }
            // Cannot find results in the first page.Iterate through other pages
            json paging = check getJsonValueByKey(endpointResponse, PAGING);
            // get the total project count
            float totalProjectsCount = paging[TOTAL].toString() == "" ? 0.0 :
            check float.convert(paging[TOTAL].toString());

            // get the total number of projects which have the project details
            int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
            int count = 0;

            // iterate through pages up-to total pages
            while (count < totalPages - 1) {
                request = new;
                requestPath = API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2);
                var response = self.sonarQubeClient->get(requestPath);
                if (response is http:Response) {
                    error responseErrors = checkResponse(response);
                    if (<string>responseErrors.detail().message == "") {
                        allComponentsInPage = check getJsonArrayByKey(response, COMPONENTS);
                        foreach var component in allComponentsInPage {
                            Project project = convertJsonToProject(component);
                            projects[projectCount] = project;
                            projectCount += 1;
                        }
                    } else {
                        return responseErrors;
                    }
                } else {
                    error err = error(SONARQUBE_ERROR_CODE
                    , { message: "Error occurred while invoking the Sonarqube API." });
                    return err;
                }
                count += 1;
            }
            return projects;
        }
        return endpointErrors;
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred while invoking the Sonarqube API." });
        return err;
    }
}

public remote function Client.getMetricValues(string projectKey, string[] metricKeys) returns map<string>|error {
    string keyList = "";
    foreach var key in metricKeys {
        keyList = keyList + key + ",";
    }

    http:Request request = new;
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + untaint keyList;
    var endpointResponse = self.sonarQubeClient->get(requestPath);

    if (endpointResponse is http:Response) {
        // checking whether the response has errors
        error endpointErrors = checkResponse(endpointResponse);
        if (<string>endpointErrors.detail().message == "") {
            map<string> values = {};
            json component = check getJsonValueByKey(endpointResponse, COMPONENT);
            if (json[].convert(component[MEASURES]) is json[]) {
                json[] metrics = check json[].convert(component[MEASURES]);
                foreach json metric in metrics {
                    string metricKey = metric[METRIC].toString();
                    if (metricKey != ""){
                        string value = metric[VALUE].toString();
                        values[metricKey] = value;
                    } else {
                        values[metricKey] = "Not defined for the product.";
                    }
                }
                return values;
            }  else {
                error err = error(SONARQUBE_ERROR_CODE
                , { message: "The " + keyList + " cannot be found for the " + projectKey + "." });
                return err;
            }
        }
        return endpointErrors;
    } else {
    error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred while invoking the Sonarqube API." });
    return err;
    }
}

public remote function Client.getComplexity(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, COMPLEXITY);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE, { message:"Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getDuplicatedCodeBlocksCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, DUPLICATED_BLOCKS_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getDuplicatedFilesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, DUPLICATED_FILES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getDuplicatedLinesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, DUPLICATED_LINES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getBlockerIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, BLOCKER_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getCriticalIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, CRITICAL_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getMajorIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, MAJOR_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getMinorIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, MINOR_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE
        , { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getOpenIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, OPEN_ISSUES_COUNT);
    if (result is string) {
    var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,
            { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getConfirmedIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, CONFIRMED_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getReopenedIssuesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, REOPENED_ISSUES_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getLinesOfCode(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, LINES_OF_CODE);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,{ message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getLineCoverage(string projectKey) returns string|error {
    var result = self.getMeasure(projectKey, LINE_COVERAGE);
    if (result is string) {
        return result + "%";
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getCoveredLinesCount(string projectKey) returns int|error {
    int uncoveredLines = 0;
    int linesToCover = 0;
    var value = self.getMeasure(projectKey, LINES_TO_COVER);
    if (value is string) {
        var intValue = int.convert(value);
        if (intValue is int) {
            linesToCover = intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,
            { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
    var result = self.getMeasure(projectKey, UNCOVERED_LINES);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            uncoveredLines = intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
    return linesToCover - uncoveredLines;
}

public remote function Client.getBranchCoverage(string projectKey) returns string|error {
    var result = self.getMeasure(projectKey, BRANCH_COVERAGE);
    if (result is string) {
        return result + "%";
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getCodeSmellsCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, CODE_SMELLS);
    if (result is string) {
    var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,
            { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getSQALERating(string projectKey) returns string|error {
    float floatValue = 0.0;
    var result = self.getMeasure(projectKey, SQALE_RATING);
    if (result is string) {
    var intValue = float.convert(result);
        if (intValue is float) {
            floatValue = intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message:"Error occurred when converting the given value to float"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
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

public remote function Client.getTechnicalDebt(string projectKey) returns string|error {
    return self.getMeasure(projectKey, TECHNICAL_DEBT);
}

public remote function Client.getTechnicalDebtRatio(string projectKey) returns string|error {
    return self.getMeasure(projectKey, TECHNICAL_DEBT_RATIO);
}

public remote function Client.getVulnerabilitiesCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, VULNERABILITIES);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE
            , { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getSecurityRating(string projectKey) returns string|error {
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

public remote function Client.getBugsCount(string projectKey) returns int|error {
    var result = self.getMeasure(projectKey, BUGS_COUNT);
    if (result is string) {
        var intValue = int.convert(result);
        if (intValue is int) {
            return intValue;
        } else {
            error err = error(SONARQUBE_ERROR_CODE,
            { message: "Error occurred when converting the given value to int"});
            panic err;
        }
    } else {
        error err = error(SONARQUBE_ERROR_CODE,
        { message: "Error occurred when converting the given value to string"});
        panic err;
    }
}

public remote function Client.getReliabilityRating(string projectKey) returns string|error {
    var result = self.getMeasure(projectKey, RELIABILITY_RATING);
    string value = "";
    if (result is string) {
        value = result;
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred when converting the given value to string"});
        panic err;
    }
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

public remote function Client.getIssues(string projectKey) returns Issue[]|error {
    http:Client httpEndpoint = self.sonarQubeClient;
    http:Request request = new;
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + projectKey + "&" + EXTRA_CONTENT;
    var endpointResponse = httpEndpoint->get(requestPath);

    if (endpointResponse is http:Response) {
        // checking whether the response has errors
        error endpointErrors = checkResponse(endpointResponse);
        Issue[] issues = [];
        if (<string>endpointErrors.detail().message == ""){
            int i = 0;
            json[] issueList = <json[]>getJsonArrayByKey(endpointResponse, ISSUES);
            foreach var issue in issueList {
                Issue issueStruct = convertJsonToIssue(issue);
                issues[i] = issueStruct;
                i = i + 1;
            }
        } else {
            return endpointErrors;
        }
        return issues;
    } else {
        error err = error(SONARQUBE_ERROR_CODE, { message: "Error occurred while invoking the Sonarqube API."});
        return err;
    }
}
