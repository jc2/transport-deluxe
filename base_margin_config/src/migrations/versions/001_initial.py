"""initial

Revision ID: 001
Revises:
Create Date: 2026-04-24 10:00:00.000000

"""

from collections.abc import Sequence
from typing import Union

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = "001"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        "base_margin_config",
        sa.Column("uuid", postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False),
        sa.Column("customer_name", sa.String(), nullable=True),
        sa.Column("customer_subname", sa.String(), nullable=True),
        sa.Column("pickup_country", sa.String(), nullable=True),
        sa.Column("pickup_state", sa.String(), nullable=True),
        sa.Column("pickup_city", sa.String(), nullable=True),
        sa.Column("pickup_postal_code", sa.String(), nullable=True),
        sa.Column("drop_country", sa.String(), nullable=True),
        sa.Column("drop_state", sa.String(), nullable=True),
        sa.Column("drop_city", sa.String(), nullable=True),
        sa.Column("drop_postal_code", sa.String(), nullable=True),
        sa.Column("margin_percent", sa.Numeric(precision=10, scale=4), nullable=False),
        sa.Column("created_by", sa.String(), nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=False),
        sa.PrimaryKeyConstraint("uuid", "version"),
    )

    op.create_index(
        "ix_base_margin_config_lookup",
        "base_margin_config",
        [
            "customer_name",
            "customer_subname",
            "pickup_country",
            "pickup_state",
            "pickup_city",
            "pickup_postal_code",
            "drop_country",
            "drop_state",
            "drop_city",
            "drop_postal_code",
        ],
        unique=False,
    )

    op.create_unique_constraint(
        "uq_base_margin_config_active_lookup",
        "base_margin_config",
        [
            "customer_name",
            "customer_subname",
            "pickup_country",
            "pickup_state",
            "pickup_city",
            "pickup_postal_code",
            "drop_country",
            "drop_state",
            "drop_city",
            "drop_postal_code",
        ],
    )


def downgrade() -> None:
    op.drop_table("base_margin_config")
