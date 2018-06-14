# SonarQube Connector

SonarQube connector provides a Ballerina API to access the [SonarQube REST API](https://docs.sonarqube.org/display/DEV/Web+API)

## Compatibility

| Ballerina Language Version                   | API Version     
| ---------------------------------------------| :--------------:
| 0.974.1                                      | 6.7.2

## Getting started

1.  Refer [Getting Strated Guide](https://stage.ballerina.io/learn/getting-started/) to download and install Ballerina.
2.  To use SonarQube endpoint, you need to provide the following:

       - SonarQube URL
       - SonarQube token
    
       Refer [SonarQube API docuementation](https://docs.sonarqube.org/display/SONAR/User+Token) to obtain the above credentials.

4. Create a new Ballerina project by executing the following command.

      ``<PROJECT_ROOT_DIRECTORY>$ ballerina init``

5. Import the sonarqube package to your Ballerina project as follows.

```ballerina
import ballerina/io;
import wso2/sonarqube6;

string token = "your token";
string sonarqubeURL = "your sonarqube url";

function main(string... args) {

   endpoint Client sonarqube {
       clientConfig:{
           url:sonarqubeURL,
           auth:{
               scheme:"basic",
               username:token,
               password:""
           }
       }
   };
   
   var projectDetails = sonarqube -> getProject(config:getAsString(PROJECT_NAME));
       match projectDetails {
           Project project => io:println(projects);
           error err => io:println(err);
       }
}
```