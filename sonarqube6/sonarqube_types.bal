//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/http;

@Description {value:"Struct to set the SonarQube configuration."}
public type SonarQubeConfiguration {
    string uri;
    string token;
    http:ClientEndpointConfig clientConfig;
};

@Description {value:"Sonarqube client struct."}
public type SonarQubeClient object {
    public {
        SonarQubeConfiguration sonarqubeConfig;
        SonarQubeConnector sonarqubeConnector = new();
    }
    public function init (SonarQubeConfiguration sonarqubeConfig);
    public function register (typedesc serviceType);
    public function start ();
    public function getClient () returns SonarQubeConnector;
    public function stop ();
};

@Description {value:"Struct to initialize the connection with SonarQube."}
public type SonarQubeConnector object {
    public {
        string token;
        http:Client client;
    }
    public function getProject(string projectName) returns (Project|error);
    public function getAllProjects() returns (Project[]|error);
    public function getDuplicatedCodeBlocksCount(string projectKey) returns (int|error);
    public function getDuplicatedFilesCount(string projectKey) returns (int|error);
    public function getDuplicatedLinesCount (string projectKey) returns (int|error);
    public function getBlockerIssuesCount (string projectKey) returns (int|error);
    public function getCriticalIssuesCount (string projectKey) returns (int|error);
    public function getMajorIssuesCount (string projectKey) returns (int|error);
    public function getMinorIssuesCount (string projectKey) returns (int|error);
    public function getOpenIssuesCount (string projectKey) returns (int|error);
    public function getConfirmedIssuesCount (string projectKey) returns (int|error);
    public function getReopenedIssuesCount (string projectKey) returns (int|error);
    public function getLinesOfCode (string projectKey) returns (int|error);
    public function getLineCoverage (string projectKey) returns (string)|error;
    public function getComplexity (string projectKey) returns (int|error);
    public function getCoveredLinesCount(string projectKey) returns (int|error);
    public function getBranchCoverage (string projectKey) returns (string|error);
    public function getCodeSmellsCount (string projectKey) returns (int|error);
    public function getSQALERating (string projectKey) returns (string|error);
    public function getTechnicalDebt (string projectKey) returns (string|error);
    public function getTechnicalDebtRatio (string projectKey) returns (string|error);
    public function getVulnerabilitiesCount(string projectKey) returns (int|error);
    public function getSecurityRating(string projectKey) returns (string|error);
    public function getReliabilityRating(string projectKey) returns (string|error);
    public function getBugsCount(string projectKey) returns (int|error);
    public function getIssues (string projectKey) returns (Issue[])|error;
    public function getMetricValues(string projectKey, string[] metricKeys) returns (map|error);
    function constructAuthenticatedRequest() returns http:Request|error;
    function getMeasure (string projectKey, string metricName) returns string|error;
};

@Description {value:"Struct to get the details of a project."}
public type Project {
    string name;
    string key;
    string id;
};

@Description {value:"Struct to get the details of an issue in a project."}
public type Issue {
    string key;
    string severity;
    string status;
    string description;
    string author;
    string creationDate;
    string assignee;
    string issueType;
    Position position;
    string[] tags = [];
    Comment[] comments = [];
    string[] workflowTransitions = [];
};

@Description {value:"Struct to get the start line and the end line of an issue."}
public type Position {
    string startLine;
    string endLine;
};

@Description {value:"Struct to get the details of a comment on an issue."}
public type Comment {
    string text;
    string key;
    string commenter;
    string createdDate;
};
