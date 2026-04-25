"""initial

Revision ID: 001_initial
Revises:
Create Date: 2026-04-25 00:00:00.000000

"""

from collections.abc import Sequence
from typing import Union

import sqlalchemy as sa
import sqlmodel
from alembic import op

# revision identifiers, used by Alembic.
revision: str = "001_initial"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Manual table creation for lead_time_config
    op.create_table(
        "lead_time_config",
        sa.Column("uuid", sa.UUID(), nullable=False),
        sa.Column("version", sa.Integer(), nullable=False),
        sa.Column("min_days", sa.Integer(), nullable=False),
        sa.Column("max_days", sa.Integer(), nullable=True),
        sa.Column("configuration_factor", sa.Numeric(precision=5, scale=4), nullable=False),
        sa.Column("created_by", sqlmodel.sql.sqltypes.AutoString(length=255), nullable=False),
        sa.Column("created_at", sa.DateTime(), nullable=False),
        sa.PrimaryKeyConstraint("uuid", "version"),
    )


def downgrade() -> None:
    op.drop_table("lead_time_config")
