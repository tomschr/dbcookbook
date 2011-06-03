<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<xsl:param name="preferred">pref</xsl:param>

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
      <indexterm>
        <primary><xsl:value-of select="."/></primary>
      </indexterm>
      <indexterm>
        <xsl:if test="contains(@conformance, $preferred)">
           <xsl:attribute name="significance">preferred</xsl:attribute>
        </xsl:if>
        <primary>environment variables</primary>
        <secondary><xsl:value-of select="."/></secondary>
      </indexterm>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>