# Customer Cost Week Day Configuration

Defines special cost reductions based on the day of the week for specific customers.

## Attributes
- **Customer**: Reference to [Customer](../entities/customer.md). If a Subcustomer does not have a specific configuration, it inherits the configuration from its parent Customer.
- **Day of Week**: Monday through Sunday.
- **Multiplier Factor**: Negative decimal value (e.g. -0.1 for a 10% discount). This multiplier always evaluates to a negative number or 0.0.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Cost Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., -1.0 = -100%, -0.1 = -10%).

## Logic
1. The system identifies the `Day of Week` for the `Shipment Date`.
2. It looks for a matching `Customer + Day of Week` entry.
3. The resulting factor is applied to the **Base Cost Adjustment** to produce the [Customer Cost Adjustment](../interactions/customer_cost_adjustment.md).
4. If no rule exists for the specific customer or day, the result is `0.0`.
