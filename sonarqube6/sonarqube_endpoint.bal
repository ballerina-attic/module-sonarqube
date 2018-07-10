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

documentation{ Represents the SonarQube Client Connector Endpoint configuration.
    F{{clientConfig}} Http client endpoint configuration
}
public type SonarQubeConfiguration record {
    http:ClientEndpointConfig clientConfig;
};

documentation{ Represents the SonarQube Client Connector Endpoint object.
    E{{}}
    F{{sonarqubeConfig}} SonarQube client Connector endpoint configuration
    F{{sonarqubeConnector}} SonarQube client connector object
}
public type Client object {
    public SonarQubeConfiguration sonarqubeConfig;
    public SonarQubeConnector sonarqubeConnector = new();

    documentation{ SonarQube connector endpoint initialization function.
        P{{config}} SonarQube connector endpoint configuration
    }
    public function init(SonarQubeConfiguration config) {
        sonarqubeConnector.client.init(config.clientConfig);
    }

    documentation{Returns the SonarQube connector client.
        R{{SonarQubeConnector}} The SonarQube connector client
    }
    public function getCallerActions() returns SonarQubeConnector {
        return sonarqubeConnector;
    }
};
