<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <xsl:import href="copy.xsl"/>
  
  <xsl:template match="sect1|sect2|sect3|sect4|sect5">
    <xsl:element name="section">
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>