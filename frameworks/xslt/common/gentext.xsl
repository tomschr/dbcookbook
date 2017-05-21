<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template match="d:topic" mode="object.title.template">
    <xsl:variable name="is.numbered">
      <xsl:call-template name="label.this.section"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$is.numbered != 0">
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'title-numbered'"/>
          <xsl:with-param name="name">
            <xsl:call-template name="xpath.location"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'title-unnumbered'"/>
          <xsl:with-param name="name">
            <xsl:call-template name="xpath.location"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
