<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet 
[
 <!ENTITY db "https://cdn.docbook.org/release/xsl/current"> 
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="&db;/fo/docbook.xsl"/>
  <xsl:include href="initials-baseline.xsl"/>
  
  <xsl:template match="d:article/d:section/d:para[1]/text()">
    <xsl:call-template name="create.initial"/>
  </xsl:template>
</xsl:stylesheet>