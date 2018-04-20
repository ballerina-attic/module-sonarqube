# SonarQube Connector

<<<<<<< HEAD
GMail connector provides a Ballerina API to access the [Gmail REST API](https://developers.google.com/gmail/api/v1/reference/). It handles [OAuth2.0](http://tools.ietf.org/html/rfc6749), provides auto completion and type safety.

## Compatibility
=======
*[SonarQube](https://www.sonarqube.org/) is an open source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells and security vulnerabilities on 20+ programming languages including Java (including Android), C#, PHP, JavaScript, C/C++, COBOL, PL/SQL, PL/I, ABAP, VB.NET, VB6, Python, RPG, Flex, Objective-C, Swift, Web and XML.* (Source - https://en.wikipedia.org/wiki/SonarQube).

### Why would you use a Ballerina connector for SonarQube

Using Ballerina SonarQube connector you can easily get important code quality measurements of a project.Following diagram gives an overview of Ballerina SonarQube connector.

![Ballerina -SonarQube Connector Overview](./resources/sonarqube-connector.png)

## Compatibility
| Language Version        | Connector Version          | SonarQube server Versions  |
| ------------- |:-------------:| -----:|
| 0.970.0-beta1-SNAPSHOT    | 0.8.2                | 6.7.2         |

The following sections provide you with information on how to use the Ballerina SonarQube connector.
>>>>>>> 9e35213a21b5901cb08b67cc32061d5417cfdcc5

| Ballerina Language Version                   | Connector Version           | API Version
| ---------------------------------------------|:--------------------------:| :--------------:
| 0.970.0-beta3                                | 0.8.7                      | 6.7.2

## Getting started

1.  Refer https://stage.ballerina.io/learn/getting-started/ to download and install Ballerina.
2.  To use GMail endpoint, you need to provide the following:

       - SonarQube URL
       - Token
    
       Refer https://docs.sonarqube.org/display/SONAR/User+Token to obtain the above credentials.

4. Create a new Ballerina project by executing the following command.

<<<<<<< HEAD
      ``<PROJECT_ROOT_DIRECTORY>$ ballerina init``
=======
```ballerina
   endpoint sonarqube:SonarQubeEndpoint sonarqubeEP {
        clientConfig: {
                targets:[{url:getURI()}],
                auth:{
                    scheme:"basic",
                    username:getToken(),
                    password:""
                }
            }
    };
```
2.Get a project from SonarQube server.

```ballerina
    Project project = {};
    var projectDetails = sonarqubeEP -> getProject("project_name");
    match projectDetails {
       sonarqube:Project projectDetails => project = projectDetails;
       error err => io:println(err);
    }
```

5. Import the gmail package to your Ballerina project as follows.

```ballerina
import ballerina/io;
import wso2/sonarqube6;

string url = "YOUR_SONARQUBE_URL";
string token = "YOUR SONARQUBE_TOKEN";

function main(string... args) {

   endpoint sonarqube6:Client sonarqubeClient {
       clientConfig:{
           url:url,
           auth:{
               scheme:"basic",
               token:token,
               password:""
           }
       }
   };

   var value = sonarqube -> getAllProjects();
       match value {
           Project[] projects => {
               io:println(projects);
           }
           error err => io:println(err);;
       }
}
```