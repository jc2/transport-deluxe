"""initial schema: fuel_cost_config table

Revision ID: 001_initial
Revises:
Create Date: 2026-04-23

"""

from collections.abc import Sequence
from typing import Union

import sqlalchemy as sa
from alembic import op

revision: str = "001_initial"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        "fuel_cost_config",
        sa.Column("uuid", sa.UUID(), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False),
        sa.Column("customer_name", sa.String(255), nullable=True),
        sa.Column("customer_subname", sa.String(255), nullable=True),
        sa.Column("truck_type", sa.String(50), nullable=False),
        sa.Column("fuel_cost_per_km", sa.Numeric(10, 4), nullable=False),
        sa.Column("created_by", sa.String(255), nullable=False),
        sa.Column(
            "created_at",
            sa.TIMESTAMP(timezone=True),
            nullable=False,
            server_default=sa.text("NOW()"),
        ),
        sa.PrimaryKeyConstraint("uuid", "version"),
    )

    op.create_index(
        "idx_fcc_lookup",
        "fuel_cost_config",
        ["customer_name", "customer_subname", "truck_type"],
    )

    op.create_index(
        "idx_fcc_uuid",
        "fuel_cost_config",
        ["uuid"],
    )

    op.create_index(
        "idx_fcc_sort",
        "fuel_cost_config",
        [sa.text("created_at DESC")],
    )


def downgrade() -> None:
    op.drop_index("idx_fcc_sort", table_name="fuel_cost_config")
    op.drop_index("idx_fcc_uuid", table_name="fuel_cost_config")
    op.drop_index("idx_fcc_lookup", table_name="fuel_cost_config")
    op.drop_index("uq_fcc_active_combination", table_name="fuel_cost_config")
    op.drop_table("fuel_cost_config")
