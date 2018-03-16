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

package src.sonarqube;

import ballerina.net.http;

@Description {value:"Get complexity of a project."}
@Return {value:"complexity:Returns complexity of a project.Complexity calculated based on the number of paths through
 the code."}
@Return {value:"err: Returns error if an exception raised in getting project complexity."}
public function <Project project> getComplexity () (string, error) {
    var complexity, err = getMetricValue(project.key, COMPLEXITY);
    if (err != null) {
        return null, err;
    }
    return complexity, err;
}

@Description {value:"Get number of duplicated code blocks."}
@Return {value:"duplicatedCodeBlocks:returns number of duplicated code blocks in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated code blocks count."}
public function <Project project> getDuplicatedCodeBlocksCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_BLOCKS);
    if (err != null) {
        return 0, err;
    }
    var duplicatedCodeBlocks, err = <int>initVal;
    return duplicatedCodeBlocks, err;
}

@Description {value:"Get Number of duplicated files."}
@Return {value:"duplicatedFiles:returns number of duplicated files in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated files count."}
public function <Project project> getDuplicatedFilesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_FILES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedFiles, err = <int>initVal;
    return duplicatedFiles, err;
}

@Description {value:"Number of duplicated lines."}
@Return {value:"duplicatedFiles:returns number of duplicated lines in a project."}
@Return {value:"err: returns error if an exception raised in getting duplicated lines count."}
public function <Project project> getDuplicatedLinesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, DUPLICATED_LINES);
    if (err != null) {
        return 0, err;
    }
    var duplicatedLines, err = <int>initVal;
    return duplicatedLines, err;
}

@Description {value:"Number of blocker issues in a project.Blocker issue may be a bug with a high probability to impact
the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately
fixed."}
@Return {value:"blockerIssue:returns number of blocker issues in a project."}
@Return {value:"err: returns error if an exception raised in getting blocker issues count."}
public function <Project project> getBlockerIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_BLOCKER);
    if (err != null) {
        return 0, err;
    }
    var blockerIssues, err = <int>initVal;
    return blockerIssues, err;
}

@Description {value:"Number of critical issues in a project.Either a bug with a low probability to impact the behavior
of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ...
The code MUST be immediately reviewed. "}
@Return {value:"criticalIssue:returns number of critical issues in a project."}
@Return {value:"err: returns error if an exception raised in getting critical issues count."}
public function <Project project> getCriticalIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CRITICAL);
    if (err != null) {
        return 0, err;
    }
    var criticalIssues, err = <int>initVal;
    return criticalIssues, err;
}

@Description {value:"Number of major issues in a project.Quality flaw which can highly impact the developer
 productivity: uncovered piece of code, duplicated blocks, unused parameters, ..."}
@Return {value:"minorIssue:returns number of minor issues in a project."}
@Return {value:"err: returns error if an exception raised in getting major issues count."}
public function <Project project> getMajorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MAJOR);
    if (err != null) {
        return 0, err;
    }
    var majorIssues, err = <int>initVal;
    return majorIssues, err;
}

@Description {value:"Number of minor issues in a project.Quality flaw which can slightly impact the developer
productivity: lines should not be too long, switch statements should have at least 3 cases, ..."}
@Return {value:"majorIssue:returns number of major issues in a project."}
@Return {value:"err: returns error if an exception raised in getting minor issues count."}
public function <Project project> getMinorIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_MINOR);
    if (err != null) {
        return 0, err;
    }
    var minorIssues, err = <int>initVal;
    return minorIssues, err;
}

@Description {value:"Number of open issues in a project."}
@Return {value:"issuesCount:returns number of open issues in a project."}
@Return {value:"err: returns error if an exception raised in getting open issues count."}
public function <Project project> getOpenIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_OPEN);
    if (err != null) {
        return 0, err;
    }
    var openIssues, err = <int>initVal;
    return openIssues, err;
}

@Description {value:"Number of confirmed issues in a project."}
@Return {value:"confirmedIssues:returns number of confirmed issues in a project"}
@Return {value:"err: returns error if an exception raised in getting confirmed issue count."}
public function <Project project> getConfirmedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_CONFIRMED);
    if (err != null) {
        return 0, err;
    }
    var confirmedIssues, err = <int>initVal;
    return confirmedIssues, err;
}

