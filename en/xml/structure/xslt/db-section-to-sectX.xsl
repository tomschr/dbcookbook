<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  
  <xsl:import href="copy.xsl"/>
  
  <xsl:template match="d:section">
    <xsl:variable name="level" select="count(ancestor::*)"/>
    <xsl:element name="sect{$level}" namespace="http://docbook.org/ns/docbook">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>