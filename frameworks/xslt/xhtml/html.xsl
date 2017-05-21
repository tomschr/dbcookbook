<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">
  
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