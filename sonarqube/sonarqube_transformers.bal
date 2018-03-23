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

package sonarqube;

transformer <json projectDetails, Project project> getProjectDetails() {
    project.name = !isAnEmptyJson(projectDetails[NAME]) ? projectDetails[NAME].toString() : "";
    project.key = !isAnEmptyJson(projectDetails[KEY]) ? projectDetails[KEY].toString() : "";
    project.id = !isAnEmptyJson(projectDetails[ID]) ? projectDetails[ID].toString() : "";
}

transformer <json commentDetails, Comment comment> getComment() {
    comment.text = !isAnEmptyJson(commentDetails[HTML_TEXT]) ? commentDetails[HTML_TEXT].toString() : "";
    comment.key = !isAnEmptyJson(commentDetails[KEY]) ? commentDetails[KEY].toString() : "";
    comment.commenter = !isAnEmptyJson(commentDetails[LOGIN]) ? commentDetails[LOGIN].toString() : "";
    comment.createdDate = !isAnEmptyJson(commentDetails[CREATED_DATE]) ? commentDetails[CREATED_DATE].toString() : "";
}

transformer <json issueDetails, Issue issue> getIssue() {
    issue.key = !isAnEmptyJson(issueDetails[KEY]) ? issueDetails[KEY].toString() : "";
    issue.severity = !isAnEmptyJson(issueDetails[SEVERITY]) ? issueDetails[SEVERITY].toString() : "";
    issue.status = !isAnEmptyJson(issueDetails[STATUS]) ? issueDetails[STATUS].toString() : "";
    issue.issueType = !isAnEmptyJson(issueDetails[TYPE]) ? issueDetails[TYPE].toString() : "";
    issue.description = !isAnEmptyJson(issueDetails[MESSAGE]) ? issueDetails[MESSAGE].toString() : "";
    issue.author = !isAnEmptyJson(issueDetails[AUTHOR]) ? issueDetails[AUTHOR].toString() : "";
    issue.creationDate = !isAnEmptyJson(issueDetails[CREATION_DATE]) ? issueDetails[CREATION_DATE].toString() : "";
    issue.assignee = !isAnEmptyJson(issueDetails[ASSIGNEE]) ? issueDetails[ASSIGNEE].toString() : "";
    json positionInfo = issueDetails[ISSUE_RANGE];
    issue.position = {};
    issue.position.startLine = (!isAnEmptyJson(positionInfo)) ? (!isAnEmptyJson(positionInfo[START_LINE]) ?
                                                                  positionInfo[START_LINE].toString() : "") : "";
    issue.position.endLine = (!isAnEmptyJson(positionInfo)) ? (!isAnEmptyJson(positionInfo[END_LINE]) ? positionInfo[END_LINE]
                                                                                                        .toString() : "") : "";
    json tags = issueDetails[TAGS];
    issue.tags = !isAnEmptyJson(tags) ? tags.map(function (json tag) returns (string) {
                                                     return tag.toString();
                                                 }) : [];
    json transitions = issueDetails[TRANSITIONS];
    issue.workflowTransitions = !isAnEmptyJson(transitions) ? transitions.map(function (json transition) returns (string) {
                                                                                  return transition.toString();
                                                                              }) : [];
    json comments = issueDetails[COMMENTS];
    issue.comments = !isAnEmptyJson(comments) ? comments.map(function (json comment) returns (Comment) {
                                                                 Comment commentStruct = <Comment, getComment()>comment;
                                                                 return commentStruct;
                                                             }) : [];
}


