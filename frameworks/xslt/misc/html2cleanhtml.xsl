<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   Purpose:
     Stylesheet to cleaned up XHTML
     This may be convenient to only maintain _one_ CSS file which can
     be applied for both XSLT 1.0 and XSLT 2.0 produced XHTML output.   
   
   Input:
     XHTML code created by the XSLT 1.0 DocBook stylesheets
   Output:
     XHTML code which (should) be identical as it would be created by
     the XSLT 2.0 stylesheets
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="exsl h">
  
  <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
  
  <!-- ================================================ -->
  <!-- Identity templates -->
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
 
  <!-- ================================================ -->
  <!-- Remove or otherwise leave out elements and attributes -->
  <xsl:template match="h:div">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="h:div/@xml:lang">
    <xsl:attribute name="lang">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="h:div/@title"/>
  
  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test=". = 'title'"/>
      <xsl:when test=". = 'subtitle'"/>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="h:a"/>
  
  <!-- ================================================ -->
  <xsl:template name="create-class-titlepage">
    <xsl:param name="class" select="@class"/>
    <div>
      <xsl:apply-templates select="@*"/>
      <div class="{$class}-titlepage">
        <xsl:apply-templates select="h:div[@class='titlepage']"/>        
      </div>
      <xsl:apply-templates select="h:div[@class !='titlepage']"/>
    </div>
  </xsl:template>
  
  <xsl:template match="h:div[@class]">
    <xsl:choose>
      <xsl:when test="@class = 'book'">
        <xsl:call-template name="create-class-titlepage"/>
      </xsl:when>
      <xsl:when test="@class = 'preface'">
        <xsl:call-template name="create-class-titlepage"/>
      </xsl:when>
      <xsl:when test="@class = 'chapter'">
        <xsl:call-template name="create-class-titlepage"/>
      </xsl:when>
      <xsl:when test="@class = 'titlepage'">
        <xsl:apply-templates/>  
      </xsl:when>
      <xsl:otherwise>
        <div class="{@class}">
          <xsl:apply-templates/>  
        </div>        
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
  
  <xsl:template match="h:div[
                       @class='author' or
                       @class='editor' or 
                       @class='othercredit']">
    <div class="{@class}">
      <h3>
        <span class="personname">
          <xsl:apply-templates select="h:h3/*"/>
        </span>
      </h3>
    </div>
  </xsl:template>
  
</xsl:stylesheet>