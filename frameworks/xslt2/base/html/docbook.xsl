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
  exclude-result-prefixes="d xlink tmpl m t f">
  
  <xsl:import href="../../../db-xslt2/xslt/base/html/docbook.xsl"/>
  
  <xsl:include href="param.xsl"/>
  <xsl:include href="inlines.xsl"/>
  <xsl:include href="usermeta.xsl"/>
  
  <xsl:template name="t:user-titlepage-templates" as="element(tmpl:templates-list)?">
    <tmpl:templates-list>
      <tmpl:templates name="book">
      <tmpl:recto>
        <h:div tmpl:class="titlepage">
          <d:title/>
          <d:subtitle/>
          <d:author/>
          <d:legalnotice/>
          <d:pubdate/>
          <d:revision/>
          <d:revhistory/>          
          <d:abstract/>
          <d:othercredit class="proofreader"/>
        </h:div>
        <h:hr tmpl:keep="true"/>
      </tmpl:recto>
      </tmpl:templates>
    </tmpl:templates-list>
  </xsl:template>
  
  <xsl:template match="d:othercredit" mode="m:titlepage-recto-mode"/>
  <xsl:template match="d:othercredit[@class='proofreader']" mode="m:titlepage-recto-mode">
    <div>
      <xsl:sequence select="f:html-attributes(.)"/>
      <p>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'revisedby'"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="d:orgname">
            <xsl:apply-templates select="d:orgname"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="d:personname"/>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </div>
  </xsl:template>
  

</xsl:stylesheet>