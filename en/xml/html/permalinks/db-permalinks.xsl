<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d">
  
  <xsl:import
    href="https://cdn.docbook.org/release/xsl/current/xhtml/docbook.xsl"/>
  <xsl:include href="permalinks.xsl"/>
  
  <xsl:include href="component.title.xsl"/>
  <xsl:include href="division.title.xsl"/>
  <xsl:include href="section.title.xsl"/>
  <xsl:include href="formal.object.heading.xsl"/>
</xsl:stylesheet>