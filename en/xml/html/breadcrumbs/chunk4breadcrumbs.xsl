<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="https://cdn.docbook.org/release/xsl/current/xhtml/chunk.xsl"/>
  
  <xsl:include href="breadcrumbs2.xsl"/>
  
  <xsl:template name="user.header.content">
    <xsl:call-template name="generate.breadcrumbs"/>
  </xsl:template>
</xsl:stylesheet>