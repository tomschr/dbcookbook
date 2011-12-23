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
  
  <xsl:template match="@fileref">
    <xsl:choose>
      <xsl:when test="starts-with(., '/')">
        <!-- special case: if it's absolute w/o a scheme, leave it alone -->
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($img.src.path, .)"/>
        <!--
        <xsl:variable name="absuri" select="resolve-uri(.,base-uri(.))"/>
        <xsl:choose>
          <xsl:when test="starts-with($absuri, 'file://')">
            <xsl:value-of select="substring-after($absuri, 'file:/')"/>
          </xsl:when>
          <xsl:when test="starts-with($absuri, 'file:/')">
            <xsl:value-of select="substring-after($absuri, 'file:')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$absuri"/>
          </xsl:otherwise>
          </xsl:choose>
        -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>