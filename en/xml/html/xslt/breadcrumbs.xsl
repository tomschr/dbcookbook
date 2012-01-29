<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d">

  <xsl:param name="breadcrumbs.separator" select="' > '"/>
  
  <xsl:template name="generate.breadcrumb">
    <xsl:param name="current.node" select="."/>

    <xsl:for-each select="ancestor::*">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="."/>
            <xsl:with-param name="context" select="$current.node"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="$current.node/d:title">
            <xsl:value-of select="normalize-space($current.node/d:title)"/>
          </xsl:when>
          <xsl:when test="$current.node/d:info/d:title">
            <xsl:value-of
              select="normalize-space($current.node/d:info/d:title)"/>
          </xsl:when>
        </xsl:choose>
      </a>
      <xsl:value-of select="$breadcrumbs.separator"/>
    </xsl:for-each>

    <!-- 
     We don't want to make the current page an active link 
    -->
    <xsl:if test="$current.node != /*">
      <strong>
        <xsl:choose>
          <xsl:when test="$current.node/d:title">
            <xsl:value-of select="normalize-space($current.node/d:title)"/>
          </xsl:when>
          <xsl:when test="$current.node/d:info/d:title">
            <xsl:value-of
              select="normalize-space($current.node/d:info/d:title)"/>
          </xsl:when>
        </xsl:choose>
      </strong>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>