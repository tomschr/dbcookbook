<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="drop.caps.size">20pt</xsl:param>
  <xsl:param name="drop.caps.font-family" select="$body.font.family"/>
  <xsl:param name="drop.caps.font-weight">bold</xsl:param>
  
  <xsl:template name="create.initial">
    <xsl:param name="initial" select="substring(normalize-space(.),1,1)"/>
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