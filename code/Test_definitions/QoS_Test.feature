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

@qos_profiles
Feature: QoS Profile System Integration Test

  @qos_profiles_01_retrieve_all_profiles_details
  Scenario:  Get all QoS profiles
    Given they use the QOD BaseURL
    When Get All QoS Profiles is triggered
    Then Response code is 200

  @qos_profiles_02_retrieve_valid_profile_details
  Scenario: Get valid QoS profile
    Given they use the QOD BaseURL
    When Get QoS Profile is triggered with valid profile name
    Then Response code is 200
