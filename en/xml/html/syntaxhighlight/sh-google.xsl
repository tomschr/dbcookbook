<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY db "https://cdn.docbook.org/release/xsl/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="d">
  
  <xsl:import href="&db;/xhtml/docbook.xsl"/>
  
  <xsl:param name="html.stylesheet">styles/sunburst.css</xsl:param>
  
  <xsl:template name="user.footer.content">
    <xsl:param name="node" select="."/>
    <script src="highlighter/prettify.js"></script>
    <script>prettyPrint();</script>
  </xsl:template>
  
  <xsl:template match="d:programlisting[@language]" mode="class.value">
    <xsl:param name="class" select="local-name(.)"/>
    <xsl:variable name="lang" select="concat('lang-', @language, ' ')"/>
    <xsl:choose>
        <xsl:when test="@linenumbering = 'numbered'">
          <xsl:value-of select="concat('prettyprint ', $lang, 'linenums ', $class)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('prettyprint ', $lang, $class)"/>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>