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

package src.sonarqube;

@Description {value:"Struct to get the details of a project."}
public struct Project {
    string name;
    string key;
    string id;
    string |version|;
    string description;
}

@Description {value:"Struct to get the details of an issue in a project."}
public struct Issue {
    string key;
    string severity;
    string status;
    string description;
    string author;
    string creationDate;
    string assignee;
    string |type|;
    Position position;
    string[] tags;
    Comment[] comments;
    string[] workflowTransitions;
}

@Description {value:"Struct to get the start line and the end line of an issue."}
struct Position {
    string startLine;
    string endLine;
}

@Description {value:"Struct to get the details of a comment on an issue."}
public struct Comment {
    string text;
    string key;
    string commenter;
    string createdDate;
}