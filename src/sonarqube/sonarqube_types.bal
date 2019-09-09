//
// Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

# Represents a summary of a SonarQube project.
# + name - Project name
# + key - Project key
# + id - Project Id
public type Project record {|
    string name = "";
    string key = "";
    string id = "";
|};

# Represents a summary of a project issue.
# + key - Issue key
# + severity - Severity of the issue
# + status - Status of the issue
# + description - Issue description
# + author - Author of the issue
# + creationDate - Date of creation
# + assignee - Assignee of the issue
# + issueType - Type of the issue
# + position - Position of the issue
# + tags - string array of issue tags
# + comments - Comments in the issue
# + workflowTransitions - Available workflow transitions for the issue
public type Issue record {|
    string key = "";
    string severity = "";
    string status = "";
    string description = "";
    string author = "";
    string creationDate = "";
    string assignee = "";
    string issueType = "";
    Position position = {};
    string[] tags = [];
    Comment[] comments = [];
    string[] workflowTransitions = [];
|};

# Represents a position of a SonarQube Issue.
# + startLine - Start line of poition
# + endLine - End line of position
public type Position record {|
    string startLine = "";
    string endLine = "";
|};

# Represents a comment in SonarQube Issue.
# + text - Comment text
# + key - Key of a comment
# + commenter - Commenter of the comment
# + createdDate - Date of creation
public type Comment record {|
    string text = "";
    string key = "";
    string commenter = "";
    string createdDate = "";
|};

# Represents the SonarQube Client Connector Endpoint configuration.
# + clientConfig - HTTP client endpoint configuration
# + baseUrl - The base url of your SonarQube server.
public type SonarQubeConfiguration record {|
    string baseUrl = "";
    http:ClientConfiguration clientConfig = {};
|};
