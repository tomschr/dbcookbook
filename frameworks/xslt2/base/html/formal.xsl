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
  exclude-result-prefixes="d xlink tmpl m t f h l xs">

<xsl:template name="t:create-downloadlink">
  <xsl:param name="node" select="."/>
  <xsl:variable name="downloadlink"
      select="if ($node/d:info/d:biblioid[@class='uri'])
              then $node/d:info/d:biblioid[@class='uri']
              else ()"/>
  
  <xsl:if test="$use.downloadlink != 0 and not(empty($downloadlink))">
      <xsl:if test="$verbosity != 0">
        <xsl:message>  Creating example download "<xsl:value-of
          select="$downloadlink"/>"</xsl:message>
      </xsl:if>
      <div class="example-download-link">
        <a href="{$downloadlink}">Download File</a>
      </div>
      <xsl:result-document href="{$downloadlink}" encoding="UTF-8"
        method="text" validation="strip">
        <xsl:value-of select="($node/d:programlisting |
                   $node/d:programlistingco/d:programlisting)[1]/text()" disable-output-escaping="yes"/>        
      </xsl:result-document>      
    </xsl:if>
</xsl:template>

<xsl:template name="t:formal-info-object">
  <xsl:param name="context" select="."/>
  <xsl:param name="placement" select="'before'"/>
  <xsl:param name="longdesc" select="()"/>
  <xsl:param name="class" select="local-name($context)"/>
  <xsl:param name="object" as="element()*" required="yes"/>

  <xsl:variable name="title">
    <xsl:call-template name="t:titlepage">
      <xsl:with-param name="node" select="$context"/>
    </xsl:call-template>
    <xsl:call-template name="t:longdesc-link">
      <xsl:with-param name="textobject" select="$longdesc[1]"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="downloadlink"
      select="if (d:info/d:biblioid[@class='uri'])
      then d:info/d:biblioid[@class='uri']
      else ()"/>

  <!--<xsl:variable name="wrapper">
    <!-\-<figure>-\->
      <xsl:sequence select="f:html-attributes($context, f:node-id($context), concat($class,'-wrapper'))"/>
      <xsl:choose>
        <xsl:when test="$placement = 'before'">
          <xsl:sequence select="$title"/>
          <!-\-<xsl:call-template name="t:create-downloadlink"/>
          <xsl:sequence select="$object"/>
          <xsl:apply-templates select="$context/d:caption"/>-\->
        </xsl:when>
        <xsl:otherwise>
          <xsl:sequence select="$object"/>
          <xsl:apply-templates select="$context/d:caption"/>
          <xsl:sequence select="$title"/>
          <xsl:call-template name="t:create-downloadlink"/>
        </xsl:otherwise>
      </xsl:choose>
    <!-\-</figure>-\->
  </xsl:variable>-->
  <!-- 
    CAVEAT: I need to duplicate the code in wrapper as
    xsl:result-document is not allowed inside variables 
  -->
  <xsl:choose>
    <xsl:when test="$context/@floatstyle">
      <div class="float-{$context/@floatstyle}">
          <figure>
            <xsl:sequence
              select="f:html-attributes($context, f:node-id($context), concat($class,'-wrapper'))"/>
            <xsl:choose>
              <xsl:when test="$placement = 'before'">
                <xsl:sequence select="$title"/>
                <xsl:call-template name="t:create-downloadlink"/>
                <xsl:sequence select="$object"/>
                <xsl:apply-templates select="$context/d:caption"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="$object"/>
                <xsl:apply-templates select="$context/d:caption"/>
                <xsl:sequence select="$title"/>
                <xsl:call-template name="t:create-downloadlink"/>
              </xsl:otherwise>
            </xsl:choose>
          </figure>
      </div>
    </xsl:when>
    <xsl:otherwise>
        <figure>
          <xsl:sequence
            select="f:html-attributes($context, f:node-id($context), concat($class,'-wrapper'))"/>
          <xsl:choose>
            <xsl:when test="$placement = 'before'">
              <xsl:sequence select="$title"/>
              <xsl:call-template name="t:create-downloadlink"/>
              <xsl:sequence select="$object"/>
              <xsl:apply-templates select="$context/d:caption"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="$object"/>
              <xsl:apply-templates select="$context/d:caption"/>
              <xsl:sequence select="$title"/>
              <xsl:call-template name="t:create-downloadlink"/>
            </xsl:otherwise>
          </xsl:choose>
        </figure>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
<xsl:template match="d:example">
  <xsl:call-template name="t:formal-info-object">
    <xsl:with-param name="placement"
            select="$formal.title.placement[self::d:example]/@placement"/>
    <xsl:with-param name="class" select="local-name(.)"/>
    <xsl:with-param name="object" as="element()">
      <div>
        <xsl:sequence select="f:html-attributes(., ())"/>
        <xsl:apply-templates select="*[not(self::d:caption)]"/>
      </div>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>
  
</xsl:stylesheet>