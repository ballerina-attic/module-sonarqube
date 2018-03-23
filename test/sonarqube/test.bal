package test;

import ballerina/io;
import src;

public function main (string[] args) {

    //setup SonarQube server environment URL,username,password
    src:Connector connector = {};
    connector.initConnection(args[0], args[1], args[2]);

    //Get project
    var projectDetails = connector.getProject(args[3]);
    src:Project project = {};
    match projectDetails {
        src:Project projectInfo => project = projectInfo;
        error err => io:println(err);
    }

    //Get project complexity
    var complexity = project.getComplexity();
    match complexity {
        string value => io:println("Complexity - " + value);
        error err => io:println(err);
    }

    //Get duplicated blocks count of the project
    var duplicatedBlocksCount = project.getDuplicatedCodeBlocksCount();
    match duplicatedBlocksCount {
        int value => io:println("Duplicated blocks count - " + value);
        error err => io:println(err);
    }

    //Get duplicated files count of the project
    var duplicatedFilesCount = project.getDuplicatedFilesCount();
    match duplicatedBlocksCount {
        int value => io:println("Duplicated Files count - " + value);
        error err => io:println(err);
    }

    //Get duplicated lines count of the project
    var duplicatedLinesCount = project.getDuplicatedLinesCount();
    match duplicatedLinesCount {
        int value => io:println("Duplicated lines count - " + value);
        error err => io:println(err);
    }

    //Get blocker issues count of the project
    var blockerIssueCount = project.getBlockerIssuesCount();
    match blockerIssueCount {
        int value => io:println("Blocker issues count - " + value);
        error err => io:println(err);
    }

    //Get critical issues count of the project
    var criticalIssueCount = project.getCriticalIssuesCount();
    match criticalIssueCount {
        int value => io:println("Critical issues count - " + value);
        error err => io:println(err);
    }

    //Get major issues count of the project
    var majorIssueCount = project.getMajorIssuesCount();
    match majorIssueCount {
        int value => io:println("Major issues count - " + value);
        error err => io:println(err);
    }

    //Get open issues count of the project
    var openIssuesCount = project.getOpenIssuesCount();
    match openIssuesCount {
        int value => io:println("Open issues count - " + value);
        error err => io:println(err);
    }

    //Get confirmed issues count count of the project
    var confirmedIssueCount = project.getConfirmedIssuesCount();
    match confirmedIssueCount {
        int value => io:println("Confirmed issues count - " + value);
        error err => io:println(err);
    }

    //Get project LOC
    var lines = project.getLinesOfCode();
    match lines {
        int value => io:println("LOC - " + value);
        error err => io:println(err);
    }

    //Get uncovered lines count
    var uncoveredLinesCount = project.getUncoveredLinesCount();
    match uncoveredLinesCount {
        int value => io:println("Number of lines not cocered by unit tests - " + value);
        error err => io:println(err);
    }

    //Get number of lines should be covered by unit tests
    var linesToCover = project.getNumberOfLinesToCover();
    match linesToCover {
        int value => io:println("Lines should be covered by unit tests - " + value);
        error err => io:println(err);
    }

    //Get code smells count of the project
    var codeSmellsCount = project.getCodeSmellsCount();
    match codeSmellsCount {
        int value => io:println("Code smells  - " + value);
        error err => io:println(err);
    }

    //Get SQALE rating of the project
    var sqaleRating = project.getSQALERating();
    match sqaleRating {
        string value => io:println("SQALE rating  - " + value);
        error err => io:println(err);
    }

    //Get technical debt of the project
    var technicalDebt = project.getTechnicalDebt();
    match technicalDebt {
        string value => io:println("Technical Debt  - " + value);
        error err => io:println(err);
    }

    //Get technical debt ratio of the project
    var technicalDebtRatio = project.getTechnicalDebtRatio();
    match technicalDebtRatio {
        string value => io:println("Technical debt ratio  - " + value);
        error err => io:println(err);
    }

    //Get vulnerabilities count of the project
    var vulnerabilities = project.getVulnerabilitiesCount();
    match vulnerabilities {
        int value => io:println("Vulnerabilities  - " + value);
        error err => io:println(err);
    }

    //Get security rating of the project
    var securityRating = project.getSecurityRating();
    match securityRating {
        string value => io:println("Security Rating  - " + value);
        error err => io:println(err);
    }

    //Get bugs count of the project
    var bugsCount = project.getBugsCount();
    match bugsCount {
        int value => io:println("Bugs count  - " + value);
        error err => io:println(err);
    }

    //Get reliability rating of the project
    var reliabilityRating = project.getReliabilityRating();
    match codeSmellsCount {
        int value => io:println("Reliability rating  - " + value);
        error err => io:println(err);
    }

    ////Get project issues
    //var projectIssues = project.getIssues();
    //match projectIssues {
    //    src:Issue[] issueList => io:println(issueList);
    //    error err => io:println(err);
    //}
}