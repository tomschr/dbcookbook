<?xml version="1.0" encoding="UTF-8"?>
<!--
    Obfuscate Stylesheet
    Sometimes useful, if someone is not interested in the text 
    (or even want to hide it) but in the structure

    Derived from the epub/bin/xslt/obfuscate.xsl
-->
<xsl:stylesheet  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:h="http://www.w3.org/1999/xhtml">
  
  <xsl:output indent="no" 
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  
  <xsl:template match="@*|*|comment()|processing-instruction()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*/text()">
     <xsl:call-template name="obfuscate"/>
  </xsl:template>
  
  <xsl:template name="obfuscate">
    <xsl:param name="text" select="."/>    
    <xsl:value-of select="replace(replace($text, '[a-z]', 'x'), '[0-9]', 'd')"/>
  </xsl:template>
  
  
  <xsl:template match="h:meta[@name='author' or 
                              @name='description' or
                              @name='keywords' or 
                              @name='DC.creator' or
                              @name='DC.identifier']/@content">
    <xsl:attribute name="content">
      <xsl:call-template name="obfuscate"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="h:a/@href|@src">
    <xsl:attribute name="{local-name()}">
      <xsl:call-template name="obfuscate"/>      
    </xsl:attribute>
  </xsl:template>
  
</xsl:stylesheet>
