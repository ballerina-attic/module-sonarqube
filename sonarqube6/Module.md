Connects to SonarQube from Ballerina.

# Module Overview

The SonarQube connector allows you to work with projects and get important code-quality measurements like line coverage, branch coverage, code smells, etc through the SonarQube API. It handles basic authentication.

**SonarQube Project Operations**

The `wso2/sonarqube6` module contains operations that get the details of SonarQube projects and their code-quality 
measurements such as line coverage, branch coverage, complexities, technical debt, technical debt ratio, duplicated lines 
count. etc. Users can also use this connector to get multiple code-quality measurements as a map by providing the required metric keys.


## Compatibility

|                    |    Version     |  
| ------------------ | -------------- |
| Ballerina Language |   0.990.3      |
| SonarQube API      |   6.7.2        |


## Sample

First, import the `wso2/sonarqube6` module into the Ballerina project.
    
```ballerina
import wso2/sonarqube6;
```

**Obtaining Tokens to Run the Samples**

1. To generate a token, go to **User -> My Account -> Security** in the SonarQube server. Existing tokens are listed, each with a **Revoke** button.
2. Click the **Generate** button at the bottom of the page.

You can now enter the token in the HTTP client config:
```ballerina
sonarqube6:SonarQubeConfiguration sonarqubeConfig = {
    clientConfig:{
        url:sonarqubeURL,
        auth:{
            scheme:http:BASIC_AUTH,
            username:token,
            password:""
        }
    }
};
   
sonarqube6:Client sonarqubeClient = new(sonarqubeConfig);
```

The `getProject` function provides the details of a project in SonarQube server for the given project name.

```ballerina
var projectDetails = sonarqubeClient->getProject(“project_name”);
```

The response from `getProject` is either a `Project` if the request was successful or an `error` if unsuccessful.
The `Project` is a type that holds the information of a project.

```ballerina
if (projectDetails is sonarqube6:Project) {
   io:println("Prohect Details: ", projectDetails)
} else {
   io:println("Error: ", <string>projectDetails.detail().message);
}
```

The `getLineCoverage` function provides the line coverage of a project in SonarQube server for the given project key. 
You can get the project key using the SonarQube server UI or the `getProject` function.

```ballerina
var response = sonarqubeClient->getLineCoverage(“project_key”);
```
    
The response from `getLineCoverage` is either a `string` if the request was successful or an `error` if unsuccessful.


```ballerina
if (response is string) {
   io:println("Line Coverage: ", response)
} else {
   io:println("Error: ", <string>response.detail().message);
}
``` 

The `getSecurityRating` function provides the security rating of a project in SonarQube server for the given project key. 
You can get the project key using the SonarQube server UI or the `getProject` function.

```ballerina
var response = sonarqubeClient->getSecurityRating(“project_key”);
```

The response from `getSecurityRating` is either a `string` (if the request was successful) or an `error` if unsuccessful.


```ballerina
if (response is string) {
   io:println("Security Rating: ", response)
} else {
   io:println("Error: ", <string>response.detail().message);
}
```
