<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:exsl="http://exslt.org/common"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="d xlink date exsl">

  <xsl:preserve-space elements="script"/>

<xsl:param name="legalnotice.uri">
  <xsl:call-template name="get-uri-identifier">
    <xsl:with-param name="node"
      select="/d:book/d:info/d:legalnotice[1] |
              /book/bookinfo/legalnotice[1]"/>
  </xsl:call-template>
</xsl:param>

<xsl:template name="system.head.content">
  <xsl:param name="node" select="."/>

  <xsl:attribute name="profile">http://dublincore.org/documents/dcq-html/</xsl:attribute>

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8;" />
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
    <xsl:if test="$generate.javascript != 0">
      <xsl:call-template name="javascript"/>
    </xsl:if>
    <xsl:if test="$html.stylesheet != ''">
      <link rel="stylesheet" type="text/css" href="{$html.stylesheet}" />
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

<xsl:template name="get-uri-identifier">
  <xsl:param name="node" select="."/>
  <xsl:value-of select="concat($base.url,$base.url.path)"/>
  <xsl:apply-templates select="$node" mode="recursive-chunk-filename"/>
</xsl:template>

<xsl:template name="user.meta.dublincore">
    <xsl:param name="node" select="."/>
    
    <xsl:variable name="filename">
      <xsl:call-template name="get-uri-identifier">
        <xsl:with-param name="node" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="title">
      <!--<xsl:apply-templates select="$node" mode="object.title.markup.textonly"/>-->
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="allow-anchors" select="0"/>
        <xsl:with-param name="template">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'title-unnumbered'"/>
            <xsl:with-param name="name">
              <xsl:call-template name="xpath.location">
                <xsl:with-param name="node" select="$node"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template> 
    </xsl:variable>
    <xsl:variable name="author">
      <xsl:call-template name="person.name">
        <xsl:with-param name="node"
          select="($node/d:info/d:author/d:personname |
                   $node/*/author/personname |
                   /d:book/d:info/d:author |
                   /book/*/author)[1]"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="contributors">
      <xsl:for-each select="$node/d:info/d:othercredit |
                            $node/d:info/d:authorgroup/d:othercredit |
                            $node/*/othercredit |
                            $node/*/authorgroup/othercredit">
        <xsl:call-template name="person.name"/>
        <xsl:if test="position() &lt; last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="lang">
      <xsl:call-template name="l10n.language"/>
    </xsl:variable>

    <meta name="DC.format"     scheme="DCTERMS.IMT" content="text/html"/>
    <meta name="DC.type"       scheme="DCTERMS.DCMIType" content="Text" />
    <meta name="DC.language"   scheme="DCTERMS.RFC3066" content="{$lang}"/>
    <meta name="DC.identifier" scheme="DCTERMS.URI" content="{$filename}"/>
    
    <xsl:if test="normalize-space($title)">
      <meta name="DC.title" xml:lang="{$lang}" content="{normalize-space($title)}"/>
    </xsl:if>
    <xsl:if test="normalize-space($author) != ''">
      <meta name="DC.creator" content="{normalize-space($author)}"/>
    </xsl:if>
    <xsl:if test="normalize-space($contributors)">
      <meta name="DC.contributor" content="{$contributors}"/>
    </xsl:if>
  
    <!--<xsl:message>user.meta.dublincore:
      filename:   <xsl:value-of select="$filename"/>
      title:      <xsl:value-of select="$title"/> 
      
      node:       <xsl:value-of select="local-name($node)"/>
      current:    <xsl:value-of select="local-name(.)"/>
      parent:     <xsl:value-of select="local-name($node/parent::*[1])"/>
      @xml:id:    <xsl:value-of select="($node/@xml:id | $node/@id)[1]"/>
      info:       <xsl:value-of select="count($node/d:info)"/>
      info direct:<xsl:value-of select="count(d:info)"/>
      subjectset: <xsl:value-of select="count($node/d:info/d:subjectset)"/>
    </xsl:message>-->
    
    <xsl:if test="$node/d:info/d:subjectset or $node/*/subjectset">
      <xsl:for-each select="$node/d:info/d:subjectset/d:subject | 
                                $node/*/subjectset/subject">
        <meta name="DC.subject" xml:lang="{$lang}">
          <xsl:attribute name="content">
            <xsl:for-each select="d:subjectterm|subjectterm">
              <xsl:value-of select="."/>
              <xsl:if test="position() &lt; last()">, </xsl:if>
            </xsl:for-each>    
          </xsl:attribute>
        </meta>  
      </xsl:for-each>
    </xsl:if>
   
    <xsl:if test="$node/d:info/d:abstract or $node/*/abstract">
      <meta name="DC.description">
        <xsl:attribute name="content">
          <xsl:for-each select="$node/d:info/d:abstract[1]/* |
                                $node/*/abstract[1]/*">
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="position() &lt; last()">
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    
    <xsl:if test="$node/d:info/d:publishername or
                  $node/*/publishername or
                  $node/d:info/d:publisher or
                  $node/*/publisher">
      <meta name="DC.publisher">
        <xsl:attribute name="content">
          <xsl:for-each select="($node/d:info/d:publishername |
                                 $node/*/publishername |
                                 $node/d:info/d:publisher/d:publishername|
                                 $node/*/publisher/publishername
                                 )[1]/*">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:for-each>
        </xsl:attribute>
      </meta>
    </xsl:if>
    
    <xsl:if test="function-available('date:date-time')">
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
    </xsl:if>
    
    <meta name="DC.source"
      content="http://www.w3.org/TR/html401/struct/global.html#h-7.4.4"
      scheme="DCTERMS.URI"/> 
    <meta name="DC.relation" content="http://dublincore.org/"
      scheme="DCTERMS.URI"/>
    <!--<meta name="DC.coverage" content="" scheme="DCTERMS.TGN"/>--><!-- FIXME -->
    <xsl:if test="/d:book/d:info/d:legalnotice or /book/bookinfo/legalnotice">
      <meta name="DC.rights" content="{$legalnotice.uri}" scheme="DCTERMS.URI"/>
    </xsl:if>
</xsl:template>
  
<xsl:template name="javascript">
    <script type="text/javascript" src="js/dbmodnizr.js">/**/</script>
</xsl:template>

</xsl:stylesheet>