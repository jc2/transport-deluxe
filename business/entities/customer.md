# Customer & Subcustomer

Our clients are organized into a two-level hierarchy to manage global operations and regional specifics.

## Hierarchy
- **Customer**: The top-level global entity.
- **Subcustomer**: A regional or specific branch.

## Rules
- A **Customer** can have multiple **Subcustomers**.
- A **Subcustomer** belongs to exactly one **Customer**.
- **References**: Every business operation must reference *both* the Customer and Subcustomer to ensure absolute clarity.

## Commercial Context
- **Subsidies**: Specific Subcustomers may have subsidized fuel costs.
- **Discounts**: Some Customers have scheduled discounts based on the day of the week.
