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
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="d xlink tmpl m t f h l xs">
  
  <xsl:import href="../../../db-xslt2/xslt/base/html/docbook.xsl"/>  
  <!--<xsl:import href="http://docbook.github.com/release/latest/xslt/base/html/docbook.xsl"/>-->
  
  <xsl:include href="piwik.xsl"/>
  <xsl:include href="param.xsl"/>
  <xsl:include href="../common/l10n.xsl"/>
  <xsl:include href="inlines.xsl"/>
  <xsl:include href="titlepage-templates.xsl"/>
  <xsl:include href="titlepage-mode.xsl"/>
  <xsl:include href="section.xsl"/>
  <xsl:include href="html.xsl"/>
  <xsl:include href="formal.xsl"/>
  <xsl:include href="graphics.xsl"/>
  
  <xsl:include href="usermeta.xsl"/>
  <xsl:include href="collect-examples.xsl"/>

  <xsl:template match="/">
    <xsl:variable name="root" as="element()"
      select="f:docbook-root-element(f:preprocess(/),$rootid)"/>

    <xsl:if test="$verbosity &gt; 3">
      <xsl:message>Styling...</xsl:message>
    </xsl:if>

    <html>
      <xsl:call-template name="t:head">
        <xsl:with-param name="node" select="$root"/>
      </xsl:call-template>
      <body>
        <xsl:call-template name="t:body-attributes"/>
        <xsl:if test="$root/@status">
          <xsl:attribute name="class" select="$root/@status"/>
        </xsl:if>

        <xsl:apply-templates select="$root"/>
        
        <xsl:if test="xs:integer($use.piwik) != 0">
          <xsl:call-template name="generate.piwik"/>
        </xsl:if>
      </body>
    </html>

    <xsl:for-each select=".//d:mediaobject[d:textobject[not(d:phrase)]]">
      <xsl:call-template name="t:write-longdesc"/>
    </xsl:for-each>
    
    <xsl:if test="$use.downloadlink != 0">
      <xsl:call-template name="t:write-examples"/>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>