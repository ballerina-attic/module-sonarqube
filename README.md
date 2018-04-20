# SonarQube Connector

GMail connector provides a Ballerina API to access the [Gmail REST API](https://developers.google.com/gmail/api/v1/reference/). It handles [OAuth2.0](http://tools.ietf.org/html/rfc6749), provides auto completion and type safety.

## Compatibility

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

      ``<PROJECT_ROOT_DIRECTORY>$ ballerina init``

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