import subprocess
import shlex

from .log import logger


def execute(cmd, **kwargs):
    """Execute a system command, passing STDOUT and STDERR to logger.

    Source: https://stackoverflow.com/a/4417735/2063031
    """
    if isinstance(cmd, str):
        logger.info("cmd: %r", cmd)
        cmd = shlex.split(cmd)
    elif isinstance(cmd, (list, tuple)):
        logger.info("cmd: %r", " ".join(cmd))
    else:
        raise TypeError("Expected in execute: str, list, or tuple for command")

    with subprocess.Popen(cmd,
                          stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT,
                          universal_newlines=True,
                          **kwargs) as popen:
        for line in iter(popen.stdout.readline, ""):
            logger.debug(line.strip())
    rc = popen.wait()
    logger.info("Return code: %s", rc)
    if rc:
        raise subprocess.CalledProcessError(rc, cmd)
