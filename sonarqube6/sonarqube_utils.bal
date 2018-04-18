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
            error err = {message:"Error occured while extracting the payload from response." + payloadError.message};
            return err;
        }
    }
}

function checkResponse(http:Response response) returns error {
    json[] responseJson = check getJsonArrayByKey(response, ERRORS);
    error err = {message:""};
    if (responseJson != ()) {
        foreach item in responseJson {
            string errorMessage = item.msg.toString();
            err.message = err.message + errorMessage;
        }
        return err;
    }
    return err;
}

function SonarQubeConnector::getMeasure(string projectKey, string metricName) returns string|error {
    endpoint http:Client httpEndpoint = self.client;
    string value = "";
    http:Request request = new;
    string requestPath = API_MEASURES + projectKey + "&" + METRIC_KEYS + "=" + metricName;
    var endpointResponse = httpEndpoint -> get(requestPath, request);

    // match endpointResponse
    match endpointResponse{
        http:Response response => {
            error endpointErrors = checkResponse(response);
            if (endpointErrors.message == ""){
                json component = check getJsonValueByKey(response, COMPONENT);
                match < json[]>component[MEASURES]{
                    json[] metricArray => {
                        if (lengthof metricArray == 0) {
                            error connectionError = {message:"Metric array is empty"};
                            return connectionError;
                        }
                        json metricValue = metricArray[0][VALUE];
                        return metricValue.toString();
                    }
                    error err => {
                        string errorMessage = err.message;
                        err = {message:"Cannot find the " + metricName.replace("_", " ") + " for " + projectKey + "."
                            + errorMessage};
                        return err;
                    }
                }
            }
            return endpointErrors;
        }
        http:HttpConnectorError err => {
            error connectionError = {message:err.message};
            return connectionError;
        }
    }
}

function convertJsonToComment(json commentDetails) returns Comment {
    Comment comment = {};
    comment.text = commentDetails[HTML_TEXT].toString();
    comment.key = commentDetails[KEY].toString();
    comment.commenter = commentDetails[LOGIN].toString();
    comment.createdDate = commentDetails[CREATED_DATE].toString();
    return comment;
}

function convertJsonToProject(json projectDetails) returns Project {
    Project project = {};
    project.name = projectDetails[NAME].toString();
    project.key = projectDetails[KEY].toString();
    project.id = projectDetails[ID].toString();
    return project;
}

function convertJsonToIssue(json issueDetails) returns Issue {
    Issue issue = {};
    issue.key = issueDetails[KEY].toString();
    issue.severity = issueDetails[SEVERITY].toString();
    issue.status = issueDetails[STATUS].toString();
    issue.issueType = issueDetails[TYPE].toString();
    issue.description = issueDetails[MESSAGE].toString();
    issue.author = issueDetails[AUTHOR].toString();
    issue.creationDate = issueDetails[CREATION_DATE].toString();
    issue.assignee = issueDetails[ASSIGNEE].toString();
    issue.position = {};
    issue.position.startLine = issueDetails[ISSUE_RANGE][START_LINE].toString();
    issue.position.endLine = issueDetails[ISSUE_RANGE][END_LINE].toString();
    json tags = issueDetails[TAGS];
    int count = 0;
    if (tags != ()) {
        string[] tagList = [];
        foreach tag in tags {
            tagList[count] = tag.toString();
            count += 1;
        }
        issue.tags = tagList;
        count = 0;
    }
    json transitions = issueDetails[TRANSITIONS];
    if (transitions != ()) {
        string[] workflowTransitions = [];
        foreach transition in transitions {
            workflowTransitions[count] = transition.toString();
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
