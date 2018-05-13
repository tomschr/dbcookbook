<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % common.ent SYSTEM "../common/common.ent">
  %common.ent;
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
  <xsl:import href="&dburi;/xhtml-1_1/chunk-common.xsl"/>

  <xsl:output method="xml"/>  
  
  <xsl:include href="&dburi;/xhtml-1_1/chunk-code.xsl"/>
  <xsl:include href="navigation.xsl"/>
  
  <xsl:param name="chunker.output.method" select="'xml'"/>
  <xsl:param name="chunker.output.doctype-system" select="''"/>
  <xsl:param name="chunker.output.doctype-public" select="''"/>
  <!-- Use the following with care: Only enable it for debugging
    purpose: -->
  <!--<xsl:param name="chunker.output.indent" select="'yes'"/>-->
  
</xsl:stylesheet>
