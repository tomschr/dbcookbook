<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:de="urn:x-toms:docbook-ext"
  exclude-result-prefixes="d xlink tmpl m t f h l xs de">
  
  <xsl:template name="t:write-examples">
    <xsl:param name="node" select="/" as="document-node()"/>
    
    <xsl:for-each 
      select="$node//( (d:example|d:informalexample)
                         [d:info/de:output/de:filename] )">
      <xsl:variable name="dl" select="f:download-link(.)"/>
      
      <xsl:if test="not(empty($dl))">
        <xsl:if test="$verbosity > 2">
          <xsl:message>  Creating example output for "<xsl:value-of
            select="$dl"/>"</xsl:message>
        </xsl:if>
        <xsl:result-document href="{$dl}" encoding="UTF-8"
          method="text" validation="strip">
          <xsl:value-of disable-output-escaping="yes"
            select="string((current()/d:programlisting |
                   current()/d:programlistingco/d:programlisting)[1])"/>
        </xsl:result-document>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>