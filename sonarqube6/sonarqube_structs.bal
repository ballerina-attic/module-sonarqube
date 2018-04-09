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
    http:ClientEndpointConfiguration clientConfig;
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
type SonarQubeConnector object {
    public {
        string token;
        http:ClientEndpoint clientEndpoint;
    }
    function getProject(string projectName) returns (Project|error);
    function getDuplicatedCodeBlocksCount(string projectKey) returns (int|error);
    function getDuplicatedFilesCount(string projectKey) returns (int|error);
    function getDuplicatedLinesCount (string projectKey) returns (int|error);
    function getBlockerIssuesCount (string projectKey) returns (int|error);
    function getCriticalIssuesCount (string projectKey) returns (int|error);
    function getMajorIssuesCount (string projectKey) returns (int|error);
    function getMinorIssuesCount (string projectKey) returns (int|error);
    function getOpenIssuesCount (string projectKey) returns (int|error);
    function getConfirmedIssuesCount (string projectKey) returns (int|error);
    function getReopenedIssuesCount (string projectKey) returns (int|error);
    function getLinesOfCode (string projectKey) returns (int|error);
    function getLineCoverage (string projectKey) returns (string)|error;
    function getComplexity (string projectKey) returns (int|error);
    function getCoveredLinesCount(string projectKey) returns (int|error);
    function getBranchCoverage (string projectKey) returns (string|error);
    function getCodeSmellsCount (string projectKey) returns (int|error);
    function getSQALERating (string projectKey) returns (string|error);
    function getTechnicalDebt (string projectKey) returns (string|error);
    function getTechnicalDebtRatio (string projectKey) returns (string|error);
    function getVulnerabilitiesCount(string projectKey) returns (int|error);
    function getSecurityRating(string projectKey) returns (string|error);
    function getReliabilityRating(string projectKey) returns (string|error);
    function getBugsCount(string projectKey) returns (int|error);
    function getIssues (string projectKey) returns (Issue[])|error;
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
type Issue {
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
type Position {
    string startLine;
    string endLine;
};

@Description {value:"Struct to get the details of a comment on an issue."}
type Comment {
    string text;
    string key;
    string commenter;
    string createdDate;
};
