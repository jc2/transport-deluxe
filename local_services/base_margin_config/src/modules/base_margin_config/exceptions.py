class ConfigNotFoundError(Exception):
    """Raised when a requested configuration does not exist."""


class DuplicateConfigError(Exception):
    """Raised when a configuration with the same parameters already exists."""
