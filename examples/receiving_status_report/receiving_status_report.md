# Receiving status report

This example retrieves an advance ship notice from Shipwire and reports its status, items and holds. It is useful for monitoring inbound inventory.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Shipwire account with access to the receivings API
- Create a `Config.toml` in this directory:
  ```toml
  username = "<Shipwire username>"
  password = "<Shipwire password>"
  receivingId = "<Receiving ID>"
  ```

## Run the example

```bash
bal run
```
