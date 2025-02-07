"""Logging module configuration."""

import logging
import os
import logging.config
from pydantic import BaseModel
from typing import Any

# BaseModel is cool because it takes care of validation
# We use model_dump() which returns a dictionary of the model's fields and values and feed this into dictConfig to configure the logger

class LoggerConfig(BaseModel):
    """Logging configuration."""

    LOG_FORMAT: str = (
        "[sumup] [%(asctime)s] [%(levelname)s] "
        "[%(threadName)s] [%(name)s] %(message)s"
    )

    MESSAGE_ONLY_FORMAT: str = "%(message)s"

    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")

    # Logging config
    version: int = 1
    disable_existing_loggers: bool = False
    formatters: dict[str, Any] = {
        "default": {"format": LOG_FORMAT},
        "message_only": {"format": MESSAGE_ONLY_FORMAT},
    }
    handlers: dict[str, Any] = {
        "console": {
            "formatter": "default",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stdout",
        },
        "console_message_only": {
            "formatter": "message_only",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stdout",
        },
    }
    loggers: dict[str, Any] = {
        "file_logger": {"handlers": ["console", "file"], "level": "INFO"},
        "basic_logger": {"handlers": ["console"], "level": "INFO"},
    }

def get_logger(logger_name: str) -> logging.Logger:
    """Get logger by name.

    Args:
        logger_name (str): name of the logger

    Returns:
        logging.Logger: logger
    """
    logging.config.dictConfig(LoggerConfig().model_dump())
    return logging.getLogger(logger_name)
