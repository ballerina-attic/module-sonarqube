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

package samples.sonarqube;

import ballerina.io;
import src.sonarqube;

function main (string[] serverArgs) {
    endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = serverArgs[0];

    //get project details
    var project, err = sonarqubueConnector.getProject(projectName);
    if (err != null) {
        return;
    } else {
        io:println(project);
    }

    //Get project line coverage
    var lineCoverage, err = project.getLineCoverage();
    if (err == null) {
        io:println("Line coverage - " + lineCoverage);
    } else {
        io:println(err.message);
    }

    //Get project branch coverage
    var branchCoverage, err = project.getBranchCoverage();
    if (err == null) {
        io:println("Branch coverage -" + branchCoverage);
    } else {
        io:println(err);
    }

    //Get project complexity
    var complexity, err = project.getComplexity();
    if (err == null) {
        io:println("Complexity - " + complexity);
    } else {
        io:println(err.message);
    }

    //Get duplicated blocks count of the project
    var duplicatedBlocksCount, err = project.getDuplicatedCodeBlocksCount();
    if (err == null) {
        io:println("Duplicated blocks count - " + duplicatedBlocksCount);
    } else {
        io:println(err.message);
    }

    //Get duplicated lines count of the project
    var duplicatedLinesCount, err = project.getDuplicatedLinesCount();
    if (err == null) {
        io:println("Duplicated lines count - " + duplicatedLinesCount);
    } else {
        io:println(err.message);
    }

    //Get duplicated files count of the project
    var duplicatedFilesCount, err = project.getDuplicatedFilesCount();
    if (err == null) {
        io:println("Duplicated files count - " + duplicatedFilesCount);
    } else {
        io:println(err.message);
    }

    //Get blocker issues count of the project
    var blockerIssueCount, err = project.getBlockerIssuesCount();
    if (err == null) {
        io:println("Blocker issues count - " + blockerIssueCount);
    } else {
        io:println(err.message);
    }

    //Get critical issues count of the project
    var criticalIssueCount, err = project.getCriticalIssuesCount();
    if (err == null) {
        io:println("Critical issues count - " + criticalIssueCount);
    } else {
        io:println(err.message);
    }

    //Get major issues count of the project
    var majorIssueCount, err = project.getMajorIssuesCount();
    if (err == null) {
        io:println("Major issues count - " + majorIssueCount);
    } else {
        io:println(err.message);
    }

    //Get open issues count of the project
    var openIssuesCout, err = project.getOpenIssuesCount();
    if (err == null) {
        io:println("Open issues count - " + openIssuesCout);
    } else {
        io:println(err.message);
    }

    //Get reopened issues count of the project
    var reopenedIssuesCount, err = project.getReopenedIssuesCount();
    if (err == null) {
        io:println("Reopened issues count - " + reopenedIssuesCount);
    } else {
        io:println(err.message);
    }

    //Get confirmed issues count count of the project
    var confirmedIssueCount, err = project.getConfirmedIssuesCount();
    if (err == null) {
        io:println("Confirmed issues count - " + confirmedIssueCount);
    } else {
        io:println(err.message);
    }

    //Get project LOC
    var lines, err = project.getLinesOfCode();
    if (err == null) {
        io:println("Lines of code - " + lines);
    } else {
        io:println(err.message);
    }

    //Get uncovered lines count
    var uncoveredLinesCount, err = project.getUncoveredLinesCount();
    if (err == null) {
        io:println("Uncovered Lines Count - " + uncoveredLinesCount);
    } else {
        io:println(err.message);
    }

    //Get number of lines should be covered by unit tests
    var linesToCover, err = project.getNumberOfLinesToCover();
    if (err == null) {
        io:println("Lines to cover - " + linesToCover);
    } else {
        io:println(err.message);
    }

    //Get code smells count of the project
    var codeSmellsCount, err = project.getCodeSmellsCount();
    if (err == null) {
        io:println("Code smells count - " + codeSmellsCount);
    } else {
        io:println(err.message);
    }

    //Get SQALE rating of the project
    var sqaleRating, err = project.getSQALERating();
    if (err == null) {
        io:println("SQALE rating - " + sqaleRating);
    } else {
        io:println(err.message);
    }

    //Get technical debt of the project
    var technicalDebt, err = project.getTechnicalDebt();
    if (err == null) {
        io:println("Technical debt - " + technicalDebt);
    } else {
        io:println(err.message);
    }

    //Get technical debt ratio of the project
    var technicalDebtRatio, err = project.getTechnicalDebtRatio();
    if (err == null) {
        io:println("Technical debt ratio - " + technicalDebtRatio);
    } else {
        io:println(err.message);
    }

    //Get vulnerabilities count of the project
    var vulnerabilities, err = project.getVulnerabilitiesCount();
    if (err == null) {
        io:println("Vulnerabilities count - " + vulnerabilities);
    } else {
        io:println(err.message);
    }

    //Get security rating of the project
    var securityRating, err = project.getSecurityRating();
    if (err == null) {
        io:println("Security Rating - " + securityRating);
    } else {
        io:println(err.message);
    }

    //Get bugs count of the project
    var bugsCount, err = project.getBugsCount();
    if (err == null) {
        io:println("Bugs Count - " + bugsCount);
    } else {
        io:println(err.message);
    }

    //Get reliability rating of the project
    var reliabilityRating, err = project.getReliabilityRating();
    if (err == null) {
        io:println("Reliability rating - " + reliabilityRating);
    } else {
        io:println(err.message);
    }

    //Get project issues
    var projectIssues, err = project.getIssues();
    if (err == null) {
        io:print("Issues - ");
        io:println(projectIssues);
    } else {
        io:println(err.message);
    }

    ////Operations on issues
    //sonarqube:Issue issue = projectIssues[0];
    //
    ////Add a comment on issues
    //err = issue.addComment("This is a test comment from SonarQube connector.");
    //if (err == null) {
    //    io:println("Adding comment successful.");
    //} else {
    //    io:println(err);
    //}
    //
    ////Assign issue
    //err = issue.assign("admin");
    //if (err == null) {
    //    io:println("Assigning user to a issue successful.");
    //} else {
    //    io:println(err);
    //}
    //
    ////Set issue severity
    //err = issue.setSeverity("CRITICAL");
    //if (err == null) {
    //    io:println("Setting issue severity successful.");
    //} else {
    //    io:println(err);
    //}
    //
    ////Set issue type
    //err = issue.setType("CODE_SMELL");
    //if (err == null) {
    //    io:println("Setting issue type successful.");
    //} else {
    //    io:println(err);
    //}
    //
    ////Operations on issue comments
    //sonarqube:Comment comment = issue.comments[0];
    //
    ////Edit comment
    //err = comment.edit("This is a test comment from SonarQube connector.");
    //if (err == null) {
    //    io:println("Editing comment successful.");
    //} else {
    //    io:println(err);
    //}
    //
    ////Delete comment
    //err = comment.delete();
    //if (err == null) {
    //    io:println("Deleting comment successful.");
    //} else {
    //    io:println(err);
    //}
}

