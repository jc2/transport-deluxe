# Customer

Our clients are represented as a single entity with a two-level hierarchy to manage global operations and regional specifics.

## Attributes
- **Name**: The top-level global entity identifier (e.g., `Acme Corp`).
- **Subname**: (Optional) A regional or specific branch identifier (e.g., `Texas_Branch`).

## Rules
- A **Customer** is uniquely identified by the combination of its **Name** and **Subname**.
- Every business operation must reference the Customer using this structure to ensure absolute clarity.

## Commercial Context
- **Subsidies**: Specific Customer branches (where `subname` is present) may have subsidized fuel costs.
- **Discounts**: The top-level Customer (where `subname` is empty or generic) may have scheduled discounts based on the day of the week.
