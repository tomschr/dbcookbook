<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/xslt/ns/mode"
		xmlns:t="http://docbook.org/xslt/ns/template"
		xmlns:tp="http://docbook.org/xslt/ns/template/private"
                xmlns:u="http://nwalsh.com/xsl/unittests#"
                xmlns:xlink='http://www.w3.org/1999/xlink'
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="db doc f fn h m t tp u xlink xs">
  

  <xsl:template name="t:extended-xlink-create">
    <xsl:param name="node" select="."/>
    <xsl:param name="link" select="$node/@xlink:href"/>
    <xsl:param name="target"/>
    
    <xsl:message>t:extended-xlink-create: <xsl:value-of
      select="concat(local-name(), ':', $link)"/>, <xsl:value-of select="count(@xlink:*)"/></xsl:message>
    <span class="arc"><a href="{$link}" class="arc">
      <xsl:choose>
        <xsl:when test="$node[@xlink:type='title']">
          <xsl:message>Found $node[@xlink:type='title']</xsl:message>
          <xsl:apply-templates select="$node[@xlink:type='title'][1]"/>
        </xsl:when>
        <xsl:when test="$node/@xlink:title">
          <xsl:message>Found $node/@xlink:title</xsl:message>
          <xsl:value-of select="$node/@xlink:title"/>
        </xsl:when>
        <xsl:when test="count($target)=1">
            <xsl:call-template name="simple.xlink">
              <xsl:with-param name="node" select="$node"/>
              <xsl:with-param name="linkend" select="$link"/>
              <xsl:with-param name="content">
                <xsl:apply-templates/>
              </xsl:with-param>
              <!--<xsl:with-param name="a.target" select="$a.target"/>-->
              <xsl:with-param name="xhref" select="$node/@xlink:href"/>
            </xsl:call-template>
          <!--<xsl:call-template name="xref"/>-->
          <!--<xsl:apply-templates select="$target" mode="xref-to">
            <xsl:with-param name="referrer" select="."/>
          </xsl:apply-templates>-->
        </xsl:when>
        <xsl:when test="normalize-space($node) != ''">
          <xsl:value-of select="normalize-space($node)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>Warning: inline extended link locator without title</xsl:text>
          </xsl:message>
          <xsl:text>???</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </a></span>
  </xsl:template>
  
  <xsl:template name="extended.xlink">
    <xsl:param name="content"/>
    <xsl:param name="node" select="."/>
    <xsl:param name="xhref" select="$node/@xlink:href"/>
    <!--<xsl:variable name="idref">
      <xsl:call-template name="xpointer.idref">
        <xsl:with-param name="xpointer" select="$xhref"/>
      </xsl:call-template>      
    </xsl:variable>-->
    <xsl:variable name="resource" select="*[@xlink:type='resource']"/>
    <xsl:variable name="locator" select="*[@xlink:type='locator']"/>
    
    <xsl:choose>
      <xsl:when test="count($resource)=0">
        <xsl:message>
          <xsl:text>Warning: inline extended link with no resource</xsl:text>
        </xsl:message>
        <!--<xsl:apply-templates/>-->
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="count($resource) &gt; 1">
          <xsl:message>
            <xsl:text>Warning: inline extended Xlinks are expected to have exactly one resource</xsl:text>
          </xsl:message>
        </xsl:if>

        <span class="nhrefs">
          <span class="source">
            <xsl:apply-templates select="$resource[1]"/>
          </span>

          <xsl:variable name="arcs"
            select="*[@xlink:type='arc' and @xlink:from=$resource[1]/@xlink:label]"/>
          <xsl:variable name="to"
            select="*[@xlink:type='locator' and @xlink:label=$arcs/@xlink:to]"/>

          <xsl:message>extended.xlink: resource: <xsl:value-of
              select="count($resource)"/>; locator: <xsl:value-of
              select="count($locator)"/>; arcs: <xsl:value-of
              select="count($arcs)"/>; to: <xsl:value-of
              select="count($to)"/>
          </xsl:message>

          <xsl:if test="$to">
            <xsl:text> [</xsl:text>
            <xsl:for-each select="$to">
              <xsl:variable name="idref">
                <xsl:call-template name="xpointer.idref">
                  <xsl:with-param name="xpointer" select="@xlink:href"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:variable name="xlink.target" select="key('id', $idref)"/>

              <xsl:message> 
  idref: <xsl:value-of select="$idref"/> 
  xlink.target: <xsl:value-of select="count($xlink.target)"/>
              </xsl:message>
              <xsl:choose>
                <!-- If target couldn't be found, go to the next -->
                <xsl:when test="count($xlink.target)=0 and 
                                starts-with(@xlink:href, '#')">
                  <xsl:message>Warning: Skipping reference "<xsl:value-of
                      select="$idref"/>", not found in document</xsl:message>
                </xsl:when>

                <!-- Target is found  -->
                <xsl:when test="count($xlink.target)=1 and
                              starts-with(@xlink:href, '#')">
                  <xsl:if test="position() &gt; 1">, </xsl:if>
                  <xsl:call-template name="t:extended-xlink-create">
                    <xsl:with-param name="node" select="*"/>
                    <xsl:with-param name="link" select="$idref"/>
                    <xsl:with-param name="target" select="$xlink.target"/>
                  </xsl:call-template>
                </xsl:when>

                <!-- We deal with a normal link -->
                <xsl:otherwise>
                  <xsl:if test="position() &gt; 1">, </xsl:if>
                  <!--<xsl:call-template name="t:extended-xlink-create">
                    <xsl:with-param name="node" select="*"/>
                  </xsl:call-template>-->
                  <xsl:call-template name="simple.xlink">
                    <xsl:with-param name="content" select="$content"/>
                  </xsl:call-template>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            <xsl:text>]</xsl:text>
          </xsl:if>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>