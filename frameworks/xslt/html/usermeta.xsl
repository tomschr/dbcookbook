<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:exsl="http://exslt.org/common"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="d xlink date exsl">

<xsl:template name="system.head.content">
  <xsl:param name="node" select="."/>

  <xsl:attribute name="profile">http://dublincore.org/documents/dcq-html/</xsl:attribute>

  <link rel="schema.DC" href="http://purl.org/dc/elements/1.1/"/>
  <link rel="schema.DCTERMS" href="http://purl.org/dc/terms/"/>

  <!-- FIXME: When chunking, only the annotations actually used
              in this chunk should be referenced. I don't think it
              does any harm to reference them all, but it adds
              unnecessary bloat to each chunk. -->
  <xsl:if test="$annotation.support != 0 and //annotation">
    <xsl:call-template name="add.annotation.links"/>
    <script type="text/javascript">
      <xsl:text>
// Create PopupWindow objects</xsl:text>
      <xsl:for-each select="//annotation">
        <xsl:text>
var popup_</xsl:text>
        <xsl:value-of select="generate-id(.)"/>
        <xsl:text> = new PopupWindow("popup-</xsl:text>
        <xsl:value-of select="generate-id(.)"/>
        <xsl:text>");
</xsl:text>
        <xsl:text>popup_</xsl:text>
        <xsl:value-of select="generate-id(.)"/>
        <xsl:text>.offsetY = 15;
</xsl:text>
        <xsl:text>popup_</xsl:text>
        <xsl:value-of select="generate-id(.)"/>
        <xsl:text>.autoHide();
</xsl:text>
      </xsl:for-each>
    </script>

    <style type="text/css">
      <xsl:value-of select="$annotation.css"/>
    </style>
  </xsl:if>
  
  <!-- system.head.content is like user.head.content, except that
       it is called before head.content. This is important because it
       means, for example, that <style> elements output by system.head.content
       have a lower CSS precedence than the users stylesheet. -->
</xsl:template>

  <xsl:template name="user.head.content">
    <xsl:param name="node" select="."/>

    <xsl:if test="$generate.user.meta != 0">
      <xsl:call-template name="user.meta.dublincore">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
      <xsl:call-template name="user.meta.author">
        <xsl:with-param name="node" select="$node/d:info/d:author"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  
  <xsl:template name="user.meta.author">
    <xsl:param name="node" select="."/>

    <xsl:variable name="author">
      <xsl:call-template name="person.name">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$author != ''">
      <meta name="author" content="{$author}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="user.meta.dublincore">
    <xsl:param name="node" select="."/>

    <meta name="DC.format" content="text/html" scheme="DCTERMS.IMT"/>
    <meta name="DC.type" content="Text" scheme="DCTERMS.DCMIType"/>
    <meta name="DC.Language" content="{/*/@xml:lang}" scheme="DCTERMS.RFC3066"/>
    <meta name="DC.title">
      <xsl:attribute name="content">
        <xsl:call-template name="get.doc.title"/>
      </xsl:attribute>
    </meta>

    <meta name="DC.creator">
      <xsl:attribute name="content">
        <xsl:call-template name="person.name">
          <xsl:with-param name="node" select="$node/d:info/d:author"/>
        </xsl:call-template>
      </xsl:attribute>
    </meta>
    <xsl:if test="$node/d:info/d:subjectset">
      <meta name="DC.subject">
        <xsl:attribute name="content">
          <xsl:for-each select="$node/d:info/d:subjectset/d:subject">
            <xsl:apply-templates select="d:subjectterm"/>
            <xsl:if test="following-sibling::d:subject">, </xsl:if>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    <xsl:if test="$node/d:info/d:abstract">
      <meta name="DC.description">
        <xsl:attribute name="content">
          <xsl:for-each select="$node/d:info/d:abstract[1]/*">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position() &lt; last()">
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    <xsl:if test="$node/d:info/d:publishername or
                  $node/d:info/d:publisher">
      <meta name="DC.publisher">
        <xsl:attribute name="content">
          <xsl:for-each select="($node/d:info/d:publishername |
                                 $node/d:info/d:publisher/d:publishername)[1]/*">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    <meta name="DC.contributor" content=""/>
    <meta name="DC.date" scheme="DCTERMS.W3CDTF">
      <xsl:variable name="date" select="date:date-time()"/>
      <xsl:attribute name="content">
        <!--content="2011-09-18T01:49:37+02:00"-->
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="format">Y-m-d</xsl:with-param>
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
        <xsl:text>T</xsl:text>
        <xsl:call-template name="datetime.format">
          <xsl:with-param name="format">X</xsl:with-param>
          <xsl:with-param name="date" select="$date"/>
        </xsl:call-template>
      </xsl:attribute>
    </meta>
    <meta name="DC.type" content="Text" scheme="DCTERMS.DCMIType"/>
    <xsl:if test="$node/d:info/d:biblioid">
      <xsl:for-each select="$node/d:info/d:biblioid">
        <meta name="DC.identifier" scheme="DCTERMS.URI">
          <xsl:attribute name="content">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:attribute>
        </meta>
      </xsl:for-each>
    </xsl:if>
    
    <!--<meta name="DC.source"
      content="http://www.w3.org/TR/html401/struct/global.html#h-7.4.4"
      scheme="DCTERMS.URI"/>--> 
    <meta name="DC.relation" content="http://dublincore.org/"
      scheme="DCTERMS.URI"/>
    <meta name="DC.coverage" content="" scheme="DCTERMS.TGN"/><!-- FIXME -->
    <meta name="DC.rights" content="legalnotice"  scheme="DCTERMS.URI"/>
  </xsl:template>

</xsl:stylesheet>