<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:n="urn:x-toms:ns:namespaces"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="n">
  
  <xsl:import
    href="https://cdn.docbook.org/release/xsl/current/xhtml/docbook.xsl"/>
  
  <xsl:include href="xpathns.location.xsl"/>
  <!--<xsl:include href="xpath.ns.predicate.location.xsl"/>-->
  
  <xsl:template match="d:info/d:authorgroup" mode="article.titlepage.recto.auto.mode">
    <xsl:message>*** d: <xsl:call-template name="xpath.location"/></xsl:message>
  </xsl:template>
  
  <xsl:template match="d:info">
    <xsl:message>*** info: <xsl:call-template name="xpath.location"/></xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="rdf:RDF" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <xsl:message>*** rdf: <xsl:call-template name="xpath.location"/></xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cc:License" xmlns:cc="http://creativecommons.org/ns#">
    <xsl:message>*** cc: <xsl:call-template name="xpath.location"/></xsl:message>
  </xsl:template>
  
  <xsl:template match="dc:*" xmlns:dc="http://purl.org/dc/elements/1.1/"/>
  
  
  <xsl:template match="d:para">
    <xsl:variable name="bg">
      <xsl:call-template name="pi-attribute">
        <xsl:with-param name="pis" select="processing-instruction('toms-html')"/>
        <xsl:with-param name="attribute" select="'background-color'"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:message><!--
      para with bg = "<xsl:value-of select="$bg"/>"-->
      <xsl:text>Current XPath: </xsl:text>
      <xsl:call-template name="xpath.location"/>
    </xsl:message>
    
    <xsl:choose>
      <xsl:when test="$bg != ''">
        <div style="background-color:{$bg}">
          <xsl:apply-imports/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>