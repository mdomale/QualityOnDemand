#/*- ---license-start
#* CAMARA Project
#* ---
#* Copyright (C) 2022 - 2023 Contributors | Deutsche Telekom AG to CAMARA a Series of LF Projects, LLC
#* The contributor of this file confirms his sign-off for the
#* Developer Certificate of Origin (http://developercertificate.org).
#* ---
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#* ---license-end
#*/

@quality_on_demand
Feature: QoD System Integration Test

  @quality_on_demand_01_create_session_only_mandatory_parameters
  Scenario: Create QoD session with only mandatory parameters
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions"
    When they Create a new QoD session with mandatory parameters
    Then Response code is 201

  @quality_on_demand_02_create_session_all_parameters
  Scenario: Create QoD session with all parameters
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions"
    When they Create a new QoD session with all parameters
    Then Response code is 201


  @quality_on_demand_03_get_session_with_valid_session_id
  Scenario: Get QoD session with session id
    Given session creation is successful with session-id  
    When get QoD session API with above session-id is triggered
    Then Response code is 200

  @quality_on_demand_04_delete_session_valid_session_id
  Scenario: Delete QoD session with session id
    Given session creation is successful with session-id
    When they delete existing QoD session with above session-id
    Then Response code is 204

  @quality_on_demand_05_delete_invalid_expired_session
  Scenario : Delete a Invalid QoD session for session id
    Given there is invalid session-id "b23aadad-4c51-4703-94f5-0fd746464389"
    When they delete Invalid QoD session
    Then Response code is 404


  @quality_on_demand_06_get_invalid_expired_session
  Scenario: Get a Invalid QoD session for session id
    Given there is invalid session-id "b23aadad-4c51-4703-94f5-0fd746464389"
    When get QoD session API is triggered
    Then Response code is 404

  @quality_on_demand_07_session_creation_with_server_error
  Scenario: QoD session with 5XX response
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions" returns server error
    When they create a new QoD session along with all parameters
    Then Response code is 500


  @quality_on_demand_08_session_creation_with_invalid_parameter
  Scenario: QoD session with invalid payload 4XX
    # Test with invalid Payload
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions" 
    When they create a new QoD session with invalid parameters 
    Then Response code is 400
	
  @quality_on_demand_09_session_creation_with_notification
  Scenario: QoD notification test
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions"
    When they create a new QoD session with a valid callback application URL
    Then Response code is 201
    And the callback application receives "NETWORK_TERMINATED" event
	
	
  @quality_on_demand_10_session_duration_extension
  Scenario: Extend QoD active session for the total session duration of less than 24 hours
    Given there is 3gpp MOCK URL as "/3gpp-as-session-with-qos/v1/scs/subscriptions"
    When Create a new QoD session with valid parameters and session duration of "30" seconds
    Then Response code is 201
    When Extend session for 25 seconds
    Then Response code is 200