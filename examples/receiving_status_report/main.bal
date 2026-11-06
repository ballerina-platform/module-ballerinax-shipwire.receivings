// Reports the current state of an advance ship notice: its details, items and holds.

import ballerina/io;
import ballerinax/shipwire.receivings;

configurable string username = ?;
configurable string password = ?;
configurable string receivingId = ?;

public function main() returns error? {
    receivings:Client shipwire = check new ({auth: {username, password}});

    receivings:ReceivingResponse receiving = check shipwire->getReceiving(receivingId);
    io:println("Receiving status: ", receiving.message ?: "unknown");

    receivings:ReceivingItemsResponse items = check shipwire->listReceivingItems(receivingId);
    io:println("Items resource: ", items.resourceLocation ?: "n/a");

    receivings:ReceivingHoldsResponse holds = check shipwire->listReceivingHolds(receivingId, includeCleared = 0);
    io:println("Holds resource: ", holds.resourceLocation ?: "n/a");
}
