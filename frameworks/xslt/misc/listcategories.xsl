<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>
  
  <xsl:variable name="allsubjectterms" select="//d:subjectterm"/>
  <xsl:key name="terms" match="d:subjectterm" use="."/>
  
  <xsl:template match="text()"/>
  
  <xsl:template match="/">
    <xsl:for-each select="$allsubjectterms[generate-id(.) = 
                                             generate-id(key('terms', self::d:subjectterm))]">
      <xsl:sort select="."/>
      <xsl:value-of select="concat(., ' ',
        count($allsubjectterms[.=current()]), ': ')"/>
      <xsl:for-each select="$allsubjectterms[.=current()]">
        <xsl:value-of select="ancestor::d:section[@remap='topic']/@xml:id"/>
        <xsl:if test="position() &lt; last()">, </xsl:if>
      </xsl:for-each>
      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>