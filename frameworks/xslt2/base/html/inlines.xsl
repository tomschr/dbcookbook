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
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l">  
  
  <xsl:template match="d:guibutton">
    <xsl:call-template name="t:inline-charseq"/>
  </xsl:template>
  <xsl:template match="d:guiicon">
    <xsl:call-template name="t:inline-charseq"/>
  </xsl:template>
  <xsl:template match="d:guilabel">
    <xsl:call-template name="t:inline-charseq"/>
  </xsl:template>
  <xsl:template match="d:guimenu">
    <xsl:call-template name="t:inline-charseq"/>
  </xsl:template>
  <xsl:template match="d:guimenuitem">
    <xsl:call-template name="t:inline-charseq"/>
  </xsl:template>
  
  <xsl:template match="d:menuchoice">
    <xsl:variable name="shortcut" select="./d:shortcut"/>
    <xsl:call-template name="process.menuchoice"/>
    <xsl:if test="$shortcut">
      <xsl:text> (</xsl:text>
      <xsl:apply-templates select="$shortcut"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template name="process.menuchoice">
    <xsl:param name="nodelist"
      select="d:guibutton|d:guiicon|d:guilabel|d:guimenu|d:guimenuitem|d:guisubmenu|d:interface"/><!--
        not(shortcut) -->
    <xsl:param name="count" select="1"/>
    
    <xsl:choose>
      <xsl:when test="$count>count($nodelist)"></xsl:when>
      <xsl:when test="$count=1">
        <xsl:apply-templates select="$nodelist[$count=position()]"/>
        <xsl:call-template name="process.menuchoice">
          <xsl:with-param name="nodelist" select="$nodelist"/>
          <xsl:with-param name="count" select="$count+1"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="node" select="$nodelist[$count=position()]"/>
        <xsl:choose>
          <xsl:when test="local-name($node)='guimenuitem'
            or local-name($node)='guisubmenu'">
            <xsl:value-of select="$menuchoice.menu.separator"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$menuchoice.separator"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="$node"/>
        <xsl:call-template name="process.menuchoice">
          <xsl:with-param name="nodelist" select="$nodelist"/>
          <xsl:with-param name="count" select="$count+1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:quote">
    <xsl:param name="class" select="()"/>
    <span>
      <xsl:sequence select="f:html-attributes(., @xml:id, local-name(.), ($class,@role))"/>
      <xsl:call-template name="gentext-startquote"/>
      <xsl:call-template name="t:xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="gentext-endquote"/>
    </span>
  </xsl:template>
</xsl:stylesheet>