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

package sonarqube67;

import ballerina/log;
import ballerina/math;
import ballerina/http;

@Description {value:"Get project details."}
@Param {value:"projetName:Name of the project."}
@Return {value:"project:Project struct with project details."}
@Return {value:"err: Returns error if an exception raised in getting project details."}
public function <SonarQubeConnector sonarqubeConnector> getProject (string projectName) returns (Project|error) {
    endpoint http:ClientEndpoint clientEndpoint = sonarqubeConnector.clientEndpoint;
    Project project = {};
    string requestPath = API_RESOURCES + PROJECTS_PER_PAGE;
    http:Request request = {};
    sonarqubeConnector.constructAuthenticationHeaders(request);
    try {
        http:Response response =? clientEndpoint -> get(API_RESOURCES + PROJECTS_PER_PAGE, request);
        checkResponse(response);
        json allComponents = getContentByKey(response, COMPONENTS);
        project = getProjectFromList(projectName, allComponents);
        if (project.key != "") {
            return project;
        }
        json paging = getContentByKey(response, PAGING);
        int totalProjectsCount =? <int>(!isAnEmptyJson(paging[TOTAL]) ? paging[TOTAL].toString() : "0");
        int totalPages = <int>math:ceil(totalProjectsCount / PROJECTS_PER_PAGE);
        int count = 0;
        while (count < totalPages - 1) {
            request = {};
            sonarqubeConnector.constructAuthenticationHeaders(request);
            response =? clientEndpoint -> get(API_RESOURCES + PROJECTS_PER_PAGE + "&" + PAGE_NUMBER + "=" + (count + 2), request);
            checkResponse(response);
            allComponents = getContentByKey(response, COMPONENTS);
            project = getProjectFromList(projectName, allComponents);
            if (project.key != "") {
                return project;
            }
            count = count + 1;
        }
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
    } catch (error err) {
        log:printError(err.message);
        return err;
    }
    return project;
}

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project.Complexity calculated based on the number of paths through
 the code."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function <SonarQubeConnector sonarqubeConnector> getComplexity (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, COMPLEXITY);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get number of duplicated code blocks."}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated code blocks count."}
public function <SonarQubeConnector sonarqubeConnector> getDuplicatedCodeBlocksCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, DUPLICATED_BLOCKS);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        err = {message:"Cannot find duplicated blocks count for this project."};
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get Number of duplicated files."}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated files count."}
public function <SonarQubeConnector sonarqubeConnector> getDuplicatedFilesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, DUPLICATED_FILES);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        err = {message:"Cannot find duplicated files count for this project."};
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of duplicated lines."}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated lines count."}
public function <SonarQubeConnector sonarqubeConnector> getDuplicatedLinesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, DUPLICATED_LINES);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately
fixed."}
@Return {value:"blockerIssue:returns number of blocker issues in a project."}
@Return {value:"err: returns error if an exception raised in getting blocker issues count."}
public function <SonarQubeConnector sonarqubeConnector> getBlockerIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_BLOCKER);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of critical issues in a project.Either a bug with a low probability to impact the behavior
of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ...
The code MUST be immediately reviewed. "}
@Return {value:"criticalIssue:returns number of critical issues in a project."}
@Return {value:"err: returns error if an exception raised in getting critical issues count."}
public function <SonarQubeConnector sonarqubeConnector> getCriticalIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_CRITICAL);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of major issues in a project.Quality flaw which can highly impact the developer
 productivity: uncovered piece of code, duplicated blocks, unused parameters, ..."}
@Return {value:"minorIssue:returns number of minor issues in a project."}
@Return {value:"err: returns error if an exception raised in getting major issues count."}
public function <SonarQubeConnector sonarqubeConnector> getMajorIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_MAJOR);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of minor issues in a project.Quality flaw which can slightly impact the developer
productivity: lines should not be too long, switch statements should have at least 3 cases, ..."}
@Return {value:"majorIssue:returns number of major issues in a project."}
@Return {value:"err: returns error if an exception raised in getting minor issues count."}
public function <SonarQubeConnector sonarqubeConnector> getMinorIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_MINOR);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of open issues in a project."}
@Return {value:"issuesCount:returns number of open issues in a project."}
@Return {value:"err: returns error if an exception raised in getting open issues count."}
public function <SonarQubeConnector sonarqubeConnector> getOpenIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_OPEN);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of confirmed issues in a project."}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised in getting confirmed issue count."}
public function <SonarQubeConnector sonarqubeConnector> getConfirmedIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_CONFIRMED);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Number of reopened issues in a project."}
@Return {value:"reopenedIssues:returns number of reopened issues in a project."}
@Return {value:"err: returns error if an exception raised in getting re-opened issue count."}
public function <SonarQubeConnector sonarqubeConnector> getReopenedIssuesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, ISSUE_REOPENED);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get lines of code of a project."}
@Return {value:"loc: returns project LOC."}
@Return {value:"err: returns error if an exception raised in getting project LOC."}
public function <SonarQubeConnector sonarqubeConnector> getLinesOfCode (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, LOC);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get line coverage of a project."}
@Return {value:"lineCoverage:returns line coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting line coverage."}
public function <SonarQubeConnector sonarqubeConnector> getLineCoverage (string projectKey) returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(projectKey, sonarqubeConnector, LINE_COVERAGE);
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return value + "%";
}

@Description {value:"Get branch coverage of a project."}
@Return {value:"branchCoverage:returns branch Coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting branch coverage."}
public function <SonarQubeConnector sonarqubeConnector> getBranchCoverage (string projectKey) returns (string|error) {
    string value = "";
    try {
        value = getMetricValue(projectKey, sonarqubeConnector, BRANCH_COVERAGE);
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return value + "%";
}

@Description {value:"Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
 of a program that possibly indicates a deeper problem."}
@Return {value:"codeSmells: returns number of code smells in a project."}
@Return {value:"err: returns error if an exception raised in getting code smells count."}
public function <SonarQubeConnector sonarqubeConnector> getCodeSmellsCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, CODE_SMELLS);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get SQALE rating of a project.This is the rating given to your project related to the value of your
 Technical Debt Ratio."}
@Return {value:"sqaleRating:returns sqale rating of a project."}
@Return {value:"err: returns error if an exception raised in getting SQALE rating."}
public function <SonarQubeConnector sonarqubeConnector> getSQALERating (string projectKey) returns (string)|error {
    string sqaleRating = "";
    try {
        float floatValue =? <float>getMetricValue(projectKey, sonarqubeConnector, SQALE_RATING);
        int value = math:round(floatValue);
        if (value <= 5) {
            sqaleRating = "A";
        } else if (value <= 10) {
            sqaleRating = "B";
        } else if (value <= 20) {
            sqaleRating = "C";
        } else if (value <= 50) {
            sqaleRating = "D";
        } else {
            sqaleRating = "E";
        }
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return sqaleRating;
}
@Description {value:"Get technical debt of a project.Technical debt is the effort to fix all maintainability issues."}
@Return {value:"technicalDebt: returns technical debt of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt."}
public function <SonarQubeConnector sonarqubeConnector> getTechnicalDebt (string projectKey) returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(projectKey, sonarqubeConnector, TECHNICAL_DEBT);
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return value;
}

@Description {value:"Get technical debt ratio of a project."}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt ratio."}
public function <SonarQubeConnector sonarqubeConnector> getTechnicalDebtRatio (string projectKey) returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(projectKey, sonarqubeConnector, TECHNICAL_DEBT_RATIO);
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return value;
}

@Description {value:"Get number of vulnerablities of a project."}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project."}
@Return {value:"err: returns error if an exception raised in getting vulnerabilities count."}
public function <SonarQubeConnector sonarqubeConnector> getVulnerabilitiesCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, VULNERABILITIES);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get security rating of a project."}
@Return {value:"securityRating:returns 	security rating of a project."}
@Return {value:"err: returns error if an exception raised in getting security rating."}
public function <SonarQubeConnector sonarqubeConnector> getSecurityRating (string projectKey) returns (string)|error {
    string securityRating = "";
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, SECURITY_RATING);
        if (value == NO_VULNERABILITY) {
            securityRating = "A";
        } else if (value == MINOR_VULNERABILITY) {
            securityRating = "B";
        } else if (value == MAJOR_VULNERABILITY) {
            securityRating = "C";
        } else if (value == CRITICAL_VULNERABILITY) {
            securityRating = "D";
        } else {
            securityRating = "E";
        }
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return securityRating;
}

@Description {value:"Get number of bugs in a project."}
@Return {value:"bugs: returns number of bugs of  project."}
@Return {value:"err: returns error if an exception raised in getting bugs count."}
public function <SonarQubeConnector sonarqubeConnector> getBugsCount (string projectKey) returns (int|error) {
    int convertedValue = 0;
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, BUGS);
        convertedValue =? <int>value;
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return convertedValue;
}

@Description {value:"Get reliability rating of a project."}
@Return {value:"securityRating:returns reliability rating of a project."}
@Return {value:"err: returns error if an exception raised in getting reliability rating."}
public function <SonarQubeConnector sonarqubeConnector> getReliabilityRating (string projectKey) returns (string)|error {
    string reliabilityRating = "";
    try {
        string value = getMetricValue(projectKey, sonarqubeConnector, RELIABILITY_RATING);
        if (value == NO_BUGS) {
            reliabilityRating = "A";
        } else if (value == MINOR_BUGS) {
            reliabilityRating = "B";
        } else if (value == MAJOR_BUGS) {
            reliabilityRating = "C";
        } else if (value == CRITICAL_BUGS) {
            reliabilityRating = "D";
        } else {
            reliabilityRating = "E";
        }
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
        throw err;
    } catch (error err) {
        log:printError(err.message);
        throw err;
    }
    return reliabilityRating;
}

@Description {value:"Get details of project issues."}
@Return {value:"issues: returns array of project issues."}
@Return {value:"err: returns error if an exception raised in getting project issues."}
public function <SonarQubeConnector sonarqubeConnector> getIssues (string projectKey) returns (Issue[])|error {
    endpoint http:ClientEndpoint clientEndpoint = sonarqubeConnector.clientEndpoint;
    http:Request request = {};
    sonarqubeConnector.constructAuthenticationHeaders(request);
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + projectKey + "&" + EXTRA_CONTENT;
    Issue[] issues = [];
    try {
        var response =? clientEndpoint -> get(requestPath, request);
        checkResponse(response);
        json issueList = getContentByKey(response, ISSUES);
        int i = 0;
        foreach issue in issueList {
            Issue issueStruct = convertJsonToIssue(issue);
            issues[i] = issueStruct;
            i = i + 1;
        }
    } catch (http:HttpConnectorError connectionError) {
        error err = {message:connectionError.message};
        log:printError(err.message);
    } catch (error err) {
        log:printError(err.message);
        return err;
    }
    return issues;
}
