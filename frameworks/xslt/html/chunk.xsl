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
  
  <!-- Start here with my customization -->
  <!--<xsl:include href="navigation.xsl"/>-->
  <!--<xsl:include href="breadcrumbs.xsl"/>-->

  <!--<xsl:param name="chunk.fast" select="1"/>-->
  <!--<xsl:param name="highlight.source" select="0"/>-->

  <!--<xsl:template match="/" priority="2">
    <xsl:message>XSLT Processor:
     version: <xsl:value-of select="system-property('xsl:version')"/>
     vendor: <xsl:value-of select="system-property('xsl:vendor')"/>
     vendor-url: <xsl:value-of select="system-property('xsl:vendor-url')"/> 
     exsl:document: <xsl:value-of select="boolean(element-available('exsl:document'))"/>
     xsl:document: <xsl:value-of select="boolean(element-available('xsl:document'))"/> 
    </xsl:message>
    <xsl:apply-imports/>
  </xsl:template>-->
  
</xsl:stylesheet>