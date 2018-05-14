<?xml version="1.0" encoding="UTF-8"?>
<!--
  Transforms DocBook 5.x elements into Dublin Core

  Uses mapping from table in 
  http://www.docbook.org/tdg5/publishers/5.1b3/en/html/ch02.html#ch-gsxml.3
  
  CAVEAT:
  It is NOT a one to one mapping!
-->

<xsl:stylesheet version="1.0"
  xmlns:dc="http://purl.org/dc/terms/"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import
    href="https://cdn.docbook.org/release/xsl/current/common/common.xsl"/>
  <xsl:import href="copy.xsl"/>
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="d:info">
    <d:info xmlns:dc="http://purl.org/dc/terms/">
      <xsl:if test="/*/@version">
        <dc:conformsTo><xsl:value-of select="/*/@version"/></dc:conformsTo>
      </xsl:if>
      <xsl:apply-templates/>
    </d:info>
  </xsl:template>
  
  <xsl:template match="d:info/d:title">
    <dc:title><xsl:apply-templates/></dc:title>
  </xsl:template>
  
  <xsl:template match="d:info/d:abstract"><!-- FIXME -->
    <dc:abstract><xsl:apply-templates/></dc:abstract>
  </xsl:template>
  <xsl:template match="d:info/d:abstract/d:para">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="d:info/d:author|d:info/d:editor">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="d:info/d:author/d:personname
                       |d:info/d:editor/d:personname
                       |d:info/d:othercredit 
                       |d:info/d:collab">
    <dc:contributor>
      <xsl:call-template name="person.name.first-last"/>
    </dc:contributor>
  </xsl:template>
  <xsl:template name="person.name.first-last">
    <xsl:param name="node" select="."/>
    <xsl:if test="$node//d:honorific">
      <xsl:apply-templates select="$node//d:honorific[1]"/>
      <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:if test="$node//d:firstname">
      <xsl:if test="$node//d:honorific">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates select="$node//d:firstname[1]"/>
    </xsl:if>
    <xsl:if test="$node//d:othername">
      <xsl:if test="$node//d:honorific or $node//d:firstname">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates select="$node//d:othername[1]"/>
    </xsl:if>
    <xsl:if test="$node//d:surname">
      <xsl:if test="$node//d:honorific or $node//d:firstname or  $node//d:othername">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates select="$node//d:surname[1]"/>
    </xsl:if>
    <xsl:if test="$node//d:lineage">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="$node//d:lineage[1]"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="d:info//d:personname/*">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="d:info/d:bibliomisc[@role]|d:info/d:bibliorelation[@role]">
    <xsl:element name="dc:{@role}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="d:info/d:bibliocoverage[@spatial]">
    <dc:spatial><xsl:apply-templates/></dc:spatial>    
  </xsl:template>
  <xsl:template match="d:info/d:bibliocoverage[@temporal]">
    <dc:temporal><xsl:apply-templates/></dc:temporal>    
  </xsl:template>
  
  <xsl:template match="d:info/d:copyright|d:info/d:legalnotice">
    <dc:rights><xsl:apply-templates/></dc:rights>
  </xsl:template>
  <xsl:template match="d:info/d:copyright/d:year">
    <dc:dateCopyrighted><xsl:apply-templates/></dc:dateCopyrighted>
  </xsl:template>
   <xsl:template match="d:info/d:copyright/d:holder
                       |d:info/d:publisher/d:publishername">
    <dc:provenance><xsl:apply-templates/></dc:provenance>
  </xsl:template>
  
  <xsl:template match="d:info/d:date[not(@role)]|d:info/d:pubdate">
    <dc:date><xsl:apply-templates/></dc:date>
  </xsl:template>  
  <xsl:template match="d:info/d:date[@role]">
    <xsl:element name="dc:{@role}">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="d:info/d:publisher | d:info/d:publishername">
    <dc:publisher><xsl:apply-templates/></dc:publisher>
  </xsl:template>
  
  <xsl:template match="d:info/d:releaseinfo">
    <dc:extent><xsl:apply-templates/></dc:extent>
  </xsl:template>
</xsl:stylesheet>