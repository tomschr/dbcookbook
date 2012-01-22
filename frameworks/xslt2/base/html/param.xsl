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
 

  <xsl:param name="base.dir">build/html/</xsl:param>
 
  <xsl:param name="resource.root" select="''"/>
  <xsl:param name="docbook.css" select="'css/dbcookbook.css'"/>
  <xsl:param name="draft.watermark.image" 
    select="concat($resource.root, 'images/draft.svg')"/>

  <xsl:param name="local.l10n.xml" select="document('../common/l10n/l10n.xml')"/>
  
  <xsl:param name="css.decoration" select="0"/>
  <xsl:param name="linenumbering.everyNth" select="2"/>
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="toc.max.depth">2</xsl:param>
  <xsl:param name="generate.user.meta" select="1"/>
  
  <xsl:param name="img.src.path">images/</xsl:param>
  
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
  <xsl:param name="use.id.as.filename" select="1"/>
  
  <!-- Use Piwik code: -->
  <xsl:param name="use.piwik" select="1"/>
  
  <xsl:param name="verbosity" select="4"/>
  <xsl:param name="menuchoice.menu.separator"> &#8594; </xsl:param>
  <xsl:param name="menuchoice.separator">+</xsl:param>
  <xsl:param name="glossentry.show.acronym">yes</xsl:param>
  <xsl:param name="preprocess" select="'transclude'"/>
  
  <xsl:param name="ticket.url">https://sourceforge.net/p/doccookbook/tickets/</xsl:param>
  
  <xsl:param name="generate.userlevel" select="1"/>
  <xsl:param name="generate.prevnext.sectionlinks" select="1"/>  
  <xsl:param name="userlevel.easy"  >★☆☆</xsl:param><!-- ⚑⚐⚐ -->
  <xsl:param name="userlevel.medium">★★☆</xsl:param><!-- ⚑⚑⚐ -->
  <xsl:param name="userlevel.hard"  >★★★</xsl:param><!-- ⚑⚑⚑ -->
  
</xsl:stylesheet>
