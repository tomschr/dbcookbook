<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  exclude-result-prefixes="d xlink tmpl m t">
  
  <xsl:import href="../../../db-xslt2/xslt/base/html/docbook.xsl"/>
  
  <!--<xsl:param name="resource.root">../../../db-xslt2/xslt/base/</xsl:param>-->
  <xsl:param name="docbook.css" select="'css/dbcookbook.css'"/>
  
  <xsl:param name="css.decoration" select="0"/>
  <xsl:param name="linenumbering.everyNth" select="2"/>
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="toc.max.depth">2</xsl:param>
  <xsl:param name="html.cleanup" select="1"/>
  <xsl:param name="html.longdesc" select="0"/>
  <xsl:param name="html.extra.head.links" select="1"/>
  <!--http://norman.walsh.name/2011/08/31/xsltPygments-->
  <!--<xsl:param name="highlight.source" select="1"/>-->
  <xsl:param name="make.clean.html" select="1"/>
  <xsl:param name="table.borders.with.css" select="0"/>
  <xsl:param name="section.autolabel.max.depth" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="use.extensions" select="1"/>
  
  
  <xsl:template name="t:user-titlepage-templates" as="element(tmpl:templates-list)?">
    <tmpl:templates-list>
      <tmpl:templates name="book">
      <tmpl:recto>
        <div tmpl:class="titlepage">
          <d:title/>
          <d:subtitle/>
          <d:author/>
          <d:legalnotice/>
          <d:pubdate/>
          <d:revision/>
          <d:revhistory/>
          <d:abstract/>
        </div>
        <hr tmpl:keep="true"/>
      </tmpl:recto>
      </tmpl:templates>
    </tmpl:templates-list>
  </xsl:template>
  
</xsl:stylesheet>