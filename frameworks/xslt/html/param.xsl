<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  
  <xsl:attribute-set name="topic.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
  <xsl:attribute-set name="topic.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

  <!--<xsl:param name="css.decoration" select="0"/>-->
  <xsl:param name="base.dir">html/</xsl:param>
  <xsl:param name="custom.css.source">dbcookbook.css.xml</xsl:param>
  <!--<xsl:param name="generate.css.header" select="0"/>-->
  <xsl:param name="local.l10n.xml" select="document('../common/l10n.xml')"/>
  <xsl:param name="make.clean.html" select="1"/>
  <xsl:param name="toc.section.depth">1</xsl:param>
  <xsl:param name="toc.max.depth">2</xsl:param>
  
  <xsl:param name="topic.in.toc" select="0"/>
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="use.extensions" select="1"/>
  
  <xsl:param name="linenumbering.everyNth" select="1"/>
  
  <xsl:param name="highlight.source" select="1"/>
  <!--<xsl:param name="highlight.xslthl.config"/>-->
  
</xsl:stylesheet>