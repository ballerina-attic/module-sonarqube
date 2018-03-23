# Ballerina SonarQube Connector

*SonarQube is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (https://www.sonarqube.org/).

### Why would you use a Ballerina connector for SonarQube

Using Ballerina SonarQube connector you can easily get important code quality measurements of a project.Following diagram gives an overview of Ballerina SonarQube connector.

![Ballerina -SonarQube Connector Overview](sonarqube-connector.png)

## Compatibility
| Language Version        | Connector Version          | SonarQube server Versions  |
| ------------- |:-------------:| -----:|
| ballerina-0.963.1-SNAPSHOT     | 0.963.1 | 6.7.2 |

The following sections provide you with information on how to use the Ballerina SonarQube connector.

- [Getting started](#getting-started)
- [Quick Testing](#quick-testing)
- [Working with sonarqube connector actions](#working-with-sonarqube-connector-actions)

## Getting started

1. Clone Ballerina (https://github.com/ballerina-lang/ballerina) repository and run the Maven command ``mvn clean install`` from the ``ballerina`` root directory.
2. Extract the Ballerina distribution created at `distribution/zip/ballerina/target/ballerina-<version>-SNAPSHOT.zip`  and set the PATH environment variable to the bin directory .
3. Create a server-config-file-name.conf file with following SonarQube server credentials.

| Credential       | Description | 
| ------------- |:----------------:|
| Server_URL    |Your SonarQube server URL ex - (https://wso2.org/sonar)|
| Auth_Type  |Auth type - user or token   |
| username  |username of your SonarQube server account.If Auth_Type is user username should be provides.|
| password  |password of your SonarQube server account.If Auth_Type is user password should be provided.|
| token  |Generated token.If Auth_Type is token token should be provided.|

## Quick Testing

You can easily test the following actions using the `sample.bal` file.
- Run `ballerina run /samples/sonarqube Bballerina.conf=path/to/conf/file/server-config-file-name.conf "Project_Name"` from you sonarqube connector directory.


## Working with SonarQube connector actions

### Example

First you need to create a Project struct and initialize the struct with your project details.If you wish to get the project details from the server using a name ,you can use getProject method.

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
       io:println(err.message);
    }else{
        io:println(project.key);
        io:println(project.id);
        io:println(project.uuid);
        io:println(project.|version|);
        io:println(project.creationDate);
        io:println(project.description);
    }
```

Using the this Project struct, you can invoke other functions as follows.

```ballerina
    var complexity, err = project.getComplexity();
    if (err == null) {
        io:println("Complexity - " + complexity);
    } else {
        io:println(err.message);
    }
```
Also you can perform operations on project issues (ex - (https://wso2.org/sonar/project/issues?id=org.wso2.siddhi%3Asiddhi).You can get a set of issues and their details using,
```ballerina
    Issues[] projectIssues;
    error err;
    projectIssues, err = project.getIssues();
    if (err == null) {
        io:println(projectIssues);
    } else {
        io:println(err.message);
    }
```
For each issue in projectIssues you can perform various actions as follows.
```ballerina
   Issue issue = projectIssues[0];
   Error err = issue.addComment("This is a critical issue");
   if (err == null) {
      io:println("Adding comment successful.");
   } else {
      io:println(err);
   }
```
***

Further you can perform various actions on issue comments as follows.
```ballerina
    Comment comment = issue.comments[0];
    Error err = comment.edit("This is a blocker issue");
    if (err == null) {
      io:println("Editing comment successful.");
    } else {
      io:println(err);
    }
```

### getProject

Get the  details of a project in SonarQube server.

##### Parameters
1. `string` - Project Name

##### Returns

- returns key,id,uuid,version and description of a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
       io:println(err.message);
    }else{
        io:println(project.key);
        io:println(project.id);
        io:println(project.uuid);
        io:println(project.|version|);
        io:println(project.creationDate);
        io:println(project.description);
    }
```

```raw
org.wso2.siddhi:siddhi
46234
AVwQjVWYBabOlhFpojzj
4.1.13-SNAPSHOT
2016-10-20T14:58:30+0530
Siddhi, high performing Complex Event Processing Engine
```

### getComplexity

Get complexity of a project.This calculated based on the number of paths through the code. Whenever the control flow of a function splits, the complexity counter gets incremented by one. Each function has a minimum complexity of 1. This calculation varies slightly by language because keywords and functionalities do.
                            

##### Returns

- returns complexity of a project.

##### Example

```ballerina
    var complexity, err = project.getComplexity();
    if (err == null) {
        io:println("Complexity - " + complexity);
    } else {
        io:println(err.message);
    }   
```

```raw
Complexity - 9376
```

### getdDuplicatedCodeBlocksCount

Get the duplicated code blocks count of a project.

##### Returns

- returns number of duplicated code blocks in a project.

##### Example

```ballerina
   var duplicatedCodeBlocks, err = project.getDuplicatedCodeBlocksCount();
   if (err == null) {
      io:println("Duplicated blocks - " + duplicatedCodeBlocks);
   } else {
      io:println(err.message);
   }   
```

```raw
Duplicated blocks - 405
```

### getDuplicatedLinesCount

Get number of duplicate lines in a project.

##### Returns

- returns number of duplicated lines in a project.

##### Example

```ballerina
   var duplicatedLines, err = project.getDuplicatedLinesCount();
   if (err == null) {
      io:println("Duplicated lines - " + duplicatedLines);
   } else {
      io:println(err.message);
   }
```

```raw
Duplicated lines - 5654
```

### getDuplicatedFilesCount

Get the number of duplicated files in a project.

##### Returns

- returns number of duplicated files in a project.

##### Example

```ballerina
   var duplicatedFiles, err = project.getDuplicatedFilesCount();
   if (err == null) {
      io:println("Duplicated lines - " + duplicatedFiles);
   } else {
      io:println(err.message);
   }
```

```raw
Duplicated files - 169
```

### getBlockerIssuesCount

Get number of blocker issues in a project project.Blocker issue may be a bug with a high probability to impact the behavior of the application in production: memory leak, unclosed JDBC connection, .... The code MUST be immediately fixed.

##### Returns

- returns number of blocker issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var blockerIssues, err = project.getBlockerIssuesCount();
        if (err == null) {
            io:println("Blocker issues count - " + blockerIssues);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Blocker issues - 36
```

### getCriticalIssuesCount

Get number of critical issues in a project.This can be a bug with a low probability to impact the behavior of the application in production or an issue which represents a security flaw: empty catch block, SQL injection, ... The code MUST be immediately reviewed. 

##### Returns

- returns number of critical issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var criticalIssues, err = project.getCriticalIssuesCount();
        if (err == null) {
            io:println("Critical issues count - " + criticalIssueCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Critical issues - 34
```


### getMajorIssuesCount

Get number of major issues in a project.These type of issues can be quality flaws which can highly impact the developer productivity: uncovered piece of code, duplicated blocks, unused parameters, ...

##### Returns

- returns number of major issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var majorIssuesCount, err = project.getMajorIssuesCount();
        if (err == null) {
            io:println("Major issues - " + majorIssuesCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Major issues  - 222
```

### getMinorIssuesCount

Get number of minor issues in a project.

##### Returns

- returns number of minor issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var minorIssuesCount, err = project.getMinorIssuesCount();
        if (err == null) {
            io:println("Minor issues - " + minorIssuesCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Minor issues  - 3
```

### getOpenIssuesCount

Get number of open issues in a project.

##### Returns

- returns number of open issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var openIssuesCount, err = project.getOpenIssuesCount();
        if (err == null) {
            io:println("Open issues - " + openIssuesCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Open issues  - 296
```

### getConfirmedIssuesCount

Get number of confirmed issues in a project.

##### Returns

- returns number of open issues in a project.

##### Example

```ballerina
endpoint<sonarqube:SonarqubeConnector> sonarqubueConnector {
        create sonarqube:SonarqubeConnector();
    }

    string projectName = "siddhi";
    var project, err = sonarqubueConnector.getProject(projectName);
    if(err != null){
        io:println(err.message);
    }else{
        var confirmedIssuesCount, err = project.getConfirmedIssuesCount();
        if (err == null) {
            io:println("Open issues - " + confirmedIssuesCount);
        } else {
            io:println(err.message);
        }
    }
```

```raw
Confirmed issues  - 0
```

### getLinesOfCode

Get LOC of a project.

##### Returns

- returns project LOC.

##### Example

```ballerina
   var loc, err = project.getLinesOfCode();
   if (err == null) {
      io:println("LOC - " + loc);
   } else {
      io:println(err.message);
   }
```

```raw
loc  - 49284
```

### getLineCoverage

Get line coverage of a project.

##### Returns

- returns project LOC.

##### Example

```ballerina
   var lineCoverage, err = project.getLineCoverage();
   if (err == null) {
      io:println("Line Coverage - " + lineCoverage);
   } else {
      io:println(err.message);
   }
```

```raw
Line Coverage  - 63.8%
```

### getBranchCoverage

Get branch coverage of a project.

##### Returns

- returns branch coverage of a project.

##### Example

```ballerina
   var branchCoverage, err = project.getBranchCoverage();
   if (err == null) {
      io:println("Branch Coverage - " + branchCoverage);
   } else {
      io:println(err.message);
   }
```

```raw
Branch Coverage  - 48.8%
```

### getCodeSmellsCount

Get number of code smells in a project.This is a maintainability-related issue in the code. Leaving it as-is means that at best maintainers will have a harder time than they should making changes to the code. At worst, they'll be so confused by the state of the code that they'll introduce additional errors as they make changes.

##### Returns

- returns number of code smells in a project.

##### Example

```ballerina
   var codeSmells, err = project.getCodeSmellsCount();
   if (err == null) {
      io:println("Code Smells - " + codeSmells);
   } else {
      io:println(err.message);
   }
```

```raw
Code smells  - 210
```

### getSQALERating

Get SQALE rating of a project.This is the rating given to your project related to the value of your Technical Debt
Ratio.
##### Returns

- returns SQALE rating of a projet.

##### Example

```ballerina
   var sqaleRating, err = project.getSQALERating();
   if (err == null) {
      io:println("SQALE Rating - " + sqaleRating);
   } else {
      io:println(err.message);
   }
```

```raw
SQALE Rating  - A
```

### getTechnicalDebt 

Get technical debt of a project.Technical debt is the effort to fix all maintainability issues.
##### Returns

- Returns technical debt of a project.

##### Example

```ballerina
   var technicalDebt, err = project.getTechnicalDebt();
   if (err == null) {
      io:println("Technical Debt - " + technicalDebt);
   } else {
      io:println(err.message);
   }
```

```raw
Technical Debt  - 12d
```

### getTechnicalDebtRatio

Get technical debt ratio of a project.
##### Returns

- Returns technical debt ratio of a project.

##### Example

```ballerina
   var technicalDebtRatio, err = project.getTechnicalDebtRatio();
   if (err == null) {
      io:println("Technical Debt ratio - " + technicalDebtRatio);
   } else {
      io:println(err.message);
   }
```

```raw
Technical Debt Ratio - 0.4%
```

### getSecurityRating

Get security rating of a project.
##### Returns

- Returns security rating of a project.

##### Example

```ballerina
   var securityRating, err = project.getSecurityRating();
   if (err == null) {
      io:println("Security Rating - " + securityRating);
   } else {
      io:println(err.message);
   }
```

```raw
Security rating - E
```
### getBugsCount

Get number of bugs in a project.
##### Returns

- Returns number of bugs in a project.

##### Example

```ballerina
   var bugs, err = project.getBugsCount();
   if (err == null) {
      io:println("Bugs - " + bugs);
   } else {
      io:println(err.message);
   }
```

```raw
Bugs - 84
```
### getIssues

Get details of the issues in a project.
##### Returns

- Returns an Issue type array.

##### Example

```ballerina
   var issues, err = project.getIssues();
   if (err == null) {
      io:println("Issues - " + issues);
   } else {
      io:println(err.message);
   }
```

```json
[{key:"AWHNPxdbeGOZyq7I9jUT", severity:"CRITICAL", status:"REOPENED", description:"Add a nested comment explaining why this method is empty, throw an UnsupportedOperationException or complete the implementation.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"admin", type:"CODE_SMELL", position:{startLine:"244", endLine:"244"}, tags:["suspicious"], comments:[{text:"Commented twice", key:"AWIFT8Z8lbwWKz2gsi2v", commenter:"admin", createdDate:"2018-03-08T16:42:17+0530"}, {text:"Commented twice", key:"AWIFUCr9lbwWKz2gsi2w", commenter:"admin", createdDate:"2018-03-08T16:42:42+0530"}, {text:"Commented twice", key:"AWIFUNzTlbwWKz2gsi2x", commenter:"admin", createdDate:"2018-03-08T16:43:28+0530"}, {text:"Commented twice", key:"AWIFVavhlbwWKz2gsi2z", commenter:"admin", createdDate:"2018-03-08T16:48:43+0530"}, {text:"Commented twice", key:"AWIFVjRxlbwWKz2gsi20", commenter:"admin", createdDate:"2018-03-08T16:49:18+0530"}, {text:"Commented twice", key:"AWIFkCPllbwWKz2gsi27", commenter:"admin", createdDate:"2018-03-08T17:52:35+0530"}, {text:"Commented twice", key:"AWIGh0stlbwWKz2gsi3O", commenter:"admin", createdDate:"2018-03-08T22:22:32+0530"}, {text:"dfdsfdsfsdf", key:"AWIJDkct_-7zbL4nGS2X", commenter:"admin", createdDate:"2018-03-09T10:09:13+0530"}, {text:"Commented twice", key:"AWIJS05__-7zbL4nGS2f", commenter:"admin", createdDate:"2018-03-09T11:15:53+0530"}, {text:"Commented twice", key:"AWIJXBUU_-7zbL4nGS2h", commenter:"admin", createdDate:"2018-03-09T11:34:12+0530"}, {text:"Commented twice", key:"AWIJaGY__-7zbL4nGS2j", commenter:"admin", createdDate:"2018-03-09T11:47:39+0530"}, {text:"Commented twice", key:"AWIJ8wUv_-7zbL4nGS21", commenter:"admin", createdDate:"2018-03-09T14:19:04+0530"}, {text:"Commented twice", key:"AWIJ-Ep4_-7zbL4nGS22", commenter:"admin", createdDate:"2018-03-09T14:24:49+0530"}, {text:"Commented twice", key:"AWIJ_EgL_-7zbL4nGS23", commenter:"admin", createdDate:"2018-03-09T14:29:11+0530"}, {text:"Commented twice", key:"AWIJ_9Sl_-7zbL4nGS26", commenter:"admin", createdDate:"2018-03-09T14:33:03+0530"}, {text:"Commented twice", key:"AWIKAP-t_-7zbL4nGS27", commenter:"admin", createdDate:"2018-03-09T14:34:20+0530"}, {text:"Commented twice", key:"AWIKDOgc_-7zbL4nGS29", commenter:"admin", createdDate:"2018-03-09T14:47:20+0530"}, {text:"Commented twice", key:"AWIKDvJh_-7zbL4nGS2-", commenter:"admin", createdDate:"2018-03-09T14:49:34+0530"}, {text:"Commented twice", key:"AWIV9fN4uuV5SMse6Os1", commenter:"admin", createdDate:"2018-03-11T22:17:42+0530"}, {text:"Commented twice", key:"AWIV9lcRuuV5SMse6Os2", commenter:"admin", createdDate:"2018-03-11T22:18:08+0530"}, {text:"Commented twice", key:"AWIWmF58JsU56-uZKe6-", commenter:"admin", createdDate:"2018-03-12T01:15:07+0530"}, {text:"Commented twice", key:"AWIWqEUmJsU56-uZKe6_", commenter:"admin", createdDate:"2018-03-12T01:32:29+0530"}, {text:"Commented twice", key:"AWIX_tv6FDh_MWY4XEGP", commenter:"admin", createdDate:"2018-03-12T07:46:41+0530"}, {text:"Commented twice", key:"AWIYaAZVFDh_MWY4XEGQ", commenter:"admin", createdDate:"2018-03-12T09:41:33+0530"}, {text:"Commented twice", key:"AWIZcMMVW2RiVJc65629", commenter:"admin", createdDate:"2018-03-12T14:30:43+0530"}, {text:"Commented twice", key:"AWIZtioSFoU2c7ElafGc", commenter:"admin", createdDate:"2018-03-12T15:46:31+0530"}, {text:"Commented twice", key:"AWIZ71uCFoU2c7ElafGk", commenter:"admin", createdDate:"2018-03-12T16:48:59+0530"}, {text:"Commented twice", key:"AWIZ89uIFoU2c7ElafGl", commenter:"admin", createdDate:"2018-03-12T16:53:54+0530"}, {text:"Commented twice", key:"AWIaFMwRFoU2c7ElafGs", commenter:"admin", createdDate:"2018-03-12T17:29:53+0530"}, {text:"Commented twice", key:"AWIaHnseFoU2c7ElafGt", commenter:"admin", createdDate:"2018-03-12T17:40:27+0530"}, {text:"Commented twice", key:"AWIaIyiCFoU2c7ElafGx", commenter:"admin", createdDate:"2018-03-12T17:45:34+0530"}, {text:"Commented twice", key:"AWIaaLc8FoU2c7ElafG6", commenter:"admin", createdDate:"2018-03-12T19:01:33+0530"}, {text:"Commented twice", key:"AWIaazTVFoU2c7ElafG7", commenter:"admin", createdDate:"2018-03-12T19:04:16+0530"}, {text:"Commented twice", key:"AWIabhObFoU2c7ElafG8", commenter:"admin", createdDate:"2018-03-12T19:07:24+0530"}, {text:"Commented twice", key:"AWIafuepFoU2c7ElafG_", commenter:"admin", createdDate:"2018-03-12T19:25:47+0530"}, {text:"Commented twice", key:"AWIajKttFoU2c7ElafHC", commenter:"admin", createdDate:"2018-03-12T19:40:49+0530"}, {text:"Commented twice", key:"AWIajhllFoU2c7ElafHD", commenter:"admin", createdDate:"2018-03-12T19:42:23+0530"}, {text:"Commented twice", key:"AWIa2R99FoU2c7ElafHN", commenter:"admin", createdDate:"2018-03-12T21:04:19+0530"}, {text:"Commented twice", key:"AWIa2-sMFoU2c7ElafHO", commenter:"admin", createdDate:"2018-03-12T21:07:22+0530"}, {text:"This is a critical issue", key:"AWIdBOfRTHdgAWP4zQeS", commenter:"admin", createdDate:"2018-03-13T07:11:23+0530"}, {text:"This is a critical issue", key:"AWIdD_KGTHdgAWP4zQeT", commenter:"admin", createdDate:"2018-03-13T07:23:27+0530"}, {text:"This is a critical issue", key:"AWIdfI-nTHdgAWP4zQeU", commenter:"admin", createdDate:"2018-03-13T09:22:05+0530"}, {text:"This is a critical issue", key:"AWIdzkZoTHdgAWP4zQeV", commenter:"admin", createdDate:"2018-03-13T10:51:20+0530"}, {text:"This is a critical issue", key:"AWIdzsS8THdgAWP4zQeW", commenter:"admin", createdDate:"2018-03-13T10:51:52+0530"}, {text:"This is a critical issue", key:"AWIiNM9WnMG7m_5Y9fzY", commenter:"admin", createdDate:"2018-03-14T07:21:49+0530"}, {text:"This is a critical issue", key:"AWIi5QLZiJF50uDelfMr", commenter:"admin", createdDate:"2018-03-14T10:34:16+0530"}, {text:"This is a critical issue", key:"AWIi9gTyiJF50uDelfMs", commenter:"admin", createdDate:"2018-03-14T10:52:51+0530"}, {text:"This is a critical issue", key:"AWIi9oDviJF50uDelfMt", commenter:"admin", createdDate:"2018-03-14T10:53:22+0530"}, {text:"This is a critical issue", key:"AWIi9um8iJF50uDelfMu", commenter:"admin", createdDate:"2018-03-14T10:53:49+0530"}, {text:"This is a critical issue", key:"AWIi-A_jiJF50uDelfMv", commenter:"admin", createdDate:"2018-03-14T10:55:05+0530"}, {text:"This is a critical issue", key:"AWIkSRHFiJF50uDelfMw", commenter:"admin", createdDate:"2018-03-14T17:03:11+0530"}, {text:"This is a critical issue", key:"AWIn7T7NCZxq2ws8dzir", commenter:"admin", createdDate:"2018-03-15T10:01:22+0530"}, {text:"This is a critical issue", key:"AWIn8aOkCZxq2ws8dzis", commenter:"admin", createdDate:"2018-03-15T10:06:10+0530"}, {text:"This is a critical issue", key:"AWIn_FhcCZxq2ws8dzit", commenter:"admin", createdDate:"2018-03-15T10:17:51+0530"}, {text:"This is a critical issue", key:"AWIoGNI_CZxq2ws8dziu", commenter:"admin", createdDate:"2018-03-15T10:48:58+0530"}], workflowTransitions:[]}, {key:"AWHNPxe0eGOZyq7I9jUe", severity:"MAJOR", status:"OPEN", description:"Add a nested comment explaining why this method is empty, throw an UnsupportedOperationException or complete the implementation.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"251", endLine:"251"}, tags:["suspicious"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe1eGOZyq7I9jUf", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"188", endLine:"188"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe2eGOZyq7I9jUg", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"212", endLine:"212"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe3eGOZyq7I9jUh", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"233", endLine:"233"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe3eGOZyq7I9jUi", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"237", endLine:"237"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe5eGOZyq7I9jUj", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"242", endLine:"242"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe6eGOZyq7I9jUk", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"247", endLine:"247"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxe7eGOZyq7I9jUl", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"251", endLine:"251"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeQeGOZyq7I9jUU", severity:"MAJOR", status:"OPEN", description:"Add a nested comment explaining why this method is empty, throw an UnsupportedOperationException or complete the implementation.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"279", endLine:"279"}, tags:["suspicious"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeSeGOZyq7I9jUV", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"248", endLine:"248"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeTeGOZyq7I9jUW", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"274", endLine:"274"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeUeGOZyq7I9jUX", severity:"MAJOR", status:"OPEN", description:"Add the "@Override" annotation above this method signature", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"279", endLine:"279"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxefeGOZyq7I9jUY", severity:"BLOCKER", status:"OPEN", description:"Change this condition so that it does not always evaluate to "false"", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"BUG", position:{startLine:"70", endLine:"70"}, tags:["cwe", "misra"], comments:[], workflowTransitions:[]}, {key:"AWHNPxegeGOZyq7I9jUZ", severity:"MAJOR", status:"OPEN", description:"Make sourceEventListener a static final constant or non-public and provide accessors if needed.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"37", endLine:"37"}, tags:["cwe"], comments:[], workflowTransitions:[]}, {key:"AWHNPxegeGOZyq7I9jUa", severity:"MAJOR", status:"OPEN", description:"Add a nested comment explaining why this method is empty, throw an UnsupportedOperationException or complete the implementation.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"84", endLine:"84"}, tags:["suspicious"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeteGOZyq7I9jUb", severity:"MAJOR", status:"OPEN", description:"1 more branches need to be covered by unit tests to reach the minimum threshold of 65.0% branch coverage.", author:"rukshani@wso2.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"null", endLine:"null"}, tags:["bad-practice"], comments:[], workflowTransitions:[]}, {key:"AWHNPxeyeGOZyq7I9jUc", severity:"MINOR", status:"OPEN", description:"Define a constant instead of duplicating this literal " defined in Siddhi App: " 4 times.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"207", endLine:"207"}, tags:["design"], comments:[], workflowTransitions:[]}, {key:"AWHNPxezeGOZyq7I9jUd", severity:"MAJOR", status:"OPEN", description:"Add a nested comment explaining why this method is empty, throw an UnsupportedOperationException or complete the implementation.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"233", endLine:"233"}, tags:["suspicious"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfEeGOZyq7I9jUm", severity:"CRITICAL", status:"OPEN", description:"Remove this hard-coded password.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"VULNERABILITY", position:{startLine:"31", endLine:"31"}, tags:["cwe", "owasp-a2", "sans-top25-porous"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfFeGOZyq7I9jUn", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"28", endLine:"28"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfFeGOZyq7I9jUo", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"29", endLine:"29"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfGeGOZyq7I9jUp", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"30", endLine:"30"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfHeGOZyq7I9jUq", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"31", endLine:"31"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfHeGOZyq7I9jUr", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"32", endLine:"32"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfIeGOZyq7I9jUs", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"33", endLine:"33"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfJeGOZyq7I9jUt", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"34", endLine:"34"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfJeGOZyq7I9jUu", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"35", endLine:"35"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfKeGOZyq7I9jUv", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"36", endLine:"36"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfLeGOZyq7I9jUw", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"37", endLine:"37"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfLeGOZyq7I9jUx", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"38", endLine:"38"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfMeGOZyq7I9jUy", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"39", endLine:"39"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfNeGOZyq7I9jU0", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"41", endLine:"41"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfNeGOZyq7I9jUz", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"40", endLine:"40"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfOeGOZyq7I9jU1", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"42", endLine:"42"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfOeGOZyq7I9jU2", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"43", endLine:"43"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfPeGOZyq7I9jU3", severity:"MINOR", status:"OPEN", description:"Move this variable to comply with Java Code Conventions.", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"44", endLine:"44"}, tags:["convention"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfVeGOZyq7I9jU4", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"53", endLine:"53"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfWeGOZyq7I9jU5", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"83", endLine:"83"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxf_eGOZyq7I9jVK", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"59", endLine:"59"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfaeGOZyq7I9jU6", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"59", endLine:"59"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfbeGOZyq7I9jU7", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"98", endLine:"98"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfceGOZyq7I9jU8", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"140", endLine:"140"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfheGOZyq7I9jU9", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"59", endLine:"59"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfieGOZyq7I9jU-", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"97", endLine:"97"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfieGOZyq7I9jU_", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"136", endLine:"136"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfteGOZyq7I9jVA", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"68", endLine:"68"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfueGOZyq7I9jVB", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"104", endLine:"104"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfveGOZyq7I9jVC", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"143", endLine:"143"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfveGOZyq7I9jVD", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"226", endLine:"226"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfweGOZyq7I9jVE", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"266", endLine:"266"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfweGOZyq7I9jVF", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"305", endLine:"305"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfxeGOZyq7I9jVG", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"345", endLine:"345"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfxeGOZyq7I9jVH", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"383", endLine:"383"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfyeGOZyq7I9jVI", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"423", endLine:"423"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxfyeGOZyq7I9jVJ", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"434", endLine:"434"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgAeGOZyq7I9jVL", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"100", endLine:"100"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgBeGOZyq7I9jVM", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"155", endLine:"155"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgFeGOZyq7I9jVN", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"64", endLine:"64"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgGeGOZyq7I9jVO", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"100", endLine:"100"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgNeGOZyq7I9jVP", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"68", endLine:"68"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgNeGOZyq7I9jVQ", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"103", endLine:"103"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgOeGOZyq7I9jVR", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"153", endLine:"153"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgOeGOZyq7I9jVS", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"264", endLine:"264"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgPeGOZyq7I9jVT", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"318", endLine:"318"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgPeGOZyq7I9jVU", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"372", endLine:"372"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgQeGOZyq7I9jVV", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"426", endLine:"426"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgQeGOZyq7I9jVW", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"477", endLine:"477"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}, {key:"AWHNPxgReGOZyq7I9jVX", severity:"MAJOR", status:"OPEN", description:"Remove this use of "Thread.sleep()".", author:"hamsav26@gmail.com", creationDate:"2018-02-25T19:25:13+0530", assignee:"null", type:"CODE_SMELL", position:{startLine:"538", endLine:"538"}, tags:["bad-practice", "tests"], comments:[], workflowTransitions:[]}]
```

### addComment

Comment on an issue 

##### Parameters
1. `string` - Comment

##### Returns

- Returns error.Null if adding comment is successful else the error details.

##### Example

```ballerina
   Issue issue = issues[0];
   error err = issue.addComment("This should be fixed immediately.");
   if (err == null) {
      io:println("Adding comment successful.");
   } else {
      io:println(err.message);
   }
```

```raw
Adding comment successful.
```

### assign

Assign an issue to a SonarQube user 

##### Parameters
1. `string` - Assignee's username

##### Returns

- Returns error.Null if assigning issue is successful else the error details.

##### Example

```ballerina
   err = issue.assign("robert123");
   if (err == null) {
      io:println("Assigning user is successful.");
   } else {
      io:println(err);
   }
```

```raw
"Setting severity is successful."
```
### setSeverity

Set severity of an issue.(BLOCKER,CRITICAL,MAJOR,MINOR,INFO)(https://docs.sonarqube.org/display/SONAR/Issues)

##### Parameters
1. `string` - Severity Level(BLOCKER,CRITICAL,MAJOR,MINOR,INFO)
                        
##### Returns

- Returns error.Null if setting severity is successful else the error details.

##### Example

```ballerina
   err = issue.setSeverity("BLOCKER");
   if (err == null) {
      io:println("Setting severity is successful.");
   } else {
      io:println(err);
   }
```

```raw
Assigning user to the issue successful.
```
### setStatus

Set status of an issue.(Open,Confirmed,Resolved,Reopened,Closed)(https://docs.sonarqube.org/display/SONAR/Issue+Lifecycle)

##### Parameters
1. `string` - Status type

##### Returns

- Returns error.Null if setting status is successful else the error details.

##### Example

```ballerina
   err = issue.setStatus("Open");
   if (err == null) {
      io:println("Setting up issue status is successful.");
   } else {
      io:println(err);
   }
```

```raw
Assigning user to the issue successful.
```

### setType

Set type of an issue.(CODE_SMELL, BUG, VULNERABILITY)(https://docs.sonarqube.org/display/SONAR/Issue+Lifecycle)

##### Parameters
1. `string` - CODE_SMELL, BUG, VULNERABILITY

##### Returns

- Returns error.Null if setting type is successful else the error details.

##### Example

```ballerina
   err = issue.setType("BUG");
   if (err == null) {
      io:println("Setting up issue type is successful.");
   } else {
      io:println(err);
   }
```

```raw
Setting up issue type is successful.
```

### delete

Delete a comment.
##### Returns

- Returns error.Null if adding comment is successful else the error details.

##### Example

```ballerina
   err = comment.delete();
   if (err == null) {
      io:println("Comment deleted.");
   } else {
      io:println(err);
   }
```

```raw
Deleting comment is successful.
```


### edit

Edit a comment.

##### Parameters
1. `string` - New Comment

##### Returns

- Returns error.Null if comment edited is successful else the error details.

##### Example

```ballerina
   err = comment.edit("Comment edited.");
   if (err == null) {
      io:println("Comment edited.");
   } else {
      io:println(err);
   }
```

```raw
Comment edited.
```
