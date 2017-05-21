<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l">
  
  <!--<xsl:include href="../../../xslt/html/piwik.xsl"/>-->
  
  <xsl:template name="t:user-footer-content">
    <xsl:param name="node" select="."/>
    <xsl:param name="next" select="()"/>
    <xsl:param name="prev" select="()"/>
    <xsl:param name="up" select="()"/>

    <!--<xsl:message xml:space="preserve">t:user-footer-content</xsl:message>
    <xsl:if test="$use.piwik != 0">
      <xsl:call-template name="generate.piwik"/>
      <xsl:message>... Integrated</xsl:message>
    </xsl:if>-->
  </xsl:template>
  
</xsl:stylesheet>