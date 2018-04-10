# Ballerina SonarQube Connector

*[SonarQube](https://www.sonarqube.org/) is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (Source - https://en.wikipedia.org/wiki/SonarQube).

### Why would you use a Ballerina connector for SonarQube

Using Ballerina SonarQube connector you can easily get important code quality measurements of a project.Following diagram gives an overview of Ballerina SonarQube connector.

![Ballerina -SonarQube Connector Overview](sonarqube-connector.png)

## Compatibility
| Language Version        | Connector Version          | SonarQube server Versions  |
| ------------- |:-------------:| -----:|
| ballerina-tools-0.970.0-alpha0    | 0.8.1 | 6.7.2 |

The following sections provide you with information on how to use the Ballerina SonarQube connector.

- [Getting started](#getting-started)
- [Working with sonarqube connector actions](#working-with-sonarqube-connector-actions)

## Getting started

1. Clone Ballerina (https://github.com/ballerina-lang/ballerina) repository and run the Maven command ``mvn clean install`` from the ``ballerina`` root directory.
2. Extract the Ballerina distribution created at `distribution/zip/ballerina/target/ballerina-<version>-SNAPSHOT.zip`  and set the PATH environment variable to the bin directory .

## Working with SonarQube connector actions

1.Create a SonarQube endpoint.

```ballerina
   endpoint sonarqube:SonarQubeClient sonarqube {
        token:"sonarqube_token",
        uri:"sonarqube_uri",
    };
```
2.Get a project from SonarQube server.

```ballerina
    Project project = {};
    var projectDetails = sonarqube -> getProject("project_name");
    match projectDetails {
       sonarqube:Project projectDetails => project = projectDetails;
       error err => io:println(err);
    }
```

3.Using the project you can call the set of functions defined below.

```ballerina
    //Get project complexity
    var complexity = sonarqube -> getComplexity(project.key);
    match complexity {
        string value => io:println("Complexity - " + value);
        error err => io:println(err);
    }
```