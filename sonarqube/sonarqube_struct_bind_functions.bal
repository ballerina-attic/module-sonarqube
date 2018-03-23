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

package sonarqube;

import ballerina/math;

@Description {value:"Get project details."}
@Param {value:"projetName:Name of the project."}
@Return {value:"project:Project struct with project details."}
@Return {value:"err: Returns error if an exception raised in getting project details."}
public function <Connector connector>getProject (string projectName) returns (Project)|error {
    try {
        Project project = getProjectDetails(projectName,connector);
        if (project.key != "") {
            return project;
        }
    } catch (error projectError) {
        return projectError;
    }
    error err = {message:"Project specified by name " + projectName + " cannot be found in sonarqube server."};
    return err;
}

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project.Complexity calculated based on the number of paths through
 the code."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function <Project project> getComplexity () returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(project, COMPLEXITY);
        return value;
    } catch (error dataError) {
        return dataError;
    }
    return "";
}

@Description {value:"Get number of duplicated code blocks."}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated code blocks count."}
public function <Project project> getDuplicatedCodeBlocksCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, DUPLICATED_BLOCKS);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get Number of duplicated files."}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated files count."}
public function <Project project> getDuplicatedFilesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, DUPLICATED_FILES);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of duplicated lines."}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated lines count."}
public function <Project project> getDuplicatedLinesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, DUPLICATED_LINES);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately
fixed."}
@Return {value:"blockerIssue:returns number of blocker issues in a project."}
@Return {value:"err: returns error if an exception raised in getting blocker issues count."}
public function <Project project> getBlockerIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_BLOCKER);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of critical issues in a project.Either a bug with a low probability to impact the behavior
of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ...
The code MUST be immediately reviewed. "}
@Return {value:"criticalIssue:returns number of critical issues in a project."}
@Return {value:"err: returns error if an exception raised in getting critical issues count."}
public function <Project project> getCriticalIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_CRITICAL);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of major issues in a project.Quality flaw which can highly impact the developer
 productivity: uncovered piece of code, duplicated blocks, unused parameters, ..."}
@Return {value:"minorIssue:returns number of minor issues in a project."}
@Return {value:"err: returns error if an exception raised in getting major issues count."}
public function <Project project> getMajorIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_MAJOR);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of minor issues in a project.Quality flaw which can slightly impact the developer
productivity: lines should not be too long, switch statements should have at least 3 cases, ..."}
@Return {value:"majorIssue:returns number of major issues in a project."}
@Return {value:"err: returns error if an exception raised in getting minor issues count."}
public function <Project project> getMinorIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_MINOR);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of open issues in a project."}
@Return {value:"issuesCount:returns number of open issues in a project."}
@Return {value:"err: returns error if an exception raised in getting open issues count."}
public function <Project project> getOpenIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_OPEN);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of confirmed issues in a project."}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised in getting confirmed issue count."}
public function <Project project> getConfirmedIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_CONFIRMED);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Number of reopened issues in a project."}
@Return {value:"reopenedIssues:returns number of reopened issues in a project."}
@Return {value:"err: returns error if an exception raised in getting re-opened issue count."}
public function <Project project> getReopenedIssuesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, ISSUE_REOPENED);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get lines of code of a project."}
@Return {value:"loc: returns project LOC."}
@Return {value:"err: returns error if an exception raised in getting project LOC."}
public function <Project project> getLinesOfCode () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, LOC);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get number of lines which are not covered by unit tests."}
@Return {value:"loc: returns number of lines which are not covered by unit tests."}
@Return {value:"err: returns error if an exception raised in getting number of uncovered lines."}
public function <Project project> getUncoveredLinesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, UNCOVERED_LINES_COUNT);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get number of lines should be covered by unit tests."}
@Return {value:"linesToCover: returns number of lines should be covered by unit tests."}
@Return {value:"err: returns error if an exception raised in getting number of uncovered lines."}
public function <Project project> getNumberOfLinesToCover () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, LINES_TO_COVER);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get line coverage of a project."}
@Return {value:"lineCoverage:returns line coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting line coverage."}
public function <Project project> getLineCoverage () returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(project, LINE_COVERAGE);
    } catch (error dataError) {
        return dataError;
    }
    return value + "%";
}

@Description {value:"Get branch coverage of a project."}
@Return {value:"branchCoverage:returns branch Coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting branch coverage."}
public function <Project project> getBranchCoverage () returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(project, BRANCH_COVERAGE);
    } catch (error dataError) {
        return dataError;
    }
    return value + "%";
}

@Description {value:"Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
 of a program that possibly indicates a deeper problem."}
@Return {value:"codeSmells: returns number of code smells in a project."}
@Return {value:"err: returns error if an exception raised in getting code smells count."}
public function <Project project> getCodeSmellsCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, CODE_SMELLS);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get SQALE rating of a project.This is the rating given to your project related to the value of your
 Technical Debt Ratio."}
@Return {value:"sqaleRating:returns sqale rating of a project."}
@Return {value:"err: returns error if an exception raised in getting SQALE rating."}
public function <Project project> getSQALERating () returns (string)|error {
    string sqaleRating = "";
    try {
        int value = 0;
        sqaleRating = getMetricValue(project, SQALE_RATING);
        var convertedValue = <float>sqaleRating;
        match convertedValue {
            float val => value = math:round(val);
            error castError => return castError;
        }
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
    } catch (error dataError) {
        return dataError;
    }
    return sqaleRating;
}

@Description {value:"Get technical debt of a project.Technical debt is the effort to fix all maintainability issues."}
@Return {value:"technicalDebt: returns technical debt of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt."}
public function <Project project> getTechnicalDebt () returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(project, TECHNICAL_DEBT);
    } catch (error dataError) {
        return dataError;
    }
    return value;
}

@Description {value:"Get technical debt ratio of a project."}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt ratio."}
public function <Project project> getTechnicalDebtRatio () returns (string)|error {
    string value = "";
    try {
        value = getMetricValue(project, TECHNICAL_DEBT_RATIO);
    } catch (error dataError) {
        return dataError;
    }
    return value;
}

@Description {value:"Get number of vulnerablities of a project."}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project."}
@Return {value:"err: returns error if an exception raised in getting vulnerabilities count."}
public function <Project project> getVulnerabilitiesCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, VULNERABILITIES);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get security rating of a project."}
@Return {value:"securityRating:returns 	security rating of a project."}
@Return {value:"err: returns error if an exception raised in getting security rating."}
public function <Project project> getSecurityRating () returns (string)|error {
    string securityRating = "";
    try {
        securityRating = getMetricValue(project, SECURITY_RATING);
    } catch (error dataError) {
        return dataError;
    }
    if (securityRating == NO_VULNERABILITY) {
        securityRating = "A";
    } else if (securityRating == MINOR_VULNERABILITY) {
        securityRating = "B";
    } else if (securityRating == MAJOR_VULNERABILITY) {
        securityRating = "C";
    } else if (securityRating == CRITICAL_VULNERABILITY) {
        securityRating = "D";
    } else {
        securityRating = "E";
    }
    return securityRating;
}

@Description {value:"Get number of bugs in a project."}
@Return {value:"bugs: returns number of bugs of  project."}
@Return {value:"err: returns error if an exception raised in getting bugs count."}
public function <Project project> getBugsCount () returns (int)|error {
    string value = "";
    try {
        value = getMetricValue(project, BUGS);
    } catch (error dataError) {
        return dataError;
    }
    var convertedValue = <int>value;
    match convertedValue {
        int val => return val;
        error castError => return castError;
    }
}

@Description {value:"Get reliability rating of a project."}
@Return {value:"securityRating:returns reliability rating of a project."}
@Return {value:"err: returns error if an exception raised in getting reliability rating."}
public function <Project project> getReliabilityRating () returns (string)|error {
    string reliabilityRating = "";
    try {
        reliabilityRating = getMetricValue(project, RELIABILITY_RATING);
    } catch (error dataError) {
        return dataError;
    }
    if (reliabilityRating == NO_BUGS) {
        reliabilityRating = "A";
    } else if (reliabilityRating == MINOR_BUGS) {
        reliabilityRating = "B";
    } else if (reliabilityRating == MAJOR_BUGS) {
        reliabilityRating = "C";
    } else if (reliabilityRating == CRITICAL_BUGS) {
        reliabilityRating = "D";
    } else if (reliabilityRating == BLOCKER_BUGS) {
        reliabilityRating = "E";
    }
    return reliabilityRating;
}

@Description {value:"Get details of project issues."}
@Return {value:"issues: returns array of project issues."}
@Return {value:"err: returns error if an exception raised in getting project issues."}
public function <Project project> getIssues () returns (Issue[])|error {
    endpoint http:ClientEndpoint clientEP = project.getConnectionFactory().sonarqubeEP;
    string username = project.getConnectionFactory().username;
    string password = project.getConnectionFactory().password;
    http:Request request = {};
    http:Response response = {};
    http:HttpConnectorError connectionError = {};
    error err = {};
    constructAuthenticationHeaders(request,username,password);
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + project.key + "&" + EXTRA_CONTENT;
    var endpointResponse = clientEP -> get(requestPath, request);
    match endpointResponse {
        http:Response res => response = res;
        http:HttpConnectorError connectErr => connectionError = connectErr;
    }
    if (connectionError.message != "") {
        err = {message:connectionError.message};
        throw err;
    }
    Issue[] issues = [];
    try {
        checkResponse(response);
        json issueList = getContentByKey(response, ISSUES);
        int i = 0;
        foreach issue in issueList {
            Issue issueStruct = <Issue, getIssue()>issue;
            issues[i] = issueStruct;
            i = i + 1;
        }
    } catch (error blockError) {
        return blockError;
    }
    return issues;
}
