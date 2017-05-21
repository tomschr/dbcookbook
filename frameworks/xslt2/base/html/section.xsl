<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  xmlns:mp="http://docbook.org/xslt/ns/mode/private"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:sf="http://doccookbook.sf.net/ns/"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l sf mp">

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
    <div class="section-userlevel" title="{$ul}">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">Difficulty</xsl:with-param>
      </xsl:call-template>
      <xsl:value-of select="concat($d, ' (', $ul, ')')"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-prevnext-sectionlinks">
  <xsl:param name="node" select="."/>
  <xsl:if test="$generate.prevnext.sectionlinks != 0">
   <xsl:variable name="next"
     select="($node/following::d:sect1|$node/following::d:section)[parent::d:chapter][1]"/>
   <xsl:variable name="prev"
     select="($node/preceding::d:sect1|$node/preceding::d:section)[parent::d:chapter][last()]"/>
    <div class="section-navig">
  <xsl:if test="$prev">
    <span class="section-prev">
      <!--
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'section-prev'"/>
        </xsl:call-template>
      -->
      <a rel="prev" href="{f:href(., $prev)}">
        <!--<xsl:apply-templates select="$prev" mode="mp:title-content">
          <xsl:with-param name="allow-anchors" select="false()"/>
        </xsl:apply-templates>-->
        <xsl:apply-templates select="$prev" mode="m:title-content">
          <xsl:with-param name="allow-anchors" select="false()"/>
        </xsl:apply-templates>
        <!--<xsl:if test="generate-id(parent::d:chapter) !=
                      generate-id($prev/ancestor::d:chapter)">
          <xsl:text> (</xsl:text>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">inchapter</xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates select="$prev/ancestor::d:chapter" mode="mp:title-content">
            <xsl:with-param name="allow-anchors" select="false()"/>
          </xsl:apply-templates>
          <xsl:text>)</xsl:text>
        </xsl:if>-->
      </a>
    </span>
  </xsl:if>
  <xsl:if test="$next">
    <span class="section-next">
      <!--
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'section-next'"/>
        </xsl:call-template>
      -->
      <a rel="next" href="{f:href(., $next)}">
        <!--<xsl:apply-templates select="$next" mode="mp:title-content">
          <xsl:with-param name="allow-anchors" select="false()"/>
        </xsl:apply-templates>-->
        <xsl:apply-templates select="$next" mode="m:title-content">
          <xsl:with-param name="allow-anchors" select="false()"/>
        </xsl:apply-templates>
        <!--<xsl:if test="generate-id(parent::d:chapter) !=
                      generate-id($next/ancestor::d:chapter)">
          <xsl:text> (</xsl:text>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">inchapter</xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates select="$next/ancestor::d:chapter" mode="mp:title-content">
            <xsl:with-param name="allow-anchors" select="false()"/>
          </xsl:apply-templates>
          <xsl:text>)</xsl:text>
        </xsl:if>-->
      </a>
    </span>
  </xsl:if>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-permalink">
  <xsl:param name="node" select="."/>
  <xsl:if test="$generate.permalink != 0">
    <xsl:variable name="permalink">
      <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Permalink'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="component"
     select="if ($node/ancestor-or-self::*[@xml:id][1])
             then $node/ancestor-or-self::*[@xml:id][1]
             else ($node)"/>
    
      <div class="permalink">
        <a alt="{$permalink}" title="{$permalink}" 
          href="{f:href-target-uri($component)}">
          <xsl:copy-of select="$permalink.text"/>
        </a>
      </div>
  </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-keywords">
  <xsl:param name="node" select="."/>
  <xsl:variable name="keywords" select="$node/d:info/d:keywordset"/>
  
  <!--<xsl:message>sf:generate-keywords:
    node = <xsl:value-of select="local-name($node)"/>
    childname <xsl:value-of select="local-name($node/*[2])"/>
    keywordset = <xsl:value-of select="count($keywords/*)"/>
  </xsl:message>-->
  
  <xsl:if test="$generate.keywordlist != 0 and count($keywords/*) > 0">
    <div class="keywordset">
      <xsl:choose>
        <xsl:when test="count($keywords/*) = 1">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Keyword'"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Keywords'"/>
            </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>: </xsl:text>
      <xsl:for-each select="$keywords/*">
        <xsl:apply-templates/>
        <xsl:choose>
          <xsl:when test="position() = last()"/>
          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template match="d:section[not(parent::d:section)]/d:title|
                     d:section[not(parent::d:section)]/d:info/d:title" mode="m:titlepage-mode">
  <xsl:variable name="depth" select="min((count(ancestor::d:section), 4))"/>

  <xsl:variable name="context"
                select="if (parent::d:info) 
                        then parent::d:info/parent::* 
                        else parent::*"/>

  <xsl:element name="h{$depth + 2}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:if test="$generate.permalink != 0">
      <xsl:attribute name="class">navig</xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="$context" mode="m:object-title-markup">
      <xsl:with-param name="allow-anchors" select="true()"/>
    </xsl:apply-templates>
  </xsl:element>
  <xsl:call-template name="sf:generate-permalink"/>
  <xsl:call-template name="sf:generate-prevnext-sectionlinks">
    <xsl:with-param name="node" select="$context"/>
  </xsl:call-template>
  <xsl:call-template name="sf:generate-userlevel">
    <xsl:with-param name="level"
      select="(../@userlevel|../../@userlevel)[1]"/>
  </xsl:call-template>
  <xsl:call-template name="sf:generate-keywords">
    <xsl:with-param name="node" select="$context"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>