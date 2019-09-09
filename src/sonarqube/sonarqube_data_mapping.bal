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

# Transforms JSON comment object into Comment.
# + commentDetails - `json` comment object
# + return - Comment type object.
function convertJsonToComment(json commentDetails) returns Comment {
    Comment comment = {};
    comment.text = commentDetails.HTML_TEXT.toString();
    comment.key = commentDetails.KEY.toString();
    comment.commenter = commentDetails.LOGIN.toString();
    comment.createdDate = commentDetails.CREATED_DATE.toString();
    return comment;
}

# Transforms JSON project object into Project.
# + projectDetails - `json` project object
# + return - Project type object.
function convertJsonToProject(map<json> projectDetails) returns Project {
    Project project = {};
    project.name = projectDetails[NAME].toString();
    project.key = projectDetails[KEY].toString();
    project.id = projectDetails[ID].toString();
    return project;
}

# Transforms JSON issue object into Issue.
# + issueDetails - `json` issue object
# + return - Issue type object.
function convertJsonToIssue(json issueDetails) returns Issue {
    Issue issue = {};
    issue.key = issueDetails.KEY.toString();
    issue.severity = issueDetails.SEVERITY.toString();
    issue.status = issueDetails.STATUS.toString();
    issue.issueType = issueDetails.TYPE.toString();
    issue.description = issueDetails.MESSAGE.toString();
    issue.author = issueDetails.AUTHOR.toString();
    issue.creationDate = issueDetails.CREATION_DATE.toString();
    issue.assignee = issueDetails.ASSIGNEE.toString();
    issue.position = {};
    issue.position.startLine = issueDetails.ISSUE_RANGE.START_LINE.toString();
    issue.position.endLine = issueDetails.ISSUE_RANGE.END_LINE.toString();
    json[] tags = <json[]>issueDetails.TAGS;
    int count = 0;
    if (tags.length() > 0) {
        string[] tagList = [];
        foreach json tag in tags {
            tagList[count] = tag.toString();
            count += 1;
        }
        issue.tags = tagList;
        count = 0;
    }
    json[] transitions = <json[]>issueDetails.TRANSITIONS;
    if (transitions.length() > 0) {
        string[] workflowTransitions = [];
        foreach json transition in transitions {
            workflowTransitions[count] = transition.toString();
            count += 1;
        }
        issue.workflowTransitions = workflowTransitions;
        count = 0;
    }
    json[] comments = <json[]>issueDetails.COMMENTS;
    if (comments.length() > 0) {
        Comment[] commentList = [];
        foreach json comment in comments {
            commentList[count] = convertJsonToComment(comment);
            count += 1;
        }
        issue.comments = commentList;
    }
    return issue;
}
