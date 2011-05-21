<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <xsl:import href="copy.xsl"/>
  
  <xsl:template match="d:sect1|d:sect2|d:sect3|d:sect4|d:sect5">
    <xsl:element name="section" namespace="http://docbook.org/ns/docbook">
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>