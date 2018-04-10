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

//SonarQube API
@final string API_RESOURCES = "/api/components/search?qualifiers=TRK&ps=";
@final string API_MEASURES = "/api/measures/component?componentKey=";
@final string API_ISSUES_SEARCH = "/api/issues/search";

//SonarQube metric keys
@final public string CODE_SMELLS = "code_smells";
@final public string COMPLEXITY = "complexity";
@final public string SEVERITY = "severity";
@final public string LINES_TO_COVER = "lines_to_cover";
@final public string UNCOVERED_LINES_COUNT = "uncovered_lines";
@final public string LINE_COVERAGE = "line_coverage";
@final public string BRANCH_COVERAGE = "branch_coverage";
@final public string SQALE_RATING = "sqale_rating";
@final public string TECHNICAL_DEBT = "sqale_index";
@final public string TECHNICAL_DEBT_RATIO = "sqale_debt_ratio";
@final public string DUPLICATED_BLOCKS_COUNT = "duplicated_blocks";
@final public string DUPLICATED_FILES_COUNT = "duplicated_files";
@final public string DUPLICATED_LINES_COUNT = "duplicated_lines";
@final public string SECURITY_RATING = "security_rating";
@final public string RELIABILITY_RATING = "reliability_rating";
@final public string UNCOVERED_LINES = "uncovered_lines";
@final public string BLOCKER_ISSUES_COUNT = "blocker_violations";
@final public string CRITICAL_ISSUES_COUNT = "critical_violations";
@final public string MAJOR_ISSUES_COUNT = "major_violations";
@final public string MINOR_ISSUES_COUNT = "minor_violations";
@final public string OPEN_ISSUES_COUNT = "open_issues";
@final public string CONFIRMED_ISSUES_COUNT = "confirmed_issues";
@final public string REOPENED_ISSUES_COUNT = "reopened_issues";
@final public string VULNERABILITIES = "vulnerabilities";
@final public string BUGS_COUNT = "bugs";
@final public string LINES_OF_CODE = "ncloc";

//string constants
@final string COMPONENT = "component";
@final string COMPONENTS = "components";
@final string NAME = "name";
@final string PAGE_NUMBER = "p";
@final string KEY = "key";
@final string ID = "id";
@final string AUTH_TYPE = "Auth_Type";
@final string USER = "user";
@final string TOKEN = "token";
@final string VALID = "valid";
@final string ASSIGNEE = "assignee";
@final string COMPONENT_KEY = "componentKey";
@final string PROJECT_KEYS = "projectKeys";
@final string DESCRIPTION = "description";
@final string MESSAGE = "msg";
@final string VERSION = "version";
@final string STATUS = "status";
@final string ERRORS = "errors";
@final string AUTHOR = "author";
@final string COMMENTS = "comments";
@final string COMMENT = "comment";
@final string ISSUE_RANGE = "textRange";
@final string TYPE = "type";
@final string UUID = "uuid";
@final string MEASURES = "measures";
@final string VALUE = "value";
@final string CREATION_DATE = "creationDate";
@final string CREATED_DATE = "createdAt";
@final string METRIC_KEYS = "metricKeys";
@final string ISSUES = "issues";
@final string METRIC = "metric";
@final string ISSUE = "issue";
@final string TOTAL = "total";
@final string PAGING = "paging";
@final string START_LINE = "startLine";
@final string END_LINE = "endLine";
@final string SUCCESSFUL = "successful";
@final string UNSUCCESSFUL = "unsuccessful";
@final string NO_VULNERABILITY = "1.0";
@final string MINOR_VULNERABILITY = "2.0";
@final string MAJOR_VULNERABILITY = "3.0";
@final string CRITICAL_VULNERABILITY = "4.0";
@final string BLOCKER_VULNERABILITY = "5.0";
@final string NO_BUGS = "1.0";
@final string MINOR_BUGS = "2.0";
@final string MAJOR_BUGS = "3.0";
@final string CRITICAL_BUGS = "4.0";
@final string BLOCKER_BUGS = "5.0";
@final string CONTENT_TYPE = "Content-Type";
@final string EXTRA_CONTENT = "additionalFields=comments";
@final string TAGS = "tags";
@final string HTML_TEXT = "htmlText";
@final string TRANSITIONS = "transitions";
@final string LOGIN = "login";
@final int PROJECTS_PER_PAGE = 100;
