<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template match="d:topic" mode="title.markup">
    <xsl:param name="allow-anchors" select="0"/>
    <xsl:variable name="title" select="(d:info/d:title|d:title)[1]"/>
    <xsl:apply-templates select="$title" mode="title.markup">
      <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="d:topic" mode="titleabbrev.markup">
    <xsl:param name="allow-anchors" select="0"/>
    <xsl:param name="verbose" select="1"/>
    <xsl:variable name="titleabbrev"
      select="(d:info/d:titleabbrev|d:titleabbrev)[1]"/>
    <xsl:choose>
      <xsl:when test="$titleabbrev">
        <xsl:apply-templates select="$titleabbrev" mode="title.markup">
          <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="title.markup">
          <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
          <xsl:with-param name="verbose" select="$verbose"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
