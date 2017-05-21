<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template name="section.level">
    <xsl:param name="node" select="."/>
    <xsl:choose>
      <xsl:when test="local-name($node)='topic'">1</xsl:when>
      <xsl:when test="local-name($node)='sect1'">1</xsl:when>
      <xsl:when test="local-name($node)='sect2'">2</xsl:when>
      <xsl:when test="local-name($node)='sect3'">3</xsl:when>
      <xsl:when test="local-name($node)='sect4'">4</xsl:when>
      <xsl:when test="local-name($node)='sect5'">5</xsl:when>
      <xsl:when test="local-name($node)='section'">
        <xsl:choose>
          <xsl:when test="$node/../../../../../../d:section"
            >6</xsl:when>
          <xsl:when test="$node/../../../../../d:section">5</xsl:when>
          <xsl:when test="$node/../../../../d:section">4</xsl:when>
          <xsl:when test="$node/../../../d:section">3</xsl:when>
          <xsl:when test="$node/../../d:section">2</xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when
        test="local-name($node)='refsect1' or
                    local-name($node)='refsect2' or
                    local-name($node)='refsect3' or
                    local-name($node)='refsection' or
                    local-name($node)='refsynopsisdiv'">
        <xsl:call-template name="refentry.section.level">
          <xsl:with-param name="node" select="$node"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="local-name($node)='simplesect'">
        <xsl:choose>
          <xsl:when test="$node/../../d:sect1">2</xsl:when>
          <xsl:when test="$node/../../d:sect2">3</xsl:when>
          <xsl:when test="$node/../../d:sect3">4</xsl:when>
          <xsl:when test="$node/../../d:sect4">5</xsl:when>
          <xsl:when test="$node/../../d:sect5">5</xsl:when>
          <xsl:when test="$node/../../d:section">
            <xsl:choose>
              <xsl:when test="$node/../../../../../d:section"
                >5</xsl:when>
              <xsl:when test="$node/../../../../d:section">4</xsl:when>
              <xsl:when test="$node/../../../d:section">3</xsl:when>
              <xsl:otherwise>2</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- section.level -->

</xsl:stylesheet>
