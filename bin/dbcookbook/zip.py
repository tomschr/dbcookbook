#
#

from configparser import InterpolationMissingOptionError
from pathlib import Path
import os
import shlex
import subprocess
import tarfile
import zipfile

try:
    import zlib
    compression = zipfile.ZIP_DEFLATED
except:
    compression = zipfile.ZIP_STORED

from .config import config
from .log import trace, logger


def createzip(parser, args=None):
    if args is not None and not args.zip:
        logger.info("Skipping ZIP archive creation")
        return

    # TODO: maybe there is a better method:
    version = subprocess.check_output(shlex.split("git describe"))
    version = version.decode("utf-8").strip()

    try:
        zipfilename = config.get('Archive', 'zipfile').replace("@VERSION@", version)
        tarfilename = config.get('Archive', 'tarfile').replace("@VERSION@", version)
        root = os.path.normpath(config.get('Archive', 'root')).replace("@VERSION@", version)
        htmldir = os.path.normpath(config.get('Common', 'htmldir'))
    except InterpolationMissingOptionError as error:
        logger.warning(error)

    logger.info("Creating ZIP archive %r...", zipfilename)
    logger.info("root=%r", root)
    logger.info("htmldir=%r", htmldir)

    tarfilename = Path(tarfilename)
    MODES = {'.gz': 'w:gz',
             '.bz2': 'w:bz2',
             '.xz': 'w:xz'}
    writemode = MODES.get(tarfilename.suffix, 'w')
    logger.info("Using mode=%s for tar archive", writemode)

    with zipfile.ZipFile(zipfilename, mode="w", compression=compression) as zf, \
         tarfile.open(tarfilename, mode=writemode, dereference=True) as tf:
        path = Path(htmldir)
        PATHS=('*.html', 'css/*', 'highlighter/*', 'js/*')
        for p in PATHS:
            for pp in path.glob(p):
                dest = root / pp.relative_to(htmldir)
                zf.write(pp, arcname=dest)
                tf.add(pp, arcname=dest, recursive=False)
                logger.info("Adding %r...", str(dest))

        PATHS=('examples/**/*', 'png/**/*', )
        for p in PATHS:
            for pp in path.rglob(p):
                dest = root / pp.relative_to(htmldir)
                zf.write(pp, arcname=dest)
                tf.add(pp, arcname=dest, recursive=False)
                logger.info("Adding %r...", str(dest))

    logger.info("Successfully created archives")
