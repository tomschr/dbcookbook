<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:exsl="http://exslt.org/common"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:sf="http://doccookbook.sf.net/ns/"
  exclude-result-prefixes="d xlink date exsl sf"
  extension-element-prefixes="date exsl">
  
  
  <xsl:template name="book.titlepage.recto">
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(title|bookinfo/title|
               d:title|d:info/d:title)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(subtitle|bookinfo/subtitle|
               d:subtitle|d:info/d:subtitle)[1]"/>

    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:author|bookinfo/author)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:pubdate|bookinfo/pubdate)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:releaseinfo|bookinfo/releaseinfo)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:legalnotice|bookinfo/legalnotice)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:cover|bookinfo/cover)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:revhistory|bookinfo/revhistory)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(d:info/d:abstract|bookinfo/abstract)[1]"/>
    <!--<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/annotation[@xml:id='draft']|bookinfo/annotation[@xml:id='draft'])[1]"/>-->
  </xsl:template>
  
  <xsl:template match="cover|d:cover" mode="book.titlepage.recto.auto.mode">
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"/>
  </xsl:template>
  <xsl:template match="note|d:note" mode="book.titlepage.recto.auto.mode">
    <div class="note admonition">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode"/>
    </div>
  </xsl:template>
  <xsl:template match="note/*|d:note/*" mode="book.titlepage.recto.auto.mode">
    <!-- Fallback to default mode -->
    <xsl:apply-templates select="."/>
  </xsl:template>
  <xsl:template match="note/title|d:note/d:title" mode="book.titlepage.recto.auto.mode"
    priority="1">
    <h3>
      <xsl:apply-templates/>
    </h3>    
  </xsl:template>
    
  <xsl:template match="othercredit|d:othercredit" mode="book.titlepage.recto.auto.mode"/>
  
  <xsl:template match="pubdate|d:pubdate" mode="book.titlepage.recto.auto.mode">
    <xsl:variable name="date">
      <xsl:choose>
        <xsl:when test="function-available('date:date-time')">
          <xsl:value-of select="date:date-time()"/>
        </xsl:when>
        <xsl:when test="function-available('date:dateTime')">
          <!-- Xalan quirk -->
          <xsl:value-of select="date:dateTime()"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="format">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'datetime'"/>
        <xsl:with-param name="name" select="'format'"/>
      </xsl:call-template>
    </xsl:variable>
    
    <div xsl:use-attribute-sets="book.titlepage.recto.style" class="pubdate">
      <p>
        <xsl:apply-templates/>
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="date" select="$date"/>
          <xsl:with-param name="format" select="$format"/>
          <xsl:with-param name="padding" select="1"/>
        </xsl:call-template>
      </p>
    </div>
  </xsl:template>
  
  
  <!-- Chapter Titlepages -->
  <xsl:template name="chapter.titlepage.recto">
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
      select="(title|chapterinfo/title|
               d:title|d:info/d:title)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
      select="(subtitle|chapterinfo/subtitle|
               d:subtitle|d:info/d:subtitle)[1]"/>
    
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:authorgroup|chapterinfo/authorgroup)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:author|chapterinfo/author)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:releaseinfo|chapterinfo/releaseinfo)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:abstract|chapterinfo/abstract)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:revhistory|chapterinfo/revhistory)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(d:info/d:biblioid|chapterinfo/biblioid)[1]"/>
  </xsl:template>
  
  <xsl:template match="biblioid[@class='other' and  @otherclass='ticket']|
                       d:biblioid[@class='other' and  @otherclass='ticket']" 
    mode="chapter.titlepage.recto.auto.mode">
    <xsl:variable name="ticketnr" select="normalize-space(.)"/>
    <div class="ticket">
      <xsl:value-of select="concat('See also Ticket#', $ticketnr, ': ')"/>
      <a href="{concat($ticket.url, $ticketnr, '/')}" title="Ticket#{$ticketnr}">
        <xsl:value-of select="concat($ticket.url, $ticketnr, '/')"/>
      </a>
    </div>
  </xsl:template>  
  
</xsl:stylesheet>