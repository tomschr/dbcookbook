#!/usr/bin/env python3
#
# Purpose:
#  Converts each XML entity (like &product;) into [[[product]]]
#  and vice versa.
#
#  Depending how the script is called (either as ent2text.py or
#  as text2ent.py, the right mode is selected automatically.
#
# Author: 2018, Thomas Schraitle

import fileinput
import os
import re
import sys

# Matches custom entities, but not default like &lt; etc.
ENT = re.compile(r"\&((?!lt|amp|quot|apos|gt)[^;]*);")

# Matches our protected text [[[X]]]
TXT = re.compile(r"\[\[\[([^\]]*)\]\]\]")

BASENAME = os.path.basename(__file__)


def ent2text(fileobj):
    """Converts entities into marked text:
       &product; -> [[[product]]]

    :param fileobj: file object from context manager
    :type fileobj: :class:`fileinput.FileInput`
    """
    for line in fileobj:
        if fileinput.isfirstline():
            sys.stderr.write(">> %s\n" % fileinput.filename())
        print(ENT.sub(r"[[[\1]]]", line), end="")


def text2ent(fileobj):
    """Converts marked text into entities:
       [[[product]]] -> &product;

    :param fileobj: file object from context manager
    :type fileobj: :class:`fileinput.FileInput`
    """
    for line in fileobj:
        if fileinput.isfirstline():
            sys.stderr.write(">> %s\n" % fileinput.filename())
        print(TXT.sub(r"&\1;", line), end="")


if BASENAME.startswith("ents2text") or BASENAME.startswith("ents2txt"):
    transform = ent2text
elif BASENAME.startswith("text2ents") or BASENAME.startswith("txt2ents"):
    transform = text2ent
else:
    print("ERROR: The script should be named ents2text, ents2txt, "
          "text2ents, or txt2ents.", file=sys.stderr)
    sys.exit(10)


def main():
    """Main entry point

    :return: return code zero
    """
    with fileinput.input(inplace=True, backup='.bak') as f:
        transform(f)
    return 0


def usage():
    """Print usage and exit with return code 1"""
    print("""Syntax:

  %s XMLFILE...
            """ % BASENAME)
    sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] in ('-h', '--help'):
        usage()
    sys.exit(main())
