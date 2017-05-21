<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">
  
  
  <xsl:template name="create.xlink">
    <xsl:param name="content"/>
    <xsl:param name="node" select="."/>
    <xsl:param name="linkend" select="$node/@linkend"/>
    <xsl:param name="xhref" select="$node/@xlink:href"/>
    
    <xsl:choose>
      <xsl:when test="$node/@xlink:type='simple'">
        <xsl:call-template name="simple.xlink">
          <xsl:with-param name="content" select="$content"/>
          <xsl:with-param name="linkend" select="$linkend"/>
          <xsl:with-param name="xhref" select="$xhref"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$node/@xlink:type='extended'">
        <xsl:call-template name="extended.xlink">
          <xsl:with-param name="content" select="$content"/>
          <xsl:with-param name="linkend" select="$linkend"/>
          <xsl:with-param name="xhref" select="$xhref"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="simple.xlink">
          <xsl:with-param name="content" select="$content"/>
          <xsl:with-param name="linkend" select="$linkend"/>
          <xsl:with-param name="xhref" select="$xhref"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
   
  <xsl:template match="phrase[@xlink:type='extended']|
                       d:phrase[@xlink:type='extended']">
    <xsl:message>Extended XLink discovered!</xsl:message>
    <span>
      <xsl:call-template name="id.attribute"/>
      <xsl:call-template name="locale.html.attributes"/>
      <!-- We don't want empty @class values, so do not propagate empty @roles -->
      <xsl:choose>
        <xsl:when test="@role and 
                        normalize-space(@role) != '' and 
                        $phrase.propagates.style != 0">
          <xsl:apply-templates select="." mode="class.attribute">
            <xsl:with-param name="class" select="@role"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="class.attribute"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="dir"/>
      <xsl:call-template name="anchor"/>
      <xsl:call-template name="extended.xlink">
        <xsl:with-param name="content">
          <xsl:apply-templates/>
        </xsl:with-param>
      </xsl:call-template>
      <!--<xsl:call-template name="extended.xlink"/>-->
      <xsl:call-template name="apply-annotations"/>
    </span>
  </xsl:template>
 
 
</xsl:stylesheet>