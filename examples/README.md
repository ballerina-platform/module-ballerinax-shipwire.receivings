# Examples

The `ballerinax/shipwire.receivings` connector provides practical examples illustrating usage in various scenarios.

1. [Receiving status report](./receiving_status_report/receiving_status_report.md) - Retrieve a receiving order together with its items and holds.
2. [Advance notice lifecycle](./advance_notice_lifecycle/advance_notice_lifecycle.md) - Create an advance ship notice and optionally cancel it.

## Prerequisites

- A Shipwire account with access to the receivings API and its username and password.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
