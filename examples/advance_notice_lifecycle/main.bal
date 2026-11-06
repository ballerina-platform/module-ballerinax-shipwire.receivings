// Creates an advance ship notice and optionally cancels it afterwards.

import ballerina/io;
import ballerinax/shipwire.receivings;

configurable string username = ?;
configurable string password = ?;
configurable int:Signed32 warehouseId = ?;
configurable int productId = ?;
configurable int quantity = ?;
configurable boolean cancelAfterCreate = false;
configurable receivings:AddressResource shipFrom = ?;
configurable receivings:Shipment shipment = ?;

public function main() returns error? {
    receivings:Client shipwire = check new ({auth: {username, password}});

    receivings:CreateReceivingRequest request = {
        arrangement: {'type: "none"},
        shipFrom,
        options: {warehouseId},
        shipments: shipment,
        items: [{productId, quantity}]
    };
    receivings:CreateReceivingResponse created = check shipwire->createReceiving(request);
    string? location = created.resourceLocation;
    if location is () {
        return error("Shipwire did not return a location for the new receiving");
    }
    io:println("Created receiving: ", location);

    if cancelAfterCreate {
        int slash = location.lastIndexOf("/") ?: -1;
        string id = location.substring(slash + 1);
        receivings:CancelReceivingResponse cancelled = check shipwire->cancelReceiving(id);
        io:println("Cancelled: ", cancelled.message ?: "ok");
    }
}
