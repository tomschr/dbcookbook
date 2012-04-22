<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:de="urn:x-toms:docbook-ext"
  exclude-result-prefixes="d xlink de f">

<xsl:param name="base.example.dir">examples/</xsl:param>

<xsl:template name="f:download-link">
  <xsl:param name="node" />
  
  <!-- We check for blockinfo AND info, just to be sure 
  -->
  <xsl:variable name="fn"
      select="($node/blockinfo/de:output/de:filename|
               $node/info/de:output/de:filename)[1]"/>
  <xsl:variable name="downloadlink">
      <xsl:if test="$fn">
        <xsl:value-of select="concat($base.example.dir, $fn)"/>
      </xsl:if>
  </xsl:variable>
  <!--<xsl:message>f:downloadlink:
    node = <xsl:value-of select="local-name($node)"/>
    info = <xsl:value-of select="boolean($node/blockinfo)"/>
    filename = <xsl:value-of select="boolean($node/info/de:output/de:filename)"/>
    fn   = "<xsl:value-of select="$fn"/>"
    dl   = "<xsl:value-of select="$downloadlink"/>"
  </xsl:message>-->
  <xsl:value-of select="$downloadlink"/>
</xsl:template>

<xsl:template name="f:create-downloadlink">
  <xsl:param name="node" select="."/>
  <xsl:variable name="dl">
    <xsl:call-template name="f:download-link">
      <xsl:with-param name="node" select="$node"/>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:if test="$use.downloadlink != 0 and $dl != ''">
    <xsl:variable name="html.class" select="local-name($node)"/>
    <!--<xsl:message>f:create-downloadlink:
      node = <xsl:value-of select="local-name($node)"/>
      html.class = <xsl:value-of select="$html.class"/>
      dl   = "<xsl:value-of select="$dl"/>"
    </xsl:message>-->
    
    <div class="{$html.class}-download-link">
      <a href="{$dl}">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Download'"/>
        </xsl:call-template>
      </a>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="formal.object.heading">
  <xsl:param name="object" select="."/>
  <xsl:param name="title">
    <xsl:apply-templates select="$object" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:param>
  
  <xsl:choose>
    <xsl:when test="$object/self::example">
      <xsl:variable name="html.class" select="local-name($object)"/>
      <div class="{$html.class}-title">
        <xsl:copy-of select="$title"/>
      </div>
      <xsl:call-template name="f:create-downloadlink">
        <xsl:with-param name="node" select="$object"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="html.class" select="concat(local-name($object),'-title')"/>
      <div class="{$html.class}">
        <xsl:copy-of select="$title"/>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="informalexample">
  <xsl:param name="class">
    <xsl:apply-templates select="." mode="class.value"/>
  </xsl:param>

  <xsl:variable name="content">
    <div class="{$class}">
      <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="f:create-downloadlink">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      <xsl:apply-templates/>
  
      <!-- HACK: This doesn't belong inside formal.object; it 
           should be done by the table template, but I want 
           the link to be inside the DIV, so... -->
      <xsl:if test="local-name(.) = 'informaltable'">
        <xsl:call-template name="table.longdesc"/>
      </xsl:if>
  
      <xsl:if test="$spacing.paras != 0"><p/></xsl:if>
    </div>
  </xsl:variable>

  <xsl:variable name="floatstyle">
    <xsl:call-template name="floatstyle"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$floatstyle != ''">
      <xsl:call-template name="floater">
        <xsl:with-param name="class"><xsl:value-of select="$class"/>-float</xsl:with-param>
        <xsl:with-param name="floatstyle" select="$floatstyle"/>
        <xsl:with-param name="content" select="$content"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$content"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>