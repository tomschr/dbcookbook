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

<xsl:param name="base.example.dir" as="xs:string">example/</xsl:param>

<xsl:function name="f:download-link">
  <xsl:param name="node" />
  
  <xsl:variable name="fn"
      select="if ($node/d:info/de:output/de:filename)
              then $node/d:info/de:output/de:filename
              else ()"/>
  <xsl:variable name="downloadlink" 
      select="if ($fn)
              then concat($base.example.dir, $fn)
              else ()"/>
  
  <xsl:sequence select="$downloadlink"/>
</xsl:function>


<xsl:template name="t:create-downloadlink">
  <xsl:param name="node" select="."/>
  <xsl:variable name="dl" select="f:download-link($node)"/>
  
    <xsl:if test="$use.downloadlink != 0 and not(empty($dl))">
      <xsl:if test="$verbosity > 4">
        <xsl:message> Integrating download link for "<xsl:value-of
            select="$dl"/>"</xsl:message>
      </xsl:if>
      <div class="example-download-link">
        <a href="{$dl}">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'Download'"/>
          </xsl:call-template>
        </a>
      </div>
    </xsl:if>
</xsl:template>


<xsl:template match="d:informalexample">
  <xsl:call-template name="t:informal-object">
    <xsl:with-param name="class" select="local-name(.)"/>
    <xsl:with-param name="object" as="element()">
      <div>
      <xsl:call-template name="t:create-downloadlink"/>
      <div>
        <xsl:sequence select="f:html-attributes(., ())"/>
        <xsl:apply-templates select="*[not(self::d:caption)]"/>
      </div>
      </div>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="d:example">
  <xsl:call-template name="t:formal-object">
    <xsl:with-param name="placement"
            select="$formal.title.placement[self::d:example]/@placement"/>
    <xsl:with-param name="class" select="local-name(.)"/>
    <xsl:with-param name="object" as="element()">
      <div>
      <xsl:call-template name="t:create-downloadlink"/>
      <div>
        <xsl:sequence select="f:html-attributes(., ())"/>
        <xsl:apply-templates select="*[not(self::d:caption)]"/>
      </div>
      </div>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
  
</xsl:stylesheet>