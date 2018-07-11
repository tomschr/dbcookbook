#!/usr/bin/python
#
# Purpose:
#  Converts each XML entity (like &product;) into a processing
#  instruction <?entity product?>
#
# Author: 2018, Thomas Schraitle

from __future__ import print_function

import os
import sys
from contextlib import contextmanager
from shutil import copystat
from tempfile import NamedTemporaryFile

from lxml import etree


@contextmanager
def backup(filename, ext=".bak"):
    """Context manager for making a backup from a XML file

     :param str filename: the XML filename
     :param str ext: file extension for the backup (default '.bak')
    """
    # split into dirname and basename:
    dirname, basename = os.path.split(filename)
    tmp = NamedTemporaryFile(dir=dirname if dirname else ".",
                             prefix=".{}".format(basename),
                             # encoding="utf-8",
                             delete=False)
    try:
        yield tmp
    finally:
        bak = filename + ext
        tmp.close()
        copystat(filename, tmp.name)
        os.rename(filename, bak)
        os.rename(tmp.name, filename)
        print("%s -> %s" % (filename, bak))


def replace_entity(tree):
    """Replace entities in XML tree

     :param tree: the XML tree
     :type tree: :class:`lxml.etree._ElementTree`
    """
    # We are only interested in entities:
    DBURI = "http://docbook.org/ns/docbook"
    for ent in tree.iter(etree.Entity):
        name = ent.name
        parent = ent.getparent()
        #  phrase = etree.Element("{%s}phrase" % DBURI,
        #                         attrib={'role': 'ent'},
        #                         nsmap={None: DBURI})
        #  phrase.text = name
        pi = etree.ProcessingInstruction("entity", name)
        parent.replace(ent, pi)


def process(xmlfile):
    """Process a single XML file and replace its entities

    :param str xmlfile: the XML file
    :return: zero means success
    :rtype: int
    """
    parser = etree.XMLParser(resolve_entities=False, collect_ids=False)
    with backup(xmlfile) as tmp:
        tree = etree.parse(xmlfile, parser=parser)
        replace_entity(tree)
        tree.write(tmp, encoding="utf-8",)

    return 0


def main(xmlfiles):
    """Process XML file and replace any custom entities with the
      element <phrase role="ent">entname</phrase>

    :param str xmlfile: path to the XML file
    :return: zero means success
    :rtype: int
    """

    for xml in xmlfiles:
        res = process(xml)
    return res


if __name__ == "__main__":
    try:
        if not os.path.exists(sys.argv[1]):
            print("ERROR: File %r does not exist" % sys.argv[1], file=sys.stderr)
            sys.exit(1)
        result = main(sys.argv[1:])
        sys.exit(result)
    excecpt etree.XMLSyntaxError as err:
        print(err, file=sys.stderr)
        sys.exit(10)
    except IndexError:
        print("ERROR: Need a DocBook file", file=sys.stderr)
        sys.exit(20)
