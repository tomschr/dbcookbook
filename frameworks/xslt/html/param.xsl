<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <!--<xsl:param name="css.decoration" select="0"/>-->
  <xsl:param name="base.dir">build/html/</xsl:param>
  <xsl:param name="custom.css.source">dbcookbook.css.xml</xsl:param>
  <xsl:param name="css.decoration" select="0"/>
  <xsl:param name="img.src.path">images/</xsl:param>
  <xsl:param name="html.cleanup" select="1"/>
  <xsl:param name="html.longdesc" select="0"/>
  <xsl:param name="html.extra.head.links" select="1"/>

  <xsl:param name="highlight.source" select="1"/>
  <!--<xsl:param name="highlight.xslthl.config"/>-->
  <xsl:param name="generate.id.attributes" select="1"/>
  
  <xsl:param name="linenumbering.everyNth" select="1"/>
  <xsl:param name="make.clean.html" select="1"/>
  <xsl:param name="table.borders.with.css" select="0"/>

  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="toc.max.depth">2</xsl:param>
  <xsl:param name="ulink.target" select="0"/>
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="use.extensions" select="1"/>
  <xsl:param name="use.viewport" select="0"/>
  
  <!-- ================================================== -->
  <xsl:param name="next.navigation">
    <span> › </span>
  </xsl:param>
  <xsl:param name="prev.navigation">
    <span> ‹ </span>
  </xsl:param>
  
</xsl:stylesheet>
