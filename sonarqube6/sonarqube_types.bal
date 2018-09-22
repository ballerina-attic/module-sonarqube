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

# Represents a summary of a SonarQube project.
# + name - project name
# + key - project key
# + id - project Id
public type Project record {
    string name;
    string key;
    string id;
};

# Represents a summary of a project issue.
# + key - issue key
# + severity - severity of the issue
# + status - status of the issue
# + description - issue description
# + author - author of the issue
# + creationDate - date of creation
# + assignee - assignee of the issue
# + issueType - type of the issue
# + position - position of the issue
# + tags - string array of issue tags
# + comments - comments in the issue
# + workflowTransitions - available workflow transitions for the issue
public type Issue record {
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

# Represents a position of a SonarQube Issue.
# + startLine - start line of poition
# + endLine - end line of position
public type Position record {
    string startLine;
    string endLine;
};

# Represents a comment in SonarQube Issue.
# + text - comment text
# + key - key of a comment
# + commenter - commenter of the comment
# + createdDate - date of creation
public type Comment record {
    string text;
    string key;
    string commenter;
    string createdDate;
};
