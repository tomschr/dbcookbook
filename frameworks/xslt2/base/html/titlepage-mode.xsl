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
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l xs">
  

  <xsl:template match="d:cover" mode="m:titlepage-recto-mode">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="d:biblioid[@class='other' and @otherclass='ticket']" 
    mode="m:titlepage-mode">
    <xsl:variable name="ticketnr" select="normalize-space(.)"/>
    <div class="ticket">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'Ticket'"/>
      </xsl:call-template>
      <xsl:value-of select="concat($ticketnr, ': ')"/>
      <a href="{concat($ticket.url, $ticketnr, '/')}" title="Ticket#{$ticketnr}">
        <xsl:value-of select="concat($ticket.url, $ticketnr, '/')"/>
      </a>
    </div>
  </xsl:template>
  
  <xsl:template match="d:bibliosource[@class='other']" mode="m:titlepage-mode">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="d:pubdate" mode="m:titlepage-mode">
    <xsl:choose>
      <xsl:when test="@role = 'currentdate'">
        <!--<xsl:message> pubdate: currentdate</xsl:message>-->
        <xsl:variable name="format" as="xs:string">
          <xsl:call-template name="gentext-template">
            <xsl:with-param name="context" select="'date'"/>
            <xsl:with-param name="name" select="'format'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:apply-templates mode="m:titlepage-mode"/>
        <xsl:value-of select="format-date(current-date(), $format)"/>
      </xsl:when>
      <xsl:when test="@role = 'currentdatetime'">
        <!--<xsl:message> pubdate: currentdatetime</xsl:message>-->
        <xsl:variable name="format" as="xs:string">
          <xsl:call-template name="gentext-template">
            <xsl:with-param name="context" select="'datetime'"/>
            <xsl:with-param name="name" select="'format'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:apply-templates mode="m:titlepage-mode"/>
        <xsl:value-of select="format-dateTime(current-dateTime(), $format)"/>
      </xsl:when>
      <xsl:when test=". castable as xs:dateTime">
        <!--<xsl:message> pubdate as xs:dateTime</xsl:message>-->
        <xsl:variable name="format" as="xs:string">
          <xsl:call-template name="gentext-template">
            <xsl:with-param name="context" select="'datetime'"/>
            <xsl:with-param name="name" select="'format'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="format-dateTime(xs:dateTime(.), $format)"/>
      </xsl:when>
      <xsl:when test=". castable as xs:date">
        <!--<xsl:message> pubdate as xs:date</xsl:message>-->
        <xsl:variable name="format" as="xs:string">
          <xsl:call-template name="gentext-template">
            <xsl:with-param name="context" select="'date'"/>
            <xsl:with-param name="name" select="'format'"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="format-date(xs:date(.), $format)"/>
      </xsl:when>
      <xsl:otherwise>
        <!--<xsl:message> pubdate as text</xsl:message>-->
        <xsl:apply-templates mode="m:titlepage-mode"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
