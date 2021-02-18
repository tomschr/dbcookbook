<?xml version="1.0" encoding="UTF-8"?>
<!--
   Purpose:
     Stylesheet to convert XHTML to Bulma Structure

   Input:
     XHTML5 code created by the XSLT 1.0 DocBook stylesheets

   Output:
     XHTML5 code which has the required Bulma structure as with
     https://bulma.io/

   Usage:
     xsltproc -stringparam base.dir build/ -stringparam rootid \
              -param use.id.as.filename 1 \
              $DB5/xhtml5/chunk.xsl \
              build/tmp/DocBook-Cookbook.xml

   Copyright 2018, Thomas Schraitle <tom_schr AT web DOT de>
-->
<xsl:stylesheet version="1.0" xml:lang="en"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="exsl h">

  <xsl:import href="copy.xsl"/>

  <xsl:preserve-space elements="h:pre"/>
  <xsl:strip-space elements="h:*"/>

  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>


  <!-- ================================================================= -->
  <!-- Parameters                                                        -->
  <xsl:param name="bulma.stylesheet">bulma.css</xsl:param>
  <xsl:param name="css.stylesheet"/>

  <xsl:param name="hero-class">hero is-primary is-small</xsl:param>

  <xsl:param name="with-hero-footer" select="1"/>
  
  <xsl:param name="with-fixed-header" select="0"/>
  <xsl:param name="with-header" select="0"/>
  <xsl:param name="with-footer" select="1"/>

  <!-- ================================================================= -->
  <!-- Attribute Sets                                                    -->


  <!-- ================================================================= -->
  <!-- Remove or otherwise leave out elements and attributes             -->
  <xsl:template match="h:div">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="h:span[@class='emphasis']">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="h:div[@class='revhistory']/h:table/@border">
    <xsl:attribute name="border">0</xsl:attribute>
  </xsl:template>
  <xsl:template match="h:div[@class='revhistory']/h:table/@style"/>
  <xsl:template match="h:div[@class='revhistory']/h:table/h:tr/h:td/@style"/>
  <xsl:template match="h:div[@class='abstract-title']"/>

  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test="starts-with(., 'sgmltag')">
        <xsl:attribute name="class">
          <xsl:text>tag-</xsl:text>
          <xsl:value-of select="substring-after(., 'sgmltag-')"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test=". = 'citetitle'"/>
      <xsl:when test=". = 'link'"/>
      <xsl:when test=". = 'listitem'"/>
      <xsl:when test=". = 'title'"/>
      <xsl:when test=". = 'subtitle'"/>
      <xsl:when test=". = 'xref'"/>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Remove obsolete elements and attributes -->
  <xsl:template match="/h:html/@version"/>
  <xsl:template match="@lang[.='']|@xml:lang[.='']"/>
  <xsl:template match="h:table/h:h1"/>
  <xsl:template match="h:br"/>
  <xsl:template match="h:div/@title"/>
  <xsl:template match="h:a/@title"/>
  <xsl:template match="h:a/@target"/>
  <xsl:template match="h:blockquote/@title"/>
  <xsl:template match="h:p/@title"/>
  <xsl:template match="h:p[@class='legalnotice-title']"/>

  <xsl:template match="h:ul/@class"/>
  <xsl:template match="h:ol[@class='procedure']/@class"/>

  <!-- Remove any id on headers as they are added to <section> -->
  <xsl:template match="h:h2[@class='title']/@id"/>
  <xsl:template match="h:h3[@class='title']/@id"/>
  <xsl:template match="h:h4[@class='title']/@id"/>
  <xsl:template match="h:h5[@class='title']/@id"/>
  <xsl:template match="h:h6[@class='title']/@id"/>

  <!-- Remove any style in headers -->
  <xsl:template match="h:h1[contains(@style, 'clear')]/@style |
                       h:h2[contains(@style, 'clear')]/@style |
                       h:h3[contains(@style, 'clear')]/@style |
                       h:h4[contains(@style, 'clear')]/@style |
                       h:h5[contains(@style, 'clear')]/@style |
                       h:h6[contains(@style, 'clear')]/@style"/>

  <xsl:template match="h:div[@class='revhistory']/h:h1"/>

  <!-- Remove empty anchors -->
  <xsl:template match="h:a[. = '']"/>

  <xsl:template match="/h:html">
    <xsl:variable name="thislang" select="(@lang|@xml:lang|document('')/xsl:stylesheet/@xml:lang)[1]"/>

    <html>
      <xsl:apply-templates select="@*[not(local-name('lang'))]"/>
      <xsl:attribute name="lang">
        <xsl:choose>
          <xsl:when test="@lang"><xsl:value-of select="@lang"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$thislang"/></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="xml:lang">
        <xsl:choose>
          <xsl:when test="@xml:lang"><xsl:value-of select="@xml:lang"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="$thislang"/></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="$with-fixed-header = 1">
        <xsl:attribute name="class">has-navbar-fixed-top</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </html>
  </xsl:template>

  <!-- ================================================================= -->
  <!-- head                                                              -->
  <xsl:template match="h:html/h:head/h:meta[1]">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="h:html/h:head/h:link[last()]">
    <xsl:copy-of select="."/>
    <xsl:choose>
      <xsl:when test="$bulma.stylesheet = ''">
        <link rel="stylesheet" type="text/css" href="buma.css"/>
      </xsl:when>
      <xsl:otherwise>
        <link rel="stylesheet" type="text/css" href="{$bulma.stylesheet}"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$css.stylesheet != ''">
      <link rel="stylesheet" type="text/css" href="{$css.stylesheet}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="h:html/h:head/h:link[@rel='stylesheet' and @href='docbook.css']"/>


  <!-- ================================================================= -->
  <xsl:template match="h:body/h:header" name="process-header">
    <xsl:param name="node" select="."/>
    <xsl:if test="$with-header = 1">
      <header class="header">
        <xsl:apply-templates/>
      </header>
    </xsl:if>
  </xsl:template>

  <xsl:template match="h:body/h:header/h:div[@class='navheader']/h:table">
    <xsl:variable name="rtf">
      <xsl:for-each select="../../../h:footer/h:div[@class='navfooter']/h:table">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:variable>
    <nav>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="$with-fixed-header = 1">navbar level is-fixed-top</xsl:when>
          <xsl:otherwise>level is-mobile</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:copy-of select="exsl:node-set($rtf)/*/*"/>
    </nav>
  </xsl:template>

  <xsl:template match="h:body/h:footer">
    <xsl:if test="$with-footer = 1">
      <footer class="footer">
        <xsl:apply-templates/>
      </footer>
    </xsl:if>
  </xsl:template>

  <xsl:template match="h:body/h:footer/h:div[@class='navfooter']/h:table">
    <nav class="level is-mobile">
      <div class="level-item">
        <xsl:if test="h:tr[1]/h:td[1]/h:a">
          <p>
            <a accesskey="p" class="link is-info" href="{h:tr[1]/h:td[1]/h:a/@href}">
              <xsl:value-of select="h:tr[1]/h:td[1]/h:a"/>
              <span class="heading">
                <xsl:value-of select="string(h:tr[2]/h:td[1])"/>
              </span>
            </a>
          </p>
        </xsl:if>
      </div>
      <div class="level-item has-text-centered">
        <xsl:if test="h:tr[1]/h:td[2]/h:a[1]">
          <p>
            <a accesskey="u" class="link is-info" href="{h:tr[1]/h:td[2]/h:a/@href}">
              <xsl:value-of select="h:tr[1]/h:td[2]/h:a"/>
            </a>
          </p>
        </xsl:if>
      </div>
      <div class="level-item has-text-right">
        <xsl:if test="h:tr[1]/h:td[3]/h:a">
          <p>
            <a accesskey="n" class="link is-info" href="{h:tr[1]/h:td[3]/h:a/@href}">
              <xsl:value-of select="string(h:tr[1]/h:td[3]/h:a)"/>
              <span class="heading">
                <xsl:value-of select="string(h:tr[2]/h:td[3])"/>
              </span>
            </a>
          </p>
        </xsl:if>
      </div>
    </nav>
  </xsl:template>

  <!-- ================================================================= -->
  <xsl:template match="h:body/h:section">
    <section class="{$hero-class}">
      <xsl:copy-of select="@id"/>
      <div class="hero-body">
        <div class="container has-text-centered">
          <xsl:apply-templates select="h:div[@class='titlepage']" mode="section-titlepage"/>
          <h2 class="subtitle">
            <!--<xsl:apply-templates select="../h:footer/h:div[@class='navfooter']/h:"/>-->
          </h2>
        </div>
      </div>
      <xsl:if test="$with-hero-footer = 1">
        <xsl:message>###########</xsl:message>
        <div class="hero-foot">
            <xsl:if test="$with-fixed-header = 0">
              <xsl:for-each select="../h:footer/h:div[@class='navfooter']/h:table">
                <xsl:apply-templates select="."/>
              </xsl:for-each>
            </xsl:if>
          </div>
        </xsl:if>
    </section>
    <xsl:apply-templates select="h:section"/>
  </xsl:template>

  <xsl:template match="h:section">
    <section class="section">
      <xsl:copy-of select="@id"/>
      <div class="content">
        <xsl:apply-templates select="h:div[@class='titlepage']" mode="section-titlepage"/>
        <xsl:apply-templates select="*[not(self::h:div[@class='titlepage'])]"/>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="h:h2" mode="section-titlepage">
    <h1 class="title">
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

  <xsl:template match="h:h3" mode="section-titlepage">
    <h2 class="title">
      <xsl:apply-templates/>
    </h2>
  </xsl:template>

  <!-- ================================================================= -->
  <xsl:template match="h:div[@class='example']">
    <div class="example">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="h:div[@class='example-title']">
    <p class="heading">
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="h:div[@class='example-content']">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- ================================================================= -->
  <xsl:template match="h:div[@class='orderedlist']">
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>