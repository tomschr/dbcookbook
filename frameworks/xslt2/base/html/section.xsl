<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:sf="http://doccookbook.sf.net/ns/"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l sf">


<xsl:param name="generate.userlevel" select="1"/>
<xsl:param name="userlevel.easy"  >⚑⚐⚐</xsl:param><!-- ★☆☆ -->
<xsl:param name="userlevel.medium">⚑⚑⚐</xsl:param><!-- ★★☆ -->
<xsl:param name="userlevel.hard"  >⚑⚑⚑</xsl:param><!-- ★★★ -->

<xsl:template name="sf:generate-userlevel">
  <xsl:param name="level" select="normalize-space(@userlevel)"/>
  <xsl:variable name="ul"
    select="if ($level='hard' or $level='heavy') 
            then 'hard' 
            else $level"/>
  
  <xsl:variable name="d">
    <xsl:choose>
      <xsl:when test="$ul = 'easy'">
        <xsl:copy-of select="$userlevel.easy"/>
      </xsl:when>
      <xsl:when test="$ul = 'medium'">
        <xsl:copy-of select="$userlevel.medium"/>
      </xsl:when>
      <xsl:when test="$ul = 'hard'">
        <xsl:copy-of select="$userlevel.hard"/>
      </xsl:when>
      <xsl:otherwise><xsl:copy-of select="$userlevel.medium"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:if test="exists($ul) and $generate.userlevel != 0">
    <div class="section-userlevel" title="difficulty: {$ul}">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">Difficulty</xsl:with-param>
      </xsl:call-template>
      <xsl:value-of select="$d"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-permalink">
   <xsl:param name="node" select="."/>
   <xsl:variable name="next"
     select="($node/following::d:sect1|$node/following::d:section)[1]"/>
   <xsl:variable name="prev"
     select="($node/preceding::d:sect1|$node/preceding::d:section)[1]"/>
  <xsl:if test="$prev">
    <span class="section-prev">
      <a rel="prev" href="{f:href(., $prev)}">
        <!--<xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$prev"/>
          </xsl:call-template>
        </xsl:attribute>-->
        <!--<xsl:attribute name="title">
          <xsl:apply-templates select="$prev" mode="object.title.markup.textonly"/>
        </xsl:attribute>-->
        <xsl:text>▲</xsl:text>
      </a>
    </span>
  </xsl:if>
  <xsl:if test="$next">
    <span class="section-next">
      <a rel="next" href="{f:href(., $next)}">
        <!--<xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$next"/>
          </xsl:call-template>
        </xsl:attribute>-->
        <!--<xsl:attribute name="title">
          <xsl:apply-templates select="$next" mode="object.title.markup.textonly"/>
        </xsl:attribute>-->
        <xsl:text>▼</xsl:text>
      </a>
    </span>
  </xsl:if>
</xsl:template>

<xsl:template match="d:section[not(parent::d:section)]/d:title|
                     d:section[not(parent::d:section)]/d:info/d:title" mode="m:titlepage-mode">
  <xsl:variable name="depth" select="min((count(ancestor::d:section), 4))"/>

  <xsl:variable name="context"
                select="if (parent::d:info) then parent::d:info/parent::* else parent::*"/>

  <xsl:element name="h{$depth + 2}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates select="$context" mode="m:object-title-markup">
      <xsl:with-param name="allow-anchors" select="true()"/>
    </xsl:apply-templates>
  </xsl:element>
  <!--<xsl:call-template name="sf:generate-permalink"/>-->
  <xsl:call-template name="sf:generate-userlevel">
    <xsl:with-param name="level"
      select="(../@userlevel|../../@userlevel)[1]"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>