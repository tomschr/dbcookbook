<!DOCTYPE xsl:stylesheet 
[
 <!ENTITY dbns     "http://docbook.org/ns/docbook">
 <!ENTITY xsltns   "http://www.w3.org/1999/XSL/Transform">
 <!ENTITY svgns    "http://www.w3.org/2000/svg">
 <!ENTITY xins     "http://www.w3.org/2001/XInclude">
 <!ENTITY xlinkns  "http://www.w3.org/1999/xlink">
 <!ENTITY nbsp     "&#x00A0;">
]>

<xsl:stylesheet version="1.0"
  xmlns:d="&dbns;"
  xmlns="&dbns;"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:param name="preferred">pref</xsl:param>

<xsl:variable name="db5.ns">&dbns;</xsl:variable>
<xsl:variable name="xlink.ns">&xlinkns;</xsl:variable>

<xsl:template name="check.index">
  <xsl:param name="node" select="."/>
  <xsl:param name="default" select="1"/>
    
    <xsl:choose>
      <xsl:when test="$node/@condition = 'noindex'">0</xsl:when>
      <xsl:when test="$node/@condition = 'index'">1</xsl:when>    
      <xsl:otherwise><xsl:value-of select="$default"/></xsl:otherwise>
    </xsl:choose>  
</xsl:template>

<xsl:template match="d:footnote|d:title|d:indexterm" mode="profile">
  <!-- Indexterms doesn't/shouldn't occur in the descendants of
       these elements so just copy it -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="d:envar" mode="profile">
    <xsl:variable name="do.index">
      <xsl:call-template name="check.index"/>
    </xsl:variable>

    <!-- Copy original element -->
    <xsl:copy-of select="."/>
  
    <xsl:if test="$do.index != 0">
      <!--<xsl:message> <xsl:value-of
        select="concat(name(.), '=', .)"/></xsl:message>-->
      <indexterm>
        <xsl:if test="contains(@conformance, $preferred)">
           <xsl:attribute name="significance">preferred</xsl:attribute>
        </xsl:if>
        <primary>Umgebungsvariablen</primary>
        <secondary>
          <xsl:value-of select="."/>
        </secondary>
      </indexterm>
    </xsl:if>
</xsl:template>  

</xsl:stylesheet>