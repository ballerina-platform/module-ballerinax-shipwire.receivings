## Overview

[Shipwire](https://www.shipwire.com/) is an order fulfillment and logistics platform that manages inventory across Shipwire and Shipwire Anywhere warehouses.

The Shipwire Receivings connector lets Ballerina applications manage receiving orders (advance ship notices) through version 3 of the Shipwire Receivings API. It supports creating, updating, listing, cancelling and completing receivings, and reading their items, holds, shipments, trackings, labels and instruction recipients.

### Key features

- Create and update advance ship notices for Shipwire and Shipwire Anywhere warehouses
- List and retrieve receiving orders with optional filters and expanded data
- Cancel receiving orders and receiving labels
- Mark receivings as complete
- Inspect receiving items, holds, shipments, trackings, labels and instruction recipients

## Setup guide

To use the Shipwire Receivings connector you need a Shipwire account with API access.

1. Sign in to your Shipwire account, or create one at [shipwire.com](https://www.shipwire.com/).

2. Make sure the account user you will authenticate with has permission to manage receivings.

3. Note the username (email) and password of that user. The connector authenticates with HTTP basic authentication using these credentials.

## Quickstart

To use the `shipwire.receivings` connector in your Ballerina application, update the `.bal` file as follows:

1. Import the `shipwire.receivings` module.

    ```ballerina
    import ballerinax/shipwire.receivings;
    ```

2. Create a `Config.toml` file with your credentials.

    ```toml
    username = "<Shipwire username>"
    password = "<Shipwire password>"
    ```

3. Create a `receivings:ConnectionConfig` and initialize the client.

    ```ballerina
    configurable string username = ?;
    configurable string password = ?;

    final receivings:Client shipwire = check new ({
        auth: {
            username,
            password
        }
    });
    ```

4. Invoke the connector operation.

    ```ballerina
    public function main() returns error? {
        receivings:ListReceivingsResponse _ = check shipwire->listReceivings();
    }
    ```

## Examples

The `Shipwire Receivings` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-shipwire.receivings/tree/main/examples/), covering the following use cases:

1. [Receiving status report](../examples/receiving_status_report/receiving_status_report.md) - Retrieve a receiving order together with its items and holds.
2. [Advance notice lifecycle](../examples/advance_notice_lifecycle/advance_notice_lifecycle.md) - Create an advance ship notice and optionally cancel it.
