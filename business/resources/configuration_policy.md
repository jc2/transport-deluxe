# Configuration Management Policy

All system configurations (both Cost and Margin) follow a strict lifecycle and audit policy to ensure transparency and traceability.

## Versioning and Immutability
- **Immutability**: Configurations are never physically deleted from the database.
- **Soft Delete**: When a configuration is "removed", it is marked as inactive but remains in the version history.
- **Single Active Version**: For any specific configuration context (e.g., a specific Customer + Truck Type combination), only the **latest version** is available for active use in predictions.
- **Version Sequence**: Every edit creates a brand new version of the configuration.

## Role-Based Access Control (RBAC)
This policy applies to **ALL** configuration files in the system:
- **Cost Configurations**: Only accessible by the **Cost Configurator** role. Includes everything related to `all_in_cost`.
- **Margin Configurations**: Only accessible by the **Margin Configurator** role. Includes everything related to `all_in_margin`.
- **Exclusivity**: A user with one role cannot affect configurations belonging to the other.

## Audit Requirements
Every configuration version must store:
- **Created By**: The identity of the [User](../entities/user.md) who created the version.
- **Created At**: The timestamp when the version was created.
- **Edited By**: Since an edit is a new version, this identifies who performed the change.
- **Edited At**: The timestamp of the modification.

> **Business Rule**: It is mandatory to know exactly **who** changed **what** and **when** for any configuration that impacts the final price prediction.
