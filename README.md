# Ballerina SonarQube Connector

*[SonarQube](https://www.sonarqube.org/) is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (Source - https://en.wikipedia.org/wiki/SonarQube).

### Why would you use a Ballerina connector for SonarQube

Using Ballerina SonarQube connector you can easily get important code quality measurements of a project.Following diagram gives an overview of Ballerina SonarQube connector.

![Ballerina -SonarQube Connector Overview](sonarqube-connector.png)

## Compatibility
| Language Version        | Connector Version          | SonarQube server Versions  |
| ------------- |:-------------:| -----:|
| ballerina-tools-0.970.0-alpha0    | 0.1 | 6.7.2 |

The following sections provide you with information on how to use the Ballerina SonarQube connector.

- [Getting started](#getting-started)
- [Quick Testing](#quick-testing)
- [Working with sonarqube connector actions](#working-with-sonarqube-connector-actions)

## Getting started

1. Clone Ballerina (https://github.com/ballerina-lang/ballerina) repository and run the Maven command ``mvn clean install`` from the ``ballerina`` root directory.
2. Extract the Ballerina distribution created at `distribution/zip/ballerina/target/ballerina-<version>-SNAPSHOT.zip`  and set the PATH environment variable to the bin directory .


## Quick Testing

You can easily test the following actions using the `test.bal` file.
- Run `ballerina run tests <server_url> <token> <project_name>` from you sonarqube connector directory.


## Working with SonarQube connector actions


### getProject

Get the  details of a project in SonarQube server.

##### Parameters
1. `string` - Project Name

##### Returns

- returns key,id,uuid,version and description of a project.


### getComplexity

Get complexity of a project.This calculated based on the number of paths through the code. Whenever the control flow of a function splits, the complexity counter gets incremented by one. Each function has a minimum complexity of 1. This calculation varies slightly by language because keywords and functionalities do.
                            

##### Returns

- returns complexity of a project.


### getdDuplicatedCodeBlocksCount

Get the duplicated code blocks count of a project.

##### Returns

- returns number of duplicated code blocks in a project.

### getDuplicatedLinesCount

Get number of duplicate lines in a project.

##### Returns

- returns number of duplicated lines in a project.

### getDuplicatedFilesCount

Get the number of duplicated files in a project.

##### Returns

- returns number of duplicated files in a project.

### getBlockerIssuesCount

Get number of blocker issues in a project project.Blocker issue may be a bug with a high probability to impact the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately fixed.

##### Returns

- returns number of blocker issues in a project.

##### Example

### getCriticalIssuesCount

Get number of critical issues in a project.This can be a bug with a low probability to impact the behavior of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ... The code MUST be immediately reviewed. 

##### Returns

- returns number of critical issues in a project.

### getMajorIssuesCount

Get number of major issues in a project.These type of issues can be quality flaws which can highly impact the developer productivity: uncovered piece of code, duplicated blocks, unused parameters, ...

##### Returns

- returns number of major issues in a project.

### getMinorIssuesCount

Get number of minor issues in a project.

##### Returns

- returns number of minor issues in a project.

### getOpenIssuesCount

Get number of open issues in a project.

##### Returns

- returns number of open issues in a project.

### getConfirmedIssuesCount

Get number of confirmed issues in a project.

##### Returns

- returns number of open issues in a project.

### getLinesOfCode

Get LOC of a project.

##### Returns

- returns project LOC.

### getLineCoverage

Get line coverage of a project.

### getBranchCoverage

Get branch coverage of a project.

##### Returns

- returns branch coverage of a project.

### getCodeSmellsCount

Get number of code smells in a project.This is a maintainability-related issue in the code. Leaving it as-is means that at best maintainers will have a harder time than they should making changes to the code. At worst, they'll be so confused by the state of the code that they'll introduce additional errors as they make changes.

##### Returns

- returns number of code smells in a project.

### getSQALERating

Get SQALE rating of a project.This is the rating given to your project related to the value of your Technical Debt
Ratio.
##### Returns

- returns SQALE rating of a projet.

### getTechnicalDebt 

Get technical debt of a project.Technical debt is the effort to fix all maintainability issues.
##### Returns

- Returns technical debt of a project.

### getTechnicalDebtRatio

Get technical debt ratio of a project.

##### Returns

- Returns technical debt ratio of a project.

### getSecurityRating

Get security rating of a project.
##### Returns

- Returns security rating of a project.

### getBugsCount

Get number of bugs in a project.
##### Returns

- Returns number of bugs in a project.

### getIssues

Get details of the issues in a project.
##### Returns

- Returns an Issue type array.
