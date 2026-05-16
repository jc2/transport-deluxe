class ConfigNotFoundError(Exception):
    """Raised when a requested fuel cost configuration does not exist."""


class DuplicateConfigError(Exception):
    """Raised when a fuel cost configuration with the same parameters already exists."""
