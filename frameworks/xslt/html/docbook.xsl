<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY db "http://docbook.sourceforge.net/release/xsl-ns/current/xhtml">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">

  <xsl:import href="&db;/docbook.xsl"/>
  <xsl:import href="&db;/highlight.xsl"/>
  
  <xsl:include href="param.xsl"/>
  <xsl:include href="../common/common.xsl"/>
  <xsl:include href="../common/labels.xsl"/>
  <xsl:include href="../common/titles.xsl"/>
  <xsl:include href="../common/subtitles.xsl"/>
  <xsl:include href="../common/gentext.xsl"/>
  <xsl:include href="autotoc.xsl"/>
  <xsl:include href="topic-titlepage.xsl"/>
  <xsl:include href="topic.xsl"/>
  
</xsl:stylesheet>
