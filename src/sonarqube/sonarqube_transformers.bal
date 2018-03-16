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

transformer <json projectDetails, Project project> getProjectDetails() {
    project.name = (projectDetails[NAME] != null) ? projectDetails[NAME].toString() : null;
    project.key = (projectDetails[KEY] != null) ? projectDetails[KEY].toString() : null;
    project.id = (projectDetails[ID] != null) ? projectDetails[ID].toString() : null;
    project.uuid = (projectDetails[UUID] != null) ? projectDetails[UUID].toString() : null;
    project.|version| = (projectDetails[VERSION] != null) ? projectDetails[VERSION].toString() : null;
    project.description = (projectDetails[DESCRIPTION] != null) ? projectDetails[DESCRIPTION].toString() : null;
    project.creationDate = (projectDetails[CREATION_DATE] != null) ? projectDetails[CREATION_DATE].toString() : null;
}

transformer <json commentDetails, Comment comment> getComment() {
    comment.text = (commentDetails[HTML_TEXT] != null) ? commentDetails[HTML_TEXT].toString() : null;
    comment.key = (commentDetails[KEY] != null) ? commentDetails[KEY].toString() : null;
    comment.commenter = (commentDetails[LOGIN] != null) ? commentDetails[LOGIN].toString() : null;
    comment.createdDate = (commentDetails[CREATED_DATE] != null) ? commentDetails[CREATED_DATE].toString() : null;
}

transformer <json issueDetails, Issue issue> getIssue() {
    issue.key = (issueDetails[KEY] != null) ? issueDetails[KEY].toString() : null;
    issue.severity = (issueDetails[SEVERITY] != null) ? issueDetails[SEVERITY].toString() : null;
    issue.status = (issueDetails[STATUS] != null) ? issueDetails[STATUS].toString() : null;
    issue.|type| = (issueDetails[TYPE] != null) ? issueDetails[TYPE].toString() : null;
    issue.description = (issueDetails[MESSAGE] != null) ? issueDetails[MESSAGE].toString() : null;
    issue.author = (issueDetails[AUTHOR] != null) ? issueDetails[AUTHOR].toString() : null;
    issue.creationDate = (issueDetails[CREATION_DATE] != null) ? issueDetails[CREATION_DATE].toString() : null;
    issue.assignee = (issueDetails[ASSIGNEE] != null) ? issueDetails[ASSIGNEE].toString() : null;
    json positionInfo = issueDetails[ISSUE_RANGE];
    issue.position = {};
    issue.position.startLine = (positionInfo != null) ? ((positionInfo[START_LINE] != null) ?
                                                         positionInfo[START_LINE].toString() : null) : null;
    issue.position.endLine = (positionInfo != null) ? ((positionInfo[END_LINE] != null) ? positionInfo[END_LINE]
                                                                                          .toString() : null) : null;
    json tags = issueDetails[TAGS];
    issue.tags = (tags != null) ? tags.map(function (json tag) (string) {
                                               return tag.toString();
                                           }) : [];
    json transitions = issueDetails[TRANSITIONS];
    issue.workflowTransitions = (transitions != null) ? transitions.map(function (json transition) (string) {
                                                                            return transition.toString();
                                                                        }) : [];
    json comments = issueDetails[COMMENTS];
    issue.comments = (comments != null) ? comments.map(function (json comment) (Comment) {
                                                           Comment commentStruct = <Comment, getComment()>comment;
                                                           return commentStruct;
                                                       }) : [];
}
