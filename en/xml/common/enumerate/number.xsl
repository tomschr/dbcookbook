<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import
    href="https://cdn.docbook.org/release/xsl/current/xhtml/docbook.xsl"/>
  
  <xsl:template match="d:figure|d:table|d:example" mode="label.markup">
    <xsl:choose>
      <xsl:when test="@label">
        <xsl:value-of select="@label"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:number format="[a]" from="d:book|d:article" level="any"/>
        <xsl:number />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>