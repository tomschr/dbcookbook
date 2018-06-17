<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY db "https://cdn.docbook.org/release/xsl/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="d">
  
  <xsl:import href="&db;/xhtml/docbook.xsl"/>
  <xsl:import href="simple-navigation.xsl"/>
  
  <xsl:param name="generate.simple.navigation" select="1"/>
  <xsl:param name="html.stylesheet">book.css</xsl:param>

  <xsl:template name="chapter.titlepage.before.recto">
    <xsl:if test="$generate.simple.navigation != 0">
      <xsl:call-template name="generate.simple.navigation"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>