@Description {value:"Number of reopened issues in a project."}
@Return {value:"reopenedIssues:returns number of reopened issues in a project."}
@Return {value:"err: returns error if an exception raised in getting re-opened issue count."}
public function <Project project> getReopenedIssuesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, ISSUE_REOPENED);
    if (err != null) {
        return 0, err;
    }
    var reopenedIssues, err = <int>initVal;
    return reopenedIssues, err;
}

@Description {value:"Get lines of code of a project."}
@Return {value:"loc: returns project LOC."}
@Return {value:"err: returns error if an exception raised in getting project LOC."}
public function <Project project> getLinesOfCode () (int, error) {
    var initVal, err = getMetricValue(project.key, LOC);
    if (err != null) {
        return 0, err;
    }
    var loc, err = <int>initVal;
    return loc, err;
}

@Description {value:"Get line coverage of a project."}
@Return {value:"lineCoverage:returns line coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting line coverage."}
public function <Project project> getLineCoverage () (string, error) {
    var lineCoverage, err = getMetricValue(project.key, LINE_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return lineCoverage + "%", err;
}

@Description {value:"Get branch coverage of a project."}
@Return {value:"branchCoverage:returns branch Coverage of a project."}
@Return {value:"err: returns error if an exception raised in getting branch coverage."}
public function <Project project> getBranchCoverage () (string, error) {
    var branchCoverage, err = getMetricValue(project.key, BRANCH_COVERAGE);
    if (err != null) {
        return null, err;
    }
    return branchCoverage + "%", err;
}

@Description {value:"Get number of code smells in a project.Code smell, (or bad smell) is any symptom in the source code
 of a program that possibly indicates a deeper problem."}
@Return {value:"codeSmells: returns number of code smells in a project."}
@Return {value:"err: returns error if an exception raised in getting code smells count."}
public function <Project project> getCodeSmellsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, CODE_SMELLS);
    if (err != null) {
        return 0, err;
    }
    var codeSmells, _ = <int>initVal;
    return codeSmells, err;
}

