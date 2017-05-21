<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template match="d:topic" mode="label.markup">
    <xsl:variable name="parent.is.component">
      <xsl:call-template name="is.component">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="component.label">
      <xsl:if
        test="$section.label.includes.component.label != 0
                  and $parent.is.component != 0">
        <xsl:variable name="parent.label">
          <xsl:apply-templates select=".." mode="label.markup"/>
        </xsl:variable>
        <xsl:if test="$parent.label != ''">
          <xsl:apply-templates select=".." mode="label.markup"/>
          <xsl:apply-templates select=".." mode="intralabel.punctuation"
          />
        </xsl:if>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="is.numbered">
      <xsl:call-template name="label.this.section"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@label">
        <xsl:value-of select="@label"/>
      </xsl:when>
      <xsl:when test="$is.numbered != 0">
        <xsl:variable name="format">
          <xsl:call-template name="autolabel.format">
            <xsl:with-param name="format" select="$section.autolabel"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:copy-of select="$component.label"/>
        <xsl:number format="{$format}" count="d:topic"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
