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

listener http:Listener ep0 = new (9090);

@http:ServiceConfig {treatNilableAsOptional: true}
service / on ep0 {
    # Get list of advance ship notices
    #
    # + request - The incoming request; the `status` filter and both `expand` values `holds` and `items` are required
    # + return - OK, or Bad Request when the expected filter and expand values are missing
    resource function get v3/receivings(http:Request request) returns ListReceivingsResponse|http:BadRequest {
        string? status = request.getQueryParamValue("status");
        string[] expand = [];
        foreach string value in request.getQueryParamValues("expand") ?: [] {
            foreach string part in re `,`.split(value) {
                expand.push(part.trim());
            }
        }
        if status != "processed" || expand.indexOf("holds") is () || expand.indexOf("items") is () {
            return <http:BadRequest>{body: "Expected status=processed and expand=holds,items"};
        }
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings?offset=0&limit=20",
            'resource: {
                "offset": 0,
                "total": 1,
                "items": [
                    {
                        "resourceLocation": "https://api.shipwire.com/api/v3/receivings/12345",
                        "resource": {"id": 12345, "externalId": "ASN-2026-0001", "orderNo": "PO-1001", "status": "processed", "warehouseId": 4321}
                    }
                ]
            }
        };
    }

    # Get advance ship notice
    #
    # + id - The advance ship notice's ID
    # + expand - Expand receivings data in the response
    # + return - OK
    resource function get v3/receivings/[string id](("holds"|"instructionsRecipients"|"items"|"shipments"|"labels"|"trackings"|"all")[]? expand) returns ReceivingResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id,
            'resource: {"id": 12345, "externalId": "ASN-2026-0001", "orderNo": "PO-1001", "status": "processed", "warehouseId": 4321}
        };
    }

    # Get receiving extended attributes
    #
    # + id - The receiving's ID
    # + return - OK
    resource function get v3/receivings/[string id]/extendedAttributes() returns ReceivingExtendedAttributesResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/extendedAttributes"
        };
    }

    # Get holds detail
    #
    # + id - The advance ship notice's ID
    # + includeCleared - Include cleared holds
    # + return - OK
    resource function get v3/receivings/[string id]/holds(0|1? includeCleared) returns ReceivingHoldsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/holds"
        };
    }

    # Get instructions and the recipients contact details
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function get v3/receivings/[string id]/instructionsRecipients() returns ReceivingInstructionsRecipientsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/instructionsRecipients"
        };
    }

    # Get items detail
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function get v3/receivings/[string id]/items() returns ReceivingItemsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/items"
        };
    }

    # Get labels detail
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function get v3/receivings/[string id]/labels() returns ReceivingLabelsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/labels"
        };
    }

    # Get shipment details
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function get v3/receivings/[string id]/shipments() returns ReceivingShipmentsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/shipments"
        };
    }

    # Get trackings detail
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function get v3/receivings/[string id]/trackings() returns ReceivingTrackingsResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/trackings"
        };
    }

    # Create an advance ship notice
    #
    # + expand - Expand receivings data in the response
    # + payload - Receiving order details to create
    # + return - OK
    resource function post v3/receivings(("holds"|"instructionsRecipients"|"items"|"shipments"|"labels"|"trackings"|"all")[]? expand, @http:Payload CreateReceivingRequest payload) returns CreateReceivingResponseOk {
        return {
            body: {
                status: 200,
                message: "Success",
                resourceLocation: "https://api.shipwire.com/api/v3/receivings/12345"
            }
        };
    }

    # Cancel a receiving order
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function post v3/receivings/[string id]/cancel() returns CancelReceivingResponseOk {
        return {
            body: {
                status: 200,
                message: "Receiving cancelled",
                resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id
            }
        };
    }

    # Cancel a receiving label
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function post v3/receivings/[string id]/labels/cancel() returns CancelReceivingLabelsResponseOk {
        return {
            body: {
                status: 200,
                message: "Labels cancelled",
                resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id + "/labels"
            }
        };
    }

    # Mark the receiving completed
    #
    # + id - The advance ship notice's ID
    # + return - OK
    resource function post v3\.1/receivings/[string id]/markComplete() returns MarkReceivingCompleteResponseOk {
        return {
            body: {
                status: 200,
                message: "Receiving completed",
                resourceLocation: "https://api.shipwire.com/api/v3.1/receivings/" + id
            }
        };
    }

    # Update an advance ship notice
    #
    # + id - The advance ship notice's ID
    # + expand - Expand receivings data in the response
    # + payload - Receiving order fields to update
    # + return - OK
    resource function put v3/receivings/[string id](("holds"|"instructionsRecipients"|"items"|"shipments"|"labels"|"trackings"|"all")[]? expand, @http:Payload CreateReceivingRequest payload) returns ReceivingResponse {
        return {
            status: 200,
            message: "Success",
            resourceLocation: "https://api.shipwire.com/api/v3/receivings/" + id,
            'resource: {"id": 12345, "externalId": payload.externalId, "orderNo": payload.orderNo, "status": "processed"}
        };
    }
}

// Status wrappers used by the mock only; the client maps the 200 response to the body type.
public type CancelReceivingLabelsResponseOk record {|
    *http:Ok;
    CancelReceivingLabelsResponse body;
|};

public type CancelReceivingResponseOk record {|
    *http:Ok;
    CancelReceivingResponse body;
|};

public type CreateReceivingResponseOk record {|
    *http:Ok;
    CreateReceivingResponse body;
|};

public type MarkReceivingCompleteResponseOk record {|
    *http:Ok;
    MarkReceivingCompleteResponse body;
|};
