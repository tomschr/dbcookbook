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
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f l">

  <xsl:template name="t:user-head-content">
    <xsl:param name="node" select="."/>
    <xsl:if test="$generate.user.meta != 0">
      <xsl:call-template name="t:user-meta-author">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
      <xsl:call-template name="t:user-meta-dublincore">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:if>  
  </xsl:template>
  

  <xsl:template name="t:user-meta-author">
    <xsl:param name="node" select="."/>
    <xsl:variable name="author">
      <xsl:call-template name="t:person-name-first-last">
        <xsl:with-param name="node" select="$node/d:info/d:author/d:personname"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$author != ''">
      <meta name="author" content="{$author}"/>
    </xsl:if>
  </xsl:template>  

  <xsl:template name="t:user-meta-dublincore">
    <xsl:param name="node" select="."/>

    <meta name="DC.format" content="text/html" scheme="DCTERMS.IMT"/>
    <meta name="DC.type" content="Text" scheme="DCTERMS.DCMIType"/>
    <meta name="DC.Language" content="{/*/@xml:lang}" scheme="DCTERMS.RFC3066"/>
    <meta name="DC.title" content="{f:title($node)}"/>

    <meta name="DC.creator">
      <xsl:attribute name="content">
        <xsl:call-template name="t:person-name-first-last">
          <xsl:with-param name="node"
          select="$node/d:info/d:author/d:personname"/>
        </xsl:call-template>
      </xsl:attribute>
    </meta>
    
    <xsl:if test="$node/d:info/d:subjectset">
      <meta name="DC.subject"
        content="{string-join($node/d:info/d:subjectset/d:subject/d:subjectterm,
        ', ')}"/>
    </xsl:if>
    <xsl:if test="$node/d:info/d:abstract">
      <meta name="DC.description" 
        content="{string-join(normalize-space($node/d:info/d:abstract[1]/*),
        ' ')}"/>
    </xsl:if>
    <xsl:if test="$node/d:info/d:publishername or
                  $node/d:info/d:publisher">
      <meta name="DC.publisher">
        <xsl:attribute name="content">
          <xsl:for-each select="($node/d:info/d:publishername |
                                 $node/d:info/d:publisher/d:publishername)[1]/*">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    <!--<meta name="DC.contributor" content=""/>-->
    <!--<meta name="DC.date" scheme="DCTERMS.W3CDTF">
      <xsl:variable name="date" select="date:date-time()"/>
      <xsl:attribute name="content">
        <!-\-content="2011-09-18T01:49:37+02:00"-\->
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="format">Y-m-d</xsl:with-param>
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
        <xsl:text>T</xsl:text>
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="format">X</xsl:with-param>
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
      </xsl:attribute>
    </meta>-->
    <meta name="DC.type" content="Text" scheme="DCTERMS.DCMIType"/>
    <xsl:if test="$node/d:info/d:biblioid">
      <xsl:for-each select="$node/d:info/d:biblioid">
        <meta name="DC.identifier" scheme="DCTERMS.URI">
          <xsl:attribute name="content">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:attribute>
        </meta>
      </xsl:for-each>
    </xsl:if>
    
    <!--<meta name="DC.source"
      content="http://www.w3.org/TR/html401/struct/global.html#h-7.4.4"
      scheme="DCTERMS.URI"/>--> 
    <meta name="DC.relation" content="http://dublincore.org/"
      scheme="DCTERMS.URI"/>
    <meta name="DC.coverage" content="" scheme="DCTERMS.TGN"/><!-- FIXME -->
    <meta name="DC.rights" content="legalnotice"  scheme="DCTERMS.URI"/>
  </xsl:template>
  
  
</xsl:stylesheet>