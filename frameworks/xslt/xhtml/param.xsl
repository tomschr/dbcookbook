<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <!--<xsl:param name="css.decoration" select="0"/>-->
  <!-- base.url and base.url.path are used for Dublin Core metadata: -->
  <xsl:param name="base.url">http://doccookbook.sourceforge.net</xsl:param>
  <xsl:param name="base.url.path">/html/en/</xsl:param>
  
  <xsl:param name="base.dir">build/tmp/</xsl:param>
  <!--<xsl:param name="chunk.tocs.and.lots" select="1"/>-->
  <xsl:param name="docbook.css.link" select="0"/>
  <xsl:param name="css.decoration" select="0"/>
  <xsl:param name="callout.graphics.path"
    select="concat($img.src.path,'png/callouts/')"/>

  <xsl:param name="inherit.keywords" select="1"/>

  <xsl:param name="html.cleanup" select="1"/>
  <xsl:param name="html.longdesc" select="0"/>
  <xsl:param name="html.extra.head.links" select="1"/>
  <xsl:param name="html.stylesheet"
    >highlighter/prettify.css css/dbcookbook.css</xsl:param>
  <xsl:param name="html.ext">.html</xsl:param>
  <xsl:param name="highlight.source" select="1"/>
  <!--<xsl:param name="highlight.xslthl.config"/>-->
  
  <xsl:param name="generate.breadcrumbs" select="0"/>
  <xsl:param name="generate.id.attributes" select="1"/>
  <xsl:param name="generate.legalnotice.link" select="1"/>
  <xsl:param name="generate.revhistory.link" select="1"/>
  <xsl:param name="generate.javascript" select="1"/>
  <xsl:param name="generate.keywordlist" select="1"/>
  <xsl:param name="generate.permalink" select="1"/>
  <xsl:param name="generate.section.navig" select="0"/>
  <xsl:param name="generate.userlevel" select="1"/>
  <xsl:param name="generate.user.meta" select="1"/>
  
  <xsl:param name="permalink.text">¶</xsl:param>
  <xsl:param name="userlevel.easy"  >★☆☆</xsl:param><!-- ⚑⚐⚐ -->
  <xsl:param name="userlevel.medium">★★☆</xsl:param><!-- ⚑⚑⚐ -->
  <xsl:param name="userlevel.hard"  >★★★</xsl:param><!-- ⚑⚑⚑ -->
  
  <xsl:param name="linenumbering.extension" select="0"/>
  <xsl:param name="linenumbering.everyNth" select="2"/>
  <xsl:param name="make.clean.html" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="section.autolabel.max.depth">1</xsl:param>
  
  <xsl:param name="table.borders.with.css" select="0"/>
  <xsl:param name="ticket.url">https://sf.net/p/doccookbook/tickets/</xsl:param>
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="toc.max.depth">2</xsl:param>
  <xsl:param name="ulink.target" select="0"/>

  <xsl:param name="use.downloadlink" select="1"/>
  <xsl:param name="use.extensions" select="1"/>
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="use.piwik" select="0"/>
  <xsl:param name="use.viewport" select="0"/>
  
  <xsl:param name="local.l10n.xml" select="document('../common/l10n.xml')"/>
 
  <!-- ================================================== -->
  <xsl:param name="up.navigation">
    <span> &#x2191; </span><!-- &#x25b5; -->
  </xsl:param>
  <xsl:param name="home.navigation">
    <span> &#x2302; </span><!-- &#x273b; -->
  </xsl:param>
  <xsl:param name="toc.navigation">
    <span> &#x2318; </span>
  </xsl:param>
  <xsl:param name="next.navigation">
    <span> › </span>
  </xsl:param>
  <xsl:param name="prev.navigation">
    <span> ‹ </span>
  </xsl:param>
  <xsl:param name="nextdiv.navigation">
    <span> » </span>
  </xsl:param>
  <xsl:param name="prevdiv.navigation">
    <span> « </span>
  </xsl:param>
  <xsl:param name="breadcrumbs.separator">
    <span> » </span>
  </xsl:param>
</xsl:stylesheet>
