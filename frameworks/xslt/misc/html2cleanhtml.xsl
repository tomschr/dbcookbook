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
      <xsl:when test=". = 'xref'"/>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Remove obsolete elements and attributes -->
  <xsl:template match="h:div/@title"/>
  <xsl:template match="h:a/@title"/>
  <xsl:template match="h:blockquote/@title"/>
  
  <!-- Remove empty anchors -->
  <xsl:template match="h:a[. = '']"/>
  
  <!-- ================================================ -->
  <xsl:template name="create-class-titlepage">
    <xsl:param name="class" select="@class"/>
    <xsl:param name="create-content" select="false()"/>
    <div>
      <xsl:apply-templates select="@*"/>
      <div class="{$class}-titlepage">
        <xsl:apply-templates select="h:div[@class='titlepage']"/>        
      </div>
      <xsl:choose>
        <xsl:when test="$create-content">
          <div class="{$class}-content">
            <xsl:apply-templates select="*[not(self::h:div[@class='titlepage'])]"/>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*[not(self::h:div[@class='titlepage'])]"/>    
        </xsl:otherwise>
      </xsl:choose>
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
  
  <xsl:template match="h:div[@class='blockquote-title']">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>
  <xsl:template match="h:div[@class='sidebar-title']">
    <h3><xsl:apply-templates/></h3>
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
  <xsl:template match="h:div[@class='sidebar']">
    <xsl:call-template name="create-class-titlepage">
      <xsl:with-param name="create-content" select="true()"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="h:div[@class='titlepage']">
    <xsl:apply-templates/>
  </xsl:template>    
  <!-- TOCs -->
  <xsl:template match="h:div[@class='toc']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[@class='toc-title']">
    <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  <xsl:template match="h:div[@class='toc']/h:dl">
    <dl class="toc">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>
  <xsl:template match="h:div[starts-with(@class, 'list-of-')]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[starts-with(@class, 'list-of-')]/h:dl">
    <dl class="toc">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>  
  <xsl:template match="h:div[@class='toc-title']">
    <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  
  <!-- Block Structures -->
  <xsl:template match="h:div[@class='informaltable']">
    <div class="informaltable-wrapper"><!-- id=node-id() -->
      <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates/>
      </xsl:copy>
    </div>
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
  
  
  <!-- Links -->
  <xsl:template match="h:a[@class]">
    <xsl:copy>
      <xsl:apply-templates select="@*[local-name() != 'class']"/>
      <xsl:apply-templates/>  
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>