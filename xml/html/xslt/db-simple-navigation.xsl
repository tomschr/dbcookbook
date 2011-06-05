<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY db "http://docbook.sourceforge.net/release/xsl-ns/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  
  <xsl:import href="&db;/xhtml/docbook.xsl"/>
  <xsl:import href="simple-navigation.xsl"/>
  
  <xsl:param name="generate.simple.chapter.navigation" select="1"/>
  <xsl:param name="html.stylesheet">book.css</xsl:param>

  <xsl:template match="chapter.titlepage.before.recto">
    <xsl:if test="$generate.simple.chapter.navigation != 0">
      <xsl:call-template name="generate.simple.navigation"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>