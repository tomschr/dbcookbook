<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY db "https://cdn.docbook.org/release/xsl/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="&db;/fo/docbook.xsl"/>
  
  <xsl:param name="line-height">0.9</xsl:param>
  <xsl:attribute-set name="normal.para.spacing">
    <xsl:attribute name="background-color">blue</xsl:attribute>
    <xsl:attribute name="border">0.75pt dotted gray</xsl:attribute>
    <xsl:attribute name="margin-top">0pt</xsl:attribute>
    <xsl:attribute name="padding-top">0pt</xsl:attribute>
    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">0pt</xsl:attribute>
    <xsl:attribute name="line-height.conditionality">discard</xsl:attribute>
  </xsl:attribute-set>
  
  
  <xsl:template match="d:para/text()">
    <!--<xsl:variable name="text" select="substring-before(normalize-space(.),
      ' dolor')"/>-->
      <fo:inline line-height.precedence="5"
        background-color="darkgray" color="white"
        line-stacking-strategy="line-height">
        <xsl:value-of select="."/>
      </fo:inline>
    <!--
      <xsl:value-of select="substring-after(normalize-space(.), 'Lorem ipsum')"/>-->
  </xsl:template>
  
</xsl:stylesheet>