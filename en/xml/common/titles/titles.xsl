<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">
  
  <xsl:import href="https://cdn.docbook.org/release/xsl/current/xhtml/docbook.xsl"/>
  
  <xsl:template match="d:article">
    <xsl:message>
 Article Title:       <xsl:apply-templates select="." mode="title.markup"/>
 Article Subtitle:    <xsl:apply-templates select="." mode="subtitle.markup"/>
 Article Titleabbrev: <xsl:apply-templates select="." mode="titleabbrev.markup"/>     
    </xsl:message>    
    <xsl:apply-imports/>
  </xsl:template>
  
</xsl:stylesheet>