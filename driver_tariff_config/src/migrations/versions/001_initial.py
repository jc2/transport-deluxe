"""initial schema: driver_tariff_config table

Revision ID: 001_initial
Revises:
Create Date: 2026-04-24

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
        "driver_tariff_config",
        sa.Column("uuid", sa.UUID(), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False),
        sa.Column("pickup_state", sa.String(50), nullable=True),
        sa.Column("drop_state", sa.String(50), nullable=True),
        sa.Column("tariff_factor", sa.Numeric(10, 4), nullable=False),
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
        "idx_dtc_lookup",
        "driver_tariff_config",
        ["pickup_state", "drop_state"],
    )

    op.create_index(
        "idx_dtc_uuid",
        "driver_tariff_config",
        ["uuid"],
    )

    op.create_index(
        "idx_dtc_sort",
        "driver_tariff_config",
        [sa.text("created_at DESC")],
    )


def downgrade() -> None:
    op.drop_index("idx_dtc_sort", table_name="driver_tariff_config")
    op.drop_index("idx_dtc_uuid", table_name="driver_tariff_config")
    op.drop_index("idx_dtc_lookup", table_name="driver_tariff_config")
    op.drop_table("driver_tariff_config")
