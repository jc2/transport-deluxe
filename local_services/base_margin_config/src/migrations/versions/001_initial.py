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
        sa.CheckConstraint(
            "customer_subname IS NULL OR customer_name IS NOT NULL", name="chk_customer_subname_requires_name"
        ),
        sa.CheckConstraint(
            "pickup_state IS NULL OR pickup_country IS NOT NULL", name="chk_pickup_state_requires_country"
        ),
        sa.CheckConstraint("pickup_city IS NULL OR pickup_state IS NOT NULL", name="chk_pickup_city_requires_state"),
        sa.CheckConstraint(
            "pickup_postal_code IS NULL OR pickup_city IS NOT NULL", name="chk_pickup_postal_requires_city"
        ),
        sa.CheckConstraint("drop_state IS NULL OR drop_country IS NOT NULL", name="chk_drop_state_requires_country"),
        sa.CheckConstraint("drop_city IS NULL OR drop_state IS NOT NULL", name="chk_drop_city_requires_state"),
        sa.CheckConstraint("drop_postal_code IS NULL OR drop_city IS NOT NULL", name="chk_drop_postal_requires_city"),
        sa.CheckConstraint(
            "customer_name IS NOT NULL OR pickup_country IS NOT NULL OR drop_country IS NOT NULL",
            name="chk_at_least_one_field",
        ),
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
