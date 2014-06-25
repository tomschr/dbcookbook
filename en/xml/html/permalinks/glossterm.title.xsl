<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d">
  
  <xsl:template match="d:glossentry/d:glossterm">
    <xsl:variable name="id" select="(@id|../@id)[last()]"/>
    <xsl:apply-imports/>
    <xsl:if test="$generate.permalink != 0">
      <xsl:message>Generating permalink for glossterm <xsl:value-of
          select="concat('&quot;', normalize-space(.), '&quot;')"/></xsl:message>
      <xsl:call-template name="permalink">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>