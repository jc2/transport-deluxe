# Base Margin Configuration

Defines the business-standard profitability percentage applied based on customer relationships and geographical coordinates of the route.

## Attributes
### Identity & Hierarchy
- **Customer Name**: (Optional) Reference to [Customer](../entities/customer.md).
- **Customer Subname**: (Optional) Specific branch. *Requires **Customer Name***.

### Geography (Pickup & Drop)
The following attributes apply to both **Pickup** and **Drop** locations.
- **Country**: (Optional) ISO Country code.
- **State**: (Optional) state/province. *Requires **Country***.
- **City**: (Optional) *Requires **Country** and **State***.
- **Postal Code**: (Optional) *Requires **Country**, **State**, and **City***.

### Target
- **Margin Percent**: A decimal value (0 to 0.99) representing the desired profit margin.

> **Wildcard Logic**: In the database, a `NULL` value for any optional attribute acts as a **Global Matcher**. If an attribute is `NULL`, the configuration logic treats it as "Any/All", allowing for broader matches in the hierarchy.

> **Constraint**: At least one attribute (Customer or Geolocation) must be specified. A configuration cannot have all fields empty.

> **Uniqueness**: The combination of all identity and geographical fields must be unique. No duplicate configurations for the same specificity level are allowed.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Margin Configurator** role.

## Logic (Specificity Hierarchy)
The system selects the margin based on the "Most Specific Match" principle. The order of importance for resolution is:

1.  **Customer Context**: `Customer Name > Customer Subname`
2.  **Geographical Depth**: `Country > State > City > Postal Code`

### Resolution Priority (Descending)
1.  **Customer + Full Route**: Match on Customer/Subname AND both Pickup/Drop locations.
2.  **Customer + Single Point**: Match on Customer AND either Pickup OR Drop location.
3.  **Cross-Customer Route**: Match on both Pickup/Drop locations without customer specification.
4.  **Single Point / Global Default**: Match on only one location or the broadest geographical match available.

*Example: A configuration for `GlobalLogistics + TX` will override a general configuration for just `TX`.*

## Calculation
1. This configuration provides the `Base Margin Percent`.
2. It is used in the **Price Calculation** to determine the **Initial Base Margin**.
3. **Formula**: `Initial Base Margin = (all_in_cost * Base Margin Percent) / (1 - Base Margin Percent)`.

## Calculation Example
- **Load**: Customer A, Pickup TX, Drop CA.
- **Matched Margin**: 0.15 (15%)
- **Cost**: 100 USD
- **Initial Base Margin**: `(100 * 0.15) / (1 - 0.15) ≈ 17.65 USD`.
