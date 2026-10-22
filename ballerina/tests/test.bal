// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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


import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.shipwire.com/api" : "http://localhost:9090";
final string username = isLiveServer ? os:getEnv("SHIPWIRE_USERNAME") : "test_user";
final string password = isLiveServer ? os:getEnv("SHIPWIRE_PASSWORD") : "test_password";
final string receivingId = isLiveServer ? os:getEnv("SHIPWIRE_RECEIVING_ID") : "12345";

final Client shipwire = check new ({
    auth: {username, password},
    httpVersion: http:HTTP_1_1
}, serviceUrl);

// Write operations always run against the mock, so they never modify live data.
final Client mockShipwire = check new ({
    auth: {username: "test_user", password: "test_password"},
    httpVersion: http:HTTP_1_1
}, "http://localhost:9090");

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivings() returns error? {
    ListReceivingsResponse response = check shipwire->listReceivings(status = "processed", expand = ["holds", "items"]);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetReceiving() returns error? {
    ReceivingResponse response = check shipwire->getReceiving(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["mock_tests"]}
function testCreateReceiving() returns error? {
    CreateReceivingRequest payload = {
        arrangement: {'type: "none"},
        shipFrom: {address1: "1 Main St", city: "Austin", state: "TX", postalCode: "78701", country: "US"},
        options: {warehouseId: 4321},
        shipments: {length: 10.5, width: 8.0, weight: 12.0, 'type: "box"},
        items: [{productId: 9876, quantity: 10}]
    };
    CreateReceivingResponse response = check mockShipwire->createReceiving(payload);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["mock_tests"]}
function testUpdateReceiving() returns error? {
    CreateReceivingRequest payload = {
        arrangement: {'type: "none"},
        shipFrom: {address1: "1 Main St", city: "Austin", state: "TX", postalCode: "78701", country: "US"},
        options: {warehouseId: 4321},
        shipments: {length: 10.5, width: 8.0, weight: 12.0, 'type: "box"},
        items: [{productId: 9876, quantity: 12}],
        externalId: "ASN-2026-0001"
    };
    ReceivingResponse response = check mockShipwire->updateReceiving(receivingId, payload);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["mock_tests"]}
function testCancelReceiving() returns error? {
    CancelReceivingResponse response = check mockShipwire->cancelReceiving(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["mock_tests"]}
function testCancelReceivingLabels() returns error? {
    CancelReceivingLabelsResponse response = check mockShipwire->cancelReceivingLabels(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["mock_tests"]}
function testMarkReceivingComplete() returns error? {
    MarkReceivingCompleteResponse response = check mockShipwire->markReceivingComplete(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingHolds() returns error? {
    ReceivingHoldsResponse response = check shipwire->listReceivingHolds(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingInstructionsRecipients() returns error? {
    ReceivingInstructionsRecipientsResponse response = check shipwire->listReceivingInstructionsRecipients(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingExtendedAttributes() returns error? {
    ReceivingExtendedAttributesResponse response = check shipwire->listReceivingExtendedAttributes(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingItems() returns error? {
    ReceivingItemsResponse response = check shipwire->listReceivingItems(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingShipments() returns error? {
    ReceivingShipmentsResponse response = check shipwire->listReceivingShipments(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingTrackings() returns error? {
    ReceivingTrackingsResponse response = check shipwire->listReceivingTrackings(receivingId);
    test:assertEquals(response.status, 200);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListReceivingLabels() returns error? {
    ReceivingLabelsResponse response = check shipwire->listReceivingLabels(receivingId);
    test:assertEquals(response.status, 200);
}
