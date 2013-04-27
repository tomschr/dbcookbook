<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % common.ent SYSTEM "../common/common.ent">
  %common.ent;
  <!ENTITY dbdir "../../db-xslt">
]>
<xsl:stylesheet version="1.0" 
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="&dbdir;/epub/docbook.xsl"/>
  
  <xsl:param name="use.id.as.filename" select="1"/>
  <xsl:param name="img.src.path">img/</xsl:param>
  <xsl:param name="callout.graphics" select="0"/>
  <xsl:param name="callout.unicode" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="section.autolabel.max.depth">1</xsl:param>
  
  <xsl:param name="toc.section.depth">1</xsl:param>
  
</xsl:stylesheet>