@Description {value:"Get SQALE rating of a project.This is the rating given to your project related to the value of your
 Technical Debt Ratio."}
@Return {value:"sqaleRating:returns sqale rating of a project."}
@Return {value:"err: returns error if an exception raised in getting SQALE rating."}
public function <Project project> getSQALERating () (string, error) {
    var sqaleRating, err = getMetricValue(project.key, SQALE_RATING);
    if (err != null) {
        return null, err;
    }
    var val, _ = <int>sqaleRating;
    if (val <= 5) {
        sqaleRating = "A";
    } else if (val <= 10) {
        sqaleRating = "B";
    } else if (val <= 20) {
        sqaleRating = "C";
    } else if (val <= 50) {
        sqaleRating = "D";
    } else {
        sqaleRating = "E";
    }
    return sqaleRating, err;
}

@Description {value:"Get technical debt of a project.Technical debt is the effort to fix all maintainability issues."}
@Return {value:"technicalDebt: returns technical debt of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt."}
public function <Project project> getTechnicalDebt () (string, error) {
    var technicalDebt, err = getMetricValue(project.key, TECHNICAL_DEBT);
    if (err != null) {
        return null, err;
    }
    return technicalDebt, err;
}

@Description {value:"Get technical debt ratio of a project."}
@Return {value:"technicalDebtRatio: returns technical debt ratio of a project."}
@Return {value:"err: returns error if an exception raised in getting technical debt ratio."}
public function <Project project> getTechnicalDebtRatio () (string, error) {
    var technicalDebtRatio, err = getMetricValue(project.key, TECHNICAL_DEBT_RATIO);
    if (err != null) {
        return null, err;
    }
    return technicalDebtRatio, err;
}

@Description {value:"Get number of vulnerablities of a project."}
@Return {value:"vulnerabilities: returns number of vulnerabilities of  project."}
@Return {value:"err: returns error if an exception raised in getting vulnerabilities count."}
public function <Project project> getVulnerabilitiesCount () (int, error) {
    var initVal, err = getMetricValue(project.key, VULNERABILITIES);
    if (err != null) {
        return 0, err;
    }
    var vulnerabilities, err = <int>initVal;
    return vulnerabilities, err;
}

@Description {value:"Get security rating of a project."}
@Return {value:"securityRating:returns 	security rating of a project."}
@Return {value:"err: returns error if an exception raised in getting security rating."}
public function <Project project> getSecurityRating () (string, error) {
    var securityRating, err = getMetricValue(project.key, SECURITY_RATING);
    if (err != null) {
        return null, err;
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
    return securityRating, err;
}

@Description {value:"Get number of bugs in a project."}
@Return {value:"bugs: returns number of bugs of  project."}
@Return {value:"err: returns error if an exception raised in getting bugs count."}
public function <Project project> getBugsCount () (int, error) {
    var initVal, err = getMetricValue(project.key, BUGS);
    if (err != null) {
        return 0, err;
    }
    var bugs, err = <int>initVal;
    return bugs, err;
}

@Description {value:"Get reliability rating of a project."}
@Return {value:"securityRating:returns reliability rating of a project."}
@Return {value:"err: returns error if an exception raised in getting reliability rating."}
public function <Project project> getReliabilityRating () (string, error) {
    var reliabilityRating, err = getMetricValue(project.key, RELIABILITY_RATING);
    if (err != null) {
        return null, err;
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
    return reliabilityRating, err;
}

@Description {value:"Get details of project issues."}
@Return {value:"issues: returns array of project issues."}
@Return {value:"err: returns error if an exception raised in getting project issues."}
public function <Project project> getIssues () (Issue[], error) {
    endpoint<http:HttpClient> sonarqubeEP {
        getHTTPClient();
    }
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError httpError;
    error err = null;
    constructAuthenticationHeaders(request);
    string requestPath = API_ISSUES_SEARCH + "?" + PROJECT_KEYS + "=" + project.key + "&" + EXTRA_CONTENT;
    response, httpError = sonarqubeEP.get(requestPath, request);
    if (httpError != null) {
        err = {message:httpError.message};
        return null, err;
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
    } catch (error responseError) {
        return null, responseError;
    }
    return issues, err;
}

@Description {value:"Add a comment on issue."}
@Param {value:"comment: Comment to add."}
@Return {value:"err: returns error if an exception raised in adding comment."}
public function <Issue issue> addComment (string comment) (error) {
    json payLoad = {issue:issue.key, text:comment};
    error err = doOpertion(ADDING_COMMENT, API_ADD_COMMENT, payLoad);
    return err;
}

@Description {value:"Assign issue."}
@Param {value:"assignee: user name of the person to be assigned."}
@Return {value:"err: returns error if an exception raised in assigning issue."}
public function <Issue issue> assign (string assignee) (error) {
    json payLoad = {issue:issue.key, assignee:assignee};
    error err = doOpertion(ASSIGN, API_ASSIGN_ISSUE, payLoad);
    return err;
}

@Description {value:"Set type of an issue."}
@Param {value:"issueType: type of the issue."}
@Return {value:"operation: returns Operation struct containing operation details."}
@Return {value:"err: returns error if an exception raised in setting type of the project."}
public function <Issue issue> setType (string issueType) (error) {
    json payLoad = {issue:issue.key, |type|:issueType};
    error err = doOpertion(SET_TYPE, API_SET_ISSUE_TYPE, payLoad);
    return err;
}

@Description {value:"Set severity of an issue."}
@Param {value:"severityValue: new severity value."}
@Return {value:"err: returns error if an exception raised in setting severity of the project."}
public function <Issue issue> setSeverity (string severity) (error) {
    json payLoad = {issue:issue.key, severity:severity};
    error err = doOpertion(SET_SEVERITY, API_SET_ISSUE_SEVERITY, payLoad);
    return err;
}

@Description {value:"Do workflow transition on an issue."}
@Param {value:"status: transition type to be added."}
@Return {value:"err: returns error if an exception raised in setting up project status."}
public function <Issue issue> setStatus (string status) (error) {
    json payLoad = {issue:issue.key, transition:status};
    error err = doOpertion(SET_STATUS, API_SET_ISSUE_TYPE, payLoad);
    return err;
}

@Description {value:"Delete a comment."}
@Return {value:"err: Returns error if an exception raised in deleting comment."}
public function <Comment comment> delete () (error) {
    json payLoad = {key:comment.key};
    error err = doOpertion(DELETE_COMMENT, API_DELETE_COMMENT, payLoad);
    return err;
}

@Description {value:"Update a comment."}
@Return {value:"err: returns error if an exception raised in updating comment."}
public function <Comment comment> edit (string newComment) (error) {
    json payLoad = {key:comment.key, text:newComment};
    error err = doOpertion(EDIT_COMMENT, API_EDIT_COMMENT, payLoad);
    return err;
}
