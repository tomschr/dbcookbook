<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % common.ent SYSTEM "../common/common.ent">
  %common.ent;
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:de="urn:x-toms:docbook-ext"
  exclude-result-prefixes="d xlink de">
  
  <xsl:import href="&dburi;/xhtml/chunker.xsl"/>
  
  <xsl:param name="base.dir"/>
  <xsl:param name="base.example.dir">examples/</xsl:param>
  <xsl:param name="stylesheet.result.type" select="'xhtml'"/>
  <xsl:param name="chunk.quietly" select="1"/>
  <xsl:param name="verbosity" select="0"/>
  
  <xsl:variable name="direction.align.start">left</xsl:variable>
  <xsl:variable name="direction.align.end">left</xsl:variable>
  
  
  <xsl:template name="download-link">
    <xsl:param name="node" />
    <xsl:variable name="fn" select="$node/d:info/de:output/de:filename"/>
    
    <xsl:choose>
      <xsl:when test="$fn != ''">
        <xsl:value-of select="concat($base.dir, $base.example.dir, $fn)"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="write-examples">
    <xsl:param name="node" select="/"/>
    <xsl:param name="verbosity" select="0"/>
    <xsl:variable name="base" select="concat($base.dir, $base.example.dir)"/>
    <!-- We need two variables here as XSLT1 cannot combine this -->
    <xsl:variable name="examplenodes" 
      select="$node//d:example[d:info/de:output/de:filename]"/>
    <xsl:variable name="informalexamplenodes" 
      select="$node//d:informalexample[d:info/de:output/de:filename]"/>
    
    <xsl:for-each select="$examplenodes | $informalexamplenodes">
      <xsl:variable name="dl">
        <xsl:call-template name="download-link">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="substring-after($dl, $base) != ''">
        <xsl:call-template name="write.chunk">
          <xsl:with-param name="filename" select="$dl"/>
          <xsl:with-param name="method">text</xsl:with-param>
          <xsl:with-param name="encoding">UTF-8</xsl:with-param>
          <xsl:with-param name="content">
            <xsl:value-of
              select="(current()/d:programlisting|
                       current()/d:programlistingco/d:programlisting)[1]"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  
  <xsl:template match="/">
    <xsl:call-template name="write-examples"/>
  </xsl:template>
  
</xsl:stylesheet>