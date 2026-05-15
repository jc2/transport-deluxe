class ConfigNotFoundError(Exception):
    """Raised when a requested configuration does not exist."""


class DuplicateConfigError(Exception):
    """Raised when a configuration with the same parameters already exists."""


class OverlappingConfigError(Exception):
    """Raised when a lead time configuration range overlaps with an existing one."""


class InvalidConfigError(Exception):
    """Raised when an update would produce an invalid configuration (e.g. min_days > max_days)."""
