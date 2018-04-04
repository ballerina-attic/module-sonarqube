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

package sonarqube67;

import ballerina/http;
import ballerina/util;

@Description {value:"Add authentication headers to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function <SonarQubeConnector sonarqubeConnector> constructAuthenticationHeaders (http:Request request) {
    request.addHeader("Authorization", "Basic " + util:base64Encode(sonarqubeConnector.token + ":"));
}

@Description {value:"Check whether the response from sonarqube server has an error field."}
@Param {value:"response: http Response."}
function checkResponse (http:Response response) {
    json responseJson = getContentByKey(response, ERRORS);
    if (!isAnEmptyJson(responseJson)) {
        error err = {message:""};
        foreach item in responseJson {
            err.message = err.message + ((item.msg != null) ? item.msg.toString() : "") + ".";
        }
        throw err;
    }
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http Response."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content (of type json) specified by the key."}
function getContentByKey (http:Response response, string key) returns (json) {
    json jsonPayload = {};
    match response.getJsonPayload() {
        json content => jsonPayload = content;
        error err => throw err;
    }
    if (isAnEmptyJson(jsonPayload)) {
        error err = {};
        if (response.reasonPhrase != "") {
            err = {message:response.reasonPhrase};
            throw err;
        }
        err = {message:"Server response payload is null."};
        throw err;
    }
    return jsonPayload[key];
}

@Description {value:"Check whether a json is empty."}
@Return {value:"True if json is empty false otherwise."}
function isAnEmptyJson (json jsonValue) returns (boolean) {
    try {
        string stringVal = jsonValue.toString();
        if (stringVal == "{}") {
            return true;
        }
        return false;
    } catch (error e) {
        return true;
    }
    return false;
}

@Description {value:"Return the project from a json array of projects."}
@Param {value:"projectName:Name of the project."}
@Param {value:"projectList:Project List."}
@Return {value:"project:Details of the project specified by name."}
function getProjectFromList (string projectName, json projectList) returns (Project) {
    foreach projectData in projectList {
        Project project = convertJsonToProject(projectData);
        if (projectName == project.name) {
            return project;
        }
    }
    return {};
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http Response."}
@Return {value:"Value of the metric field in json."}
function getMetricValue (string projectKey, SonarQubeConnector sonarqubeConnector, string metricName) returns string {
    endpoint http:ClientEndpoint clientEndpoint = sonarqubeConnector.clientEndpoint;
    string value = "";
    http:Request request = {};
    sonarqubeConnector.constructAuthenticationHeaders(request);
    string requestPath = API_MEASURES + "?" + COMPONENT_KEY + "=" + projectKey + "&" + METRIC_KEY + "=" + metricName;
    var response =? clientEndpoint -> get(requestPath, request);
    checkResponse(response);
    json component = getContentByKey(response, COMPONENT);
    json metricValue = component[MEASURES][0][VALUE];
    return metricValue.toString();
}

@Description {value:"Convert a given json to Comment."}
@Param {value:"projectDetails:JSON containing comment details."}
@Return {value:"project:Comment struct."}
function convertJsonToComment (json commentDetails) returns Comment {
    Comment comment = {};
    comment.text = !isAnEmptyJson(commentDetails[HTML_TEXT]) ? commentDetails[HTML_TEXT].toString() : "";
    comment.key = !isAnEmptyJson(commentDetails[KEY]) ? commentDetails[KEY].toString() : "";
    comment.commenter = !isAnEmptyJson(commentDetails[LOGIN]) ? commentDetails[LOGIN].toString() : "";
    comment.createdDate = !isAnEmptyJson(commentDetails[CREATED_DATE]) ? commentDetails[CREATED_DATE].toString() : "";
    return comment;
}

@Description {value:"Convert a given json to Project."}
@Param {value:"projectDetails:JSON containing project details."}
@Return {value:"project:Project struct.."}
function convertJsonToProject (json projectDetails) returns Project {
    Project project = {};
    project.name = !isAnEmptyJson(projectDetails[NAME]) ? projectDetails[NAME].toString() : "";
    project.key = !isAnEmptyJson(projectDetails[KEY]) ? projectDetails[KEY].toString() : "";
    project.id = !isAnEmptyJson(projectDetails[ID]) ? projectDetails[ID].toString() : "";
    return project;
}

@Description {value:"Convert a given json to Issue."}
@Param {value:"issueDetails:Json containing issue details."}
@Return {value:"issue:Issue struct."}
function convertJsonToIssue (json issueDetails) returns Issue {
    Issue issue = {};
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
    int count = 0;
    if (!isAnEmptyJson(tags)) {
        string[] tagList = [];
        foreach tag in tags {
            tagList[count] = tag.toString();
            count = count + 1;
        }
        issue.tags = tagList;
        count = 0;
    }
    json transitions = issueDetails[TRANSITIONS];
    if (!isAnEmptyJson(transitions)) {
        string[] workflowTransitions = [];
        foreach transition in transitions {
            workflowTransitions[count] = transition.toString();
            count = count + 1;
        }
        issue.workflowTransitions = workflowTransitions;
        count = 0;
    }
    json comments = issueDetails[COMMENTS];
    if (!isAnEmptyJson(comments)) {
        Comment[] commentList = [];
        foreach comment in comments {
            commentList[count] = convertJsonToComment(comment);
            count = count + 1;
        }
        issue.comments = commentList;
    }
    return issue;
}
