<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY db "https://cdn.docbook.org/release/xsl/current">
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="&db;/fo/docbook.xsl"/>
  
  <xsl:param name="drop.caps.spanning.lines" select="2"/>
  <xsl:param name="line-height">1.55</xsl:param>
  <xsl:param name="drop.caps.font-family" select="$body.font.family"/>
  <xsl:param name="drop.caps.font-weight">bold</xsl:param>
  
  <xsl:attribute-set name="drop.caps.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-size">20pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="d:article/d:section/d:para[1]">
    <xsl:variable name="keep.together">
      <xsl:call-template name="pi.dbfo_keep-together"/>
    </xsl:variable>
    <!-- We need a decimal value -->
    <xsl:variable name="interleave.space">
    <xsl:choose>
      <xsl:when test="$line-height = 'normal'">1.75</xsl:when>
      <xsl:when test="$line-height > 0">
        <xsl:value-of select="$line-height"/>
      </xsl:when>
      <!-- TODO: Convert other units into pt: -->
      <xsl:otherwise>
        <xsl:value-of select="substring-before($line-height, 'pt') div
                              $body.font.master "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
    <xsl:variable name="initial"
      select="substring(normalize-space(.),1,1)"/>
    <xsl:variable name="initial-font-size" 
      select="85"/>
    <xsl:variable name="initial-line-height" 
      select="56.8"/>
    
    <xsl:message>Initial: <xsl:value-of select="$initial"
      />
      Initial font-size:   <xsl:value-of select="$initial-font-size"/>
      Initial line-height: <xsl:value-of select="$initial-line-height"/>
    </xsl:message>
    
    <fo:block xsl:use-attribute-sets="normal.para.spacing"
      border-top="1pt dotted gray"
      border-left="1pt dotted gray">
      <xsl:if test="$keep.together != ''">
        <xsl:attribute name="keep-together.within-column">
          <xsl:value-of select="$keep.together"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="anchor"/>
      <fo:float float="start" margin-top="0pt" padding-top="0pt"
        line-stacking-strategy="line-height"
        line-height.conditionality="discard"
        intrusion-displace="line">
        <fo:block text-depth="0pt" margin-top="0pt" padding-top="0pt"
          border=".5pt dotted blue" line-stacking-strategy="line-height"
          line-height.conditionality="discard"
        color="red" 
        line-height="{$initial-line-height}pt" 
        font-size="{$initial-font-size}pt"
        font-weight="{$drop.caps.font-weight}"
        font-family="{$drop.caps.font-family}">
          <xsl:copy-of select="$initial"/>
        </fo:block>
      </fo:float>
      <fo:inline>
        <xsl:value-of select="substring(normalize-space(.), 2)"/>
      </fo:inline>
      <xsl:apply-templates select="*"/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>