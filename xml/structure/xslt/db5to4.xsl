<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="d xi xlink exsl">

  <xsl:import href="copy.xsl"/>
  
  <xsl:output method="xml" indent="yes" 
    doctype-public="-//OASIS//DTD DocBook XML V4.5//EN"
    doctype-system="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space 
    elements="d:screen d:programlisting d:literallayout xi:*"/>
  <xsl:variable name="inlines">application citetitle</xsl:variable>
  
  <!-- Overwrite standard template and create elements without 
       a namespace node
  -->
  <xsl:template match="d:*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>
    
  <xsl:template match="@xml:id|@xml:lang">
    <xsl:attribute name="{local-name()}">
      <xsl:apply-templates/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- Suppress the following attributes: -->
  <xsl:template match="@annotations|@version"/>
  <xsl:template match="@xlink:*"/>
  
  <xsl:template match="@xlink:href">
    <xsl:choose>
      <xsl:when test="contains($inlines, local-name(..))">
        <ulink url="{.}" remap="{local-name(..)}">
          <xsl:value-of select=".."/>
        </ulink>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>@xlink:href could not be processed!
  parent element: <xsl:value-of select="local-name(..)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:*[@xlink:href]">
    <xsl:choose>
      <xsl:when test="contains($inlines, local-name())">
        <ulink url="{@xlink:href}" remap="{local-name(.)}">
          <xsl:element name="{local-name()}">
            <xsl:apply-templates 
              select="@*[local-name() != 'href' and
                         namespace-uri() != 'http://www.w3.org/1999/xlink']
                      |node()"/>
          </xsl:element>
        </ulink>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{local-name()}">
          <xsl:apply-templates 
            select="@*[local-name() != 'href' and
                       namespace-uri() != 'http://www.w3.org/1999/xlink']
                    |node()"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:link/@xlink:href">
    <xsl:attribute name="url">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="d:link[@xlink:href]">
    <ulink>
      <xsl:apply-templates select="@*|node()"/>
    </ulink>
  </xsl:template>
  
  <xsl:template match="d:link[@linkend]">
    <link>
      <xsl:apply-templates select="@*|node()"/>
    </link>
  </xsl:template>
  
  <xsl:template match="d:info">
    <xsl:variable name="parent" select="local-name(..)"/>
    <xsl:variable name="rtf-node">
      <xsl:element name="{$parent}info">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="count(exsl:node-set($rtf-node)/*/*) > 0">
        <xsl:copy-of select="$rtf-node"/>
      </xsl:when>
      <xsl:otherwise><!-- Don't copy, it's empty --></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Renamed elements -->
  <xsl:template match="d:personblurb">
    <authorblurb>
      <xsl:apply-templates select="@*|node()"/>
    </authorblurb>
  </xsl:template>
  <xsl:template match="d:tag">
    <sgmltag>
      <xsl:apply-templates select="@*|node()"/>
    </sgmltag>
  </xsl:template>
  
  <!-- New DocBook v5.x and HTML elements, no mapping available -->
  <xsl:template match="d:acknowledgements|d:annotation|d:arc
                       |d:cover
                       |d:definitions
                       |d:extendedlink
                       |d:givenname
                       |d:locator
                       |d:org|d:tocdiv
                       |html:*">
    <xsl:message>Don't know how to transfer <xsl:value-of
      select="local-name()"/> into DocBook 4</xsl:message>
  </xsl:template>
  
</xsl:stylesheet>