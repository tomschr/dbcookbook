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
  exclude-result-prefixes="d xlink tmpl m t f h l">
  
  <!--<xsl:template match="d:annotation[@xml:id='draft']" mode="m:titlepage-recto-mode">
    <xsl:message>  d:annotation[@xml:id='draft']</xsl:message>
    <div>
      <xsl:sequence select="f:html-attributes(.)"/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>-->

  <xsl:template match="d:cover" mode="m:titlepage-recto-mode">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="d:othercredit" mode="m:titlepage-recto-mode"/>
  
  <xsl:template match="d:othercredit[@class='proofreader']" mode="m:titlepage-recto-mode">
    <div>
      <xsl:sequence select="f:html-attributes(.)"/>
      <p>
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'revisedby'"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="d:orgname">
            <xsl:apply-templates select="d:orgname"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="d:personname"/>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="d:biblioid[@class='other' and
    @otherclass='ticket']" mode="m:titlepage-mode">
    <xsl:variable name="ticketnr" select="normalize-space(.)"/>
    <div class="ticket">
      <xsl:value-of select="concat('See also Ticket#', $ticketnr, ': ')"/>
      <a href="{concat($ticket.url, $ticketnr, '/')}" title="Ticket#{$ticketnr}">
        <xsl:value-of select="concat($ticket.url, $ticketnr, '/')"/>
      </a>
    </div>
  </xsl:template>
</xsl:stylesheet>