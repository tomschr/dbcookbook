<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:sf="http://doccookbook.sf.net/ns/"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink sf">
  
<xsl:template name="sf:generate-userlevel">
  <xsl:param name="level" select="normalize-space(@userlevel)"/>
      <xsl:variable name="ul">
        <xsl:choose>
          <xsl:when test="$level='hard' or $level='heavy'">hard</xsl:when>
          <xsl:otherwise><xsl:value-of select="$level"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
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
          <xsl:otherwise>
            <xsl:copy-of select="$userlevel.medium"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

  <xsl:if test="$level != '' and $generate.userlevel != 0">
    <div class="section-userlevel" title="{$ul}">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">Difficulty</xsl:with-param>
        </xsl:call-template>
        <xsl:value-of select="concat($d, ' (', $ul, ')')"/>
      </div>
    </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-permalink">
  <xsl:param name="node" select="."/>
  <xsl:param name="wrapper">div</xsl:param>
  
  <xsl:if test="$generate.permalink != 0">
    <xsl:variable name="permalink">
      <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Permalink'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="{$wrapper}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="class">permalink</xsl:attribute>
        <a alt="{$permalink}" title="{$permalink}">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object"  select="$node"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:copy-of select="$permalink.text"/>
        </a>
    </xsl:element>
  </xsl:if>
</xsl:template>

<xsl:template name="sf:generate-keywords">
  <xsl:param name="node" select="."/>
  <xsl:variable name="keywords" select="$node/*/keywordset|$node/d:info/d:keywordset"/>
  
  <!--<xsl:message>sf:generate-keywords:
    node = <xsl:value-of select="local-name($node)"/>
    child = <xsl:value-of select="local-name(*[1])"/>
    childname <xsl:value-of select="local-name($node/*[2])"/>
    keywordset = <xsl:value-of select="count($keywords)"/>
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

<xsl:template name="section.titlepage.before.verso">
  <!-- Only apply it on section inside a chapters -->
  <xsl:if test="parent::chapter or parent::d:chapter">
    <xsl:variable name="context"
                select="(parent::d:info|parent::d:info/parent::*|
                         parent::sectioninfo|parent::sectioninfo/parent::*
                        )[1]"/>

    <xsl:call-template name="sf:generate-userlevel">
      <xsl:with-param name="node" select="$context"/>
    </xsl:call-template>
    <xsl:call-template name="sf:generate-keywords"/>
  </xsl:if>
</xsl:template>


<xsl:template name="section.title">
  <xsl:variable name="section" select="(ancestor::section |
                                        ancestor::simplesect|
                                        ancestor::sect1|
                                        ancestor::sect2|
                                        ancestor::sect3| 
                                        ancestor::sect4| 
                                        ancestor::sect5 |
                                        
                                        ancestor::d:section |
                                        ancestor::d:simplesect|
                                        ancestor::d:sect1|
                                        ancestor::d:sect2|
                                        ancestor::d:sect3| 
                                        ancestor::d:sect4| 
                                        ancestor::d:sect5
                                       )[last()]"/>

  <xsl:variable name="renderas">
    <xsl:choose>
      <xsl:when test="$section/@renderas = 'sect1'">1</xsl:when>
      <xsl:when test="$section/@renderas = 'sect2'">2</xsl:when>
      <xsl:when test="$section/@renderas = 'sect3'">3</xsl:when>
      <xsl:when test="$section/@renderas = 'sect4'">4</xsl:when>
      <xsl:when test="$section/@renderas = 'sect5'">5</xsl:when>
      <xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="level">
    <xsl:choose>
      <xsl:when test="$renderas != ''">
        <xsl:value-of select="$renderas"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="section.level">
          <xsl:with-param name="node" select="$section"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:call-template name="section.heading">
    <xsl:with-param name="section" select="$section"/>
    <xsl:with-param name="level" select="$level"/>
    <xsl:with-param name="title">
      <xsl:apply-templates select="$section" mode="object.title.markup">
        <xsl:with-param name="allow-anchors" select="1"/>
      </xsl:apply-templates>
    </xsl:with-param>
  </xsl:call-template>
  <xsl:if test="$level = 1">
    <xsl:call-template name="sf:generate-permalink">
      <xsl:with-param name="node" select="$section"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
