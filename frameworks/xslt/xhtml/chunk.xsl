<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!--<!ENTITY db "http://docbook.sourceforge.net/release/xsl/current/xhtml">-->
  <!ENTITY db "../../db-xslt/xhtml-1_1">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:exsl="http://exslt.org/common"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink exsl"
  extension-element-prefixes="exsl">
 
  <xsl:import href="docbook.xsl"/>
  <xsl:import href="&db;/chunk-common.xsl"/>

  <xsl:output method="xml"/>  
  
  <xsl:include href="&db;/chunk-code.xsl"/>
  
  <xsl:param name="chunker.output.method" select="'xml'"/>
  <xsl:param name="chunker.output.doctype-system" select="''"/>
  <xsl:param name="chunker.output.doctype-public" select="''"/>
  <xsl:param name="chunker.output.indent" select="'yes'"/>
  
</xsl:stylesheet>