<?xml version="1.0" encoding="UTF-8"?>
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
  
  <!-- 
    http://docbook.sourceforge.net/release/xsl/current/doc/html/
  -->
  <xsl:import href="docbook.xsl"/>
  <xsl:import href="&db;/chunk-common.xsl"/>
  <xsl:include href="&db;/chunk-code.xsl"/>

</xsl:stylesheet>