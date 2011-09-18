<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:template name="hyphenate-url">
  <xsl:param name="url" select="''"/>

  <!-- Remove the "schema://" prefix, so it disturbs not the
       algorithm in "hyphenate-url-string" -->
  <xsl:choose>
   <xsl:when test="$ulink.hyphenate = ''">
      <xsl:value-of select="$url"/>
   </xsl:when>
   <xsl:when test="contains($url, '://')">
      <xsl:value-of select="substring-before($url, '://')"/>
      <xsl:text>://</xsl:text>
      <xsl:copy-of select="$ulink.hyphenate"/>
      <xsl:call-template name="hyphenate-url-string">
        <xsl:with-param name="url" select="substring-after($url, '://')"/>
      </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
      <xsl:call-template name="hyphenate-url-string">
        <xsl:with-param name="url" select="normalize-space($url)"/>
      </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="hyphenate-url-string">
  <xsl:param name="url" select="''"/>
  <xsl:variable name="char" select="substring($url, 1,1)"/>

  <xsl:choose>
   <xsl:when test="$url=''"/>
   <!-- Insert breakpoint _before_ the character -->
   <xsl:when test="contains($ulink.hyphenate.before.chars, $char)">
     <xsl:value-of select="concat($ulink.hyphenate, $char)"/>
     <xsl:call-template name="hyphenate-url-string">
       <xsl:with-param name="url" select="substring($url, 2)"/>
     </xsl:call-template>
   </xsl:when>
   <!-- Insert breakpoint _after_ the character -->
   <xsl:when test="contains($ulink.hyphenate.after.chars, $char)">
     <xsl:value-of select="concat($char, $ulink.hyphenate)"/>
     <xsl:call-template name="hyphenate-url-string">
       <xsl:with-param name="url" select="substring($url, 2)"/>
     </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
     <xsl:value-of select="$char"/>
     <xsl:call-template name="hyphenate-url-string">
       <xsl:with-param name="url" select="substring($url, 2)"/>
     </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>
</xsl:stylesheet>