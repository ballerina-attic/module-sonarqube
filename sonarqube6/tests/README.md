# Ballerina SonarQube Connector - Tests

Ballerina SonarQube connector allows you to access the [SonarQube REST API](https://docs.sonarqube.org/display/DEV/Web+API) and perform 
various actions.

## Compatibility
| Language Version                           | Connector Version   | SonarQube API Version |
| ------------------------------------------ | ------------------- | ------------------ |
| 0.970.0-beta1-SNAPSHOT    | 0.8.2                | 6.7.2         |

## Running tests

All the tests inside this package will make HTTP calls to the SoarQube REST API.

In order to run the tests, the user will need to have a SonarQube account and and a token.

- To generate a token, to go User > My Account > Security. Your existing tokens are listed here, each with a Revoke button.

- The form at the bottom of the page allows you to generate new tokens. Once you click the generate button, you will see the token value. Copy it immediately; once you dismiss the notification you will not be able to retrieve it.

After that create a Ballerina.conf file inside package-sonarqube and add following details.

###### ballerina.conf
```.conf
sonarqube_uri = ""
sonarqube_token = ""
project_name = ""
project_key = ""
```

| Parameter   | Description                                                                                  |
| ----------- | -------------------------------------------------------------------------------------------- |
| sonarqube_uri    | The base url of your SonarQube server.                                                                 |
| sonarqube_token | Auth token of your SonarQube account.                                                      |
|project_name | Name of a project in SonarQube server.                        |
| project_key  | Key of a project in SonarQube server.                        |

Run tests :
```
ballerina init
ballerina test sonarqube6
```