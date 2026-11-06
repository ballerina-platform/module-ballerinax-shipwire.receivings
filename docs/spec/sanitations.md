_Author_:  @DimuthuMadushan \
_Created_: 2026/10/21 \
_Updated_: 2026/10/22 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Shipwire Receivings. 
The OpenAPI specification is obtained from at https://github.com/wso2/api-specs/blob/main/openapi/shipwire/receivings/3.0/openapi.yaml.
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Update the API Paths
- **Original**: Paths included common prefix `/api` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

2. Remove the duplicate slash in the server URL
- **Original**: The Swagger `host` and `basePath: /` make the aligned server URL `https://api.shipwire.com//api`.
- **Updated**: The server URL in the aligned spec is `https://api.shipwire.com/api`. This is an edit to the aligned spec (`docs/spec/aligned_ballerina_openapi.*`) and must be re-applied after a re-align.
- **Reason**: A double slash after the host breaks request URLs.

3. Rename operations and schemas
- **Original**: Operation IDs such as `ApiV3ReceivingsGet` and schema names such as `GetListOfAdvanceShipNoticesResponse`.
- **Updated**: Operations are named `listReceivings`, `createReceiving`, `getReceiving`, `updateReceiving`, `cancelReceiving`, `cancelReceivingLabels`, `listReceivingHolds`, `listReceivingInstructionsRecipients`, `listReceivingExtendedAttributes`, `listReceivingItems`, `listReceivingShipments`, `listReceivingTrackings`, `listReceivingLabels` and `markReceivingComplete`. Response schemas follow `<Entity>Response` (for example `ListReceivingsResponse`, `ReceivingResponse`). The decisions are persisted in `docs/spec/ai-mappings.json`.
- **Reason**: Intent-revealing, stable names for the generated client methods and types.

4. Document the undocumented response and item fields
- **Original**: The `resource` property of the receiving response schemas (holds, instructions recipients, extended attributes, items, shipments, trackings, labels), `lotControl` and `extendedAttributes` on `ReceivingItem`, and `type` on `Arrangement` had no description.
- **Updated**: Each now has a description. The `$ref` properties are wrapped as `allOf` with a description. This change was made in the original spec `docs/spec/openapi.yml`.
- **Reason**: Removes the `undocumented field` compiler warnings in the generated types.

5. Fix the self-referencing `extendedAttributes` property of the create request
- **Original**: `CreateAnAdvanceShipNoticeRequest.extendedAttributes` referenced `CreateAnAdvanceShipNoticeRequest` itself.
- **Updated**: It is an array of `ExtendedAttributes` with a description. This change was made in the original spec `docs/spec/openapi.yml`.
- **Reason**: The self-reference made the request type recursive and did not match the API.

6. Repair the corrupted holds response resource schema
- **Original**: In `GetHoldDetailsResponse_resource` the description of `offset` swallowed the rest of the schema as one quoted string, so `total`, `previous`, `next` and `items` were missing.
- **Updated**: `offset` is an integer with its description, and `total`, `previous`, `next` and `items` are separate properties like the sibling resource schemas. `items` is an array of `ReceivingHolds_resource_items`. This change was made in the original spec `docs/spec/openapi.yml`.
- **Reason**: Restores the paging fields and hold items of the response.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --tags '' --license docs/license.txt -o ballerina --client-methods remote
```

Note: The license year is hardcoded to 2026, change if necessary.
