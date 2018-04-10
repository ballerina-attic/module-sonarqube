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
import ballerina/util;

@Description {value:"Add authentication headers to the HTTP request."}
@Param {value:"request: http OutRequest."}
public function SonarQubeConnector::constructAuthenticatedRequest() returns (http:Request|error) {
    http:Request request;
    var encodingData = util:base64EncodeString(token + ":");
    match encodingData{
        string encodedString => {
            request.addHeader("Authorization", "Basic " + encodedString);
            return request;
        }
        util:Base64EncodeError => {
            error err = {message:"Encode error."};
            return err;
        }
    }
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http Response."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content (of type json) specified by the key."}
function getJsonValueByKey(http:Response response, string key) returns (json|error) {
    match response.getJsonPayload() {
        json jsonPayload => {
            return jsonPayload[key];
        }
        http:PayloadError payloadError => {
            error err = {message:"Error occured when extracting payload from response"};
            return err;
        }
    }
}

@Description {value:"Get content from a json specified by key."}
@Param {value:"response: http Response."}
@Param {value:"key: String key."}
@Return {value:"jsonPayload: Content (of type json) specified by the key."}
function getJsonArrayByKey(http:Response response, string key) returns (json[]|error) {
    match response.getJsonPayload() {
        json jsonPayload => {
            if (jsonPayload[key] != ()){
                json[] array = check < json[]>jsonPayload[key];
                return array;
            } else {
                return {};
            }
        }
        http:PayloadError payloadError => {
            error err = {message:"Error occured when extracting payload from response"};
            return err;
        }
    }
}

@Description {value:"Check whether the response from sonarqube server has an error field."}
@Param {value:"response: http Response."}
@Return {value:"Error details."}
function checkResponse(http:Response response) returns error {
    json[] responseJson = check getJsonArrayByKey(response, ERRORS);
    error err = {message:""};
    if (responseJson != ()) {
        foreach item in responseJson {
            string errorMessage = item.msg.toString() but { () => "" };
            err.message = err.message + errorMessage;
        }
        return err;
    }
    return err;
}

@Description {value:"Returns value of the metric in measures field of a json."}
@Param {value:"response: http Response."}
@Return {value:"Value of the metric field in json."}
function SonarQubeConnector::getMeasure(string projectKey, string metricName) returns string|error {
    endpoint http:Client httpEndpoint = client;
    string value = "";
    http:Request request = check constructAuthenticatedRequest();
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + metricName;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                json component = check getJsonValueByKey(response, COMPONENT);
                json[] metricArray = check < json[]>component[MEASURES];
                json metricValue = metricArray[0][VALUE];
                return metricValue.toString() but { () => "" };
            }
            return endpointErrors;
        }
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}

@Description {value:"Convert a given json to Comment."}
@Param {value:"projectDetails:JSON containing comment details."}
@Return {value:"project:Comment struct."}
function convertJsonToComment(json commentDetails) returns Comment {
    Comment comment = {};
    comment.text = commentDetails[HTML_TEXT].toString() but { () => "" };
    comment.key = commentDetails[KEY].toString() but { () => "" };
    comment.commenter = commentDetails[LOGIN].toString() but { () => "" };
    comment.createdDate = commentDetails[CREATED_DATE].toString() but { () => "" };
    return comment;
}

@Description {value:"Convert a given json to Project."}
@Param {value:"projectDetails:JSON containing project details."}
@Return {value:"project:Project struct.."}
function convertJsonToProject(json projectDetails) returns Project {
    Project project = {};
    project.name = projectDetails[NAME].toString() but { () => "" };
    project.key = projectDetails[KEY] but { () => "" };
    project.id = projectDetails[ID] but { () => "" };
    return project;
}

@Description {value:"Convert a given json to Issue."}
@Param {value:"issueDetails:Json containing issue details."}
@Return {value:"issue:Issue struct."}
function convertJsonToIssue(json issueDetails) returns Issue {
    Issue issue = {};
    issue.key = issueDetails[KEY].toString() but { () => "" };
    issue.severity = issueDetails[SEVERITY].toString() but { () => "" };
    issue.status = issueDetails[STATUS].toString() but { () => "" };
    issue.issueType = issueDetails[TYPE].toString() but { () => "" };
    issue.description = issueDetails[MESSAGE].toString() but { () => "" };
    issue.author = issueDetails[AUTHOR].toString() but { () => "" };
    issue.creationDate = issueDetails[CREATION_DATE].toString() but { () => "" };
    issue.assignee = issueDetails[ASSIGNEE].toString() but { () => "" };
    issue.position = {};
    issue.position.startLine = issueDetails[ISSUE_RANGE][START_LINE].toString() but { () => "" };
    issue.position.endLine = issueDetails[ISSUE_RANGE][END_LINE].toString() but { () => "" };
    json tags = issueDetails[TAGS];
    int count = 0;
    if (tags != ()) {
        string[] tagList = [];
        foreach tag in tags {
            tagList[count] = tag.toString() but { () => "" };
            count += 1;
        }
        issue.tags = tagList;
        count = 0;
    }
    json transitions = issueDetails[TRANSITIONS];
    if (transitions != ()) {
        string[] workflowTransitions = [];
        foreach transition in transitions {
            workflowTransitions[count] = transition.toString() but { () => "" };
            count += 1;
        }
        issue.workflowTransitions = workflowTransitions;
        count = 0;
    }
    json comments = issueDetails[COMMENTS];
    if (comments != ()) {
        Comment[] commentList = [];
        foreach comment in comments {
            commentList[count] = convertJsonToComment(comment);
            count += 1;
        }
        issue.comments = commentList;
    }
    return issue;
}
