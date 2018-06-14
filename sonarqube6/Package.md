Connects to SonarQube from Ballerina.

# Package Overview

The SonarQube connector allows you to work with projects and get important code-quality measurements like line coverage, branch coverage, code smells, etc through the SonarQube API. It handles basic authentication.

**SonarQube Project Operations**

The `wso2/sonarqube6` package contains operations that get the details of SonarQube projects and their code-quality 
measurements such as line coverage, branch coverage, complexities, technical debt, technical debt ratio, duplicated lines 
count. etc. Users can also use this connector to get multiple code-quality measurements as a map by providing the required metric keys.


## Compatibility

|                    |    Version     |  
|  ----------------- | -------------- | 
| Ballerina Language |   0.974.1      |
|  SonarQube API     |   6.7.2        |


## Sample

First, import the `wso2/sonarqube6` package into the Ballerina project.
    
```ballerina
import wso2/sonarqube6;
```

**Obtaining Tokens to Run the Samples**

1. To generate a token, go to **User -> My Account -> Security** in the SonarQube server. Existing tokens are listed, each with a **Revoke** button.
2. Click the **Generate** button at the bottom of the page.

You can now enter the token in the HTTP client config:
```ballerina
endpoint sonarqube6:Client sonarqubeEP {
    clientConfig:{
        url:url,
        auth:{
            scheme:http:BASIC_AUTH,
            username:token,
            password:""
        }
    }
};
```

The `getProject` function provides the details of a project in SonarQube server for the given project name.

```ballerina
var projectDetails = sonarqubeEP->getProject(“project_name”);
```

The response from `getProject` is either a `Project` (if the request was successful) or an `error`. 
The `match` operation can be used to handle the response if an error occurs. `Project` is a type that holds the information of a project.

```ballerina
match projectDetails {
    sonarqube6:Project project => io:println(project);
    error err => io:println(err)
}
```

The `getLineCoverage` function provides the line coverage of a project in SonarQube server for the given project key. 
You can get the project key using the SonarQube server UI or the `getProject` function.

```ballerina
var value = sonarqubeEP->getLineCoverage(“project_key”);
```
    
The response from `getLineCoverage` is either a `string` (if the request was successful) or an `error`. 
The `match` operation can be used to handle the response if an error occurs.

```ballerina
match value {
        string val => io:println(val);       
        error err => io:println(err);
}
``` 

The `getSecurityRating` function provides the security rating of a project in SonarQube server for the given project key. 
You can get the project key using the SonarQube server UI or the `getProject` function.

```ballerina
var value = sonarqubeEP->getSecurityRating(“project_key”);
```

The response from `getSecurityRating` is either a `string` (if the request was successful) or an `error`. 
The `match` operation can be used to handle the response if an error occurs.

```ballerina
match value {
        string val => io:println(val);       
        error err => io:println(err);
}
```
