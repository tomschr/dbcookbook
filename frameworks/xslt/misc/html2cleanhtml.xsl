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

  <xsl:import href="copy.xsl"/>  
  <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
  
  <!-- ================================================ -->
  <!-- Remove or otherwise leave out elements and attributes -->
  <xsl:template match="h:div">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="h:span[@class='emphasis']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="h:div/@xml:lang">
    <xsl:attribute name="lang">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="h:div[@class='blockquote-title']">
    <h3>
      <xsl:apply-templates/>
    </h3>
  </xsl:template>
  
  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test="starts-with(., 'sgmltag')">
        <xsl:attribute name="class">
          <xsl:text>tag-</xsl:text>
          <xsl:value-of select="substring-after(., 'sgmltag-')"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test=". = 'citetitle'"/>
      <xsl:when test=". = 'link'"/>
      <xsl:when test=". = 'listitem'"/>
      <xsl:when test=". = 'title'"/>
      <xsl:when test=". = 'subtitle'"/>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Remove obsolete elements and attributes -->
  <xsl:template match="h:div/@title"/>
  <xsl:template match="h:blockquote/@title"/>
  
  <!-- Remove empty anchors -->
  <xsl:template match="h:a[. = '']"/>
  
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
  
  <xsl:template name="create-personname">
    <xsl:param name="class" select="@class"/>
    <div class="{$class}">
      <h3>
        <span class="personname">
          <xsl:apply-templates select="h:h3/*"/>
        </span>
      </h3>
    </div>
  </xsl:template>  
  
  
  <!-- Main structures -->
  <xsl:template match="h:div[@class='appendix']">
    <xsl:call-template name="create-class-titlepage"/>
  </xsl:template>
  <xsl:template match="h:div[@class='book']">
    <xsl:call-template name="create-class-titlepage"/>
  </xsl:template>
  <xsl:template match="h:div[@class='chapter']">
    <xsl:call-template name="create-class-titlepage"/>
  </xsl:template>
  <xsl:template match="h:div[@class='preface']">
    <xsl:call-template name="create-class-titlepage"/>
  </xsl:template>
  <xsl:template match="h:div[@class='section']">
    <xsl:call-template name="create-class-titlepage"/>
  </xsl:template>
  <xsl:template match="h:div[@class='titlepage']">
    <xsl:apply-templates/>
  </xsl:template>    
  
  <!-- Authors and other -->
  <xsl:template match="h:div[@class='author']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  <xsl:template match="h:div[@class='editor']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  <xsl:template match="h:div[@class='othercredit']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  
  <!-- TOCs -->
  <xsl:template match="h:div[@class='toc-title']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='list-of-tables']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='list-of-figures']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='list-of-examples']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='list-of-procedures']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='list-of-equations']">
     <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  
  <!-- Links that need to be copied -->
  <xsl:template match="h:dt/h:span[@class]/h:a |
                       h:dt/h:a |
                       h:a[@class]">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="h:a[@class]">
    <xsl:copy>
      <xsl:copy-of select="@*[local-name() != 'class']"/>
      <xsl:apply-templates/>  
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>