<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY db "http://docbook.sourceforge.net/release/xsl-ns/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="&db;/fo/docbook.xsl"/>
  
  <xsl:param name="drop.caps.size">20pt</xsl:param>
  <xsl:param name="drop.caps.font-family" select="$body.font.family"/>
  <xsl:param name="drop.caps.font-weight">bold</xsl:param>
  
  <xsl:attribute-set name="drop.caps.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-size">20pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="d:article/d:section/d:para[1]/text()">
    <xsl:variable name="initial" select="substring(normalize-space(.),
      1,1)"/>
    <xsl:message>Initial: <xsl:value-of select="$initial"/></xsl:message>
    <fo:inline>
      <fo:inline font-size="{$drop.caps.size}"
        font-weight="{$drop.caps.font-weight}"
        font-family="{$drop.caps.font-family}">
        <xsl:copy-of select="$initial"/>
      </fo:inline>
      <xsl:value-of select="substring(normalize-space(.), 2)"/>
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>