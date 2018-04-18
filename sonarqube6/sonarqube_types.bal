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

documentation{Represents a summary of a SonarQube project.
    F{{name}} project name
    F{{key}} project key
    F{{id}} project Id
}
public type Project {
    string name;
    string key;
    string id;
};

documentation{Represents a summary of a project issue.
    F{{key}} issue key
    F{{severity}} severity of the issue
    F{{status}} status of the issue
    F{{description}} issue description
    F{{author}} author of the issue
    F{{creationDate}} date of creation
    F{{assignee}} assignee of the issue
    F{{issueType}} type of the issue
    F{{position}} position of the issue
    F{{tags}} string array of issue tags
    F{{comments}} comments in the issue
    F{{workflowTransitions}} available workflow transitions for the issue
}
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

documentation{Represents a position of a SonarQube Issue.
    F{{startLine}} start line of poition
    F{{endLine}} end line of position
}
public type Position {
    string startLine;
    string endLine;
};

documentation{Represents a comment in SonarQube Issue.
    F{{text}} comment text
    F{{key}} key of a comment
    F{{commenter}} commenter of the comment
    F{{createdDate}} date of creation
}
public type Comment {
    string text;
    string key;
    string commenter;
    string createdDate;
};

