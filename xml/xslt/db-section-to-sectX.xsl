<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  
  <xsl:import href="copy.xsl"/>
  
  <xsl:template match="section">
    <xsl:variable name="level" select="ancestor-or-self::*"/>
    <xsl:element name="sect{$level}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>