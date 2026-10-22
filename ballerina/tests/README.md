# Running Tests

## Prerequisites

To run the tests against a live Shipwire account, set these environment variables:

- `IS_LIVE_SERVER`: set to `true` to run against the live API
- `SHIPWIRE_USERNAME`: the Shipwire username
- `SHIPWIRE_PASSWORD`: the Shipwire password
- `SHIPWIRE_RECEIVING_ID`: the ID of an existing receiving to read

## Test Environments

There are two test environments for running the tests:

| Test Group | Environment |
|---|---|
| mock_tests | Mock server (`tests/mock_service.bal`) on port 9090 |
| live_tests | Shipwire API. Only read-only operations run live |

## Running the Tests

```bash
bal test --groups mock_tests
IS_LIVE_SERVER=true bal test --groups live_tests
```

The suite covers listing, retrieving, creating, updating, cancelling and completing receivings, and reading their items, holds, shipments, trackings, labels, extended attributes and instruction recipients.
