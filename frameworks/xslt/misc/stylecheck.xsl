<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text"/>
  
  <!-- ============================================================
    Parameters
  -->
  <!-- Root element must contain this value: -->
  <xsl:param name="check.root.version.attr">5.1</xsl:param>
  <!-- Contains spaces for indentation the logger output -->
  <xsl:param name="logger.indent"><xsl:text>  </xsl:text></xsl:param>
  
  <!-- ============================================================
    Named Templates 
  -->
  <xsl:template name="xpath.location">
    <xsl:param name="node" select="."/>
    <xsl:param name="path" select="''"/>

    <xsl:variable name="fo-sib"
      select="count($node/following-sibling::*[local-name()=local-name($node)
      and namespace-uri() = namespace-uri($node)])"/>
    <xsl:variable name="prec-sib"
      select="count($node/preceding-sibling::*[local-name()=local-name($node)
      and namespace-uri() = namespace-uri($node)])"/>
    
    <xsl:variable name="next.path">
      <xsl:value-of select="local-name($node)"/>
      <xsl:if test="$prec-sib >1 or $fo-sib >1">
        <xsl:value-of select="concat('[', $prec-sib+1, ']')"/>
      </xsl:if>
      <xsl:if test="$path != ''">
        <xsl:text>/</xsl:text>
      </xsl:if>      
      <xsl:value-of select="$path"/>
    </xsl:variable>
    
    <!--<xsl:message>pos = <xsl:value-of 
      select="concat($prec-sib, ':', $fo-sib)"/>
    </xsl:message>-->
    <xsl:choose>
      <xsl:when test="$node/parent::*">
        <xsl:call-template name="xpath.location">
          <xsl:with-param name="node" select="$node/parent::*"/>
          <xsl:with-param name="path" select="$next.path"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="$next.path"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="create-div">
    <xsl:param name="text"/>
    <xsl:message>
      <xsl:text>========================&#10;</xsl:text>
      <xsl:value-of select="concat($logger.indent, $text, '&#10;')"/>
      <xsl:text>------------------------&#10;</xsl:text>
    </xsl:message>
  </xsl:template>
  <xsl:template name="logger">
    <xsl:param name="admon"/>
    <xsl:param name="text"/>
    <xsl:param name="solution"/>
    <xsl:param name="with-xpath" select="1"/>
    <xsl:param name="with-title" select="1"/>
    <xsl:message>
      <xsl:value-of select="concat($admon, ':&#10;')"/>
      <xsl:if test="$with-xpath != 0">
        <xsl:value-of select="concat($logger.indent, 'XPath:    ')"/>
        <xsl:call-template name="xpath.location"/>
        <xsl:text>&#10;</xsl:text>
      </xsl:if>
      <xsl:if test="$with-title != 0 and d:title">
        <xsl:value-of select="concat($logger.indent, 'Title:    ',
          normalize-space(d:title), '&#10;')"/>
      </xsl:if>
      <xsl:value-of select="concat($logger.indent, 'Problem:  ', 
            normalize-space($text),'&#10;')"/>
      <xsl:value-of select="concat($logger.indent, 'Solution: ',
            normalize-space($solution),'&#10;')"/>
    </xsl:message>
  </xsl:template>
  <xsl:template name="warning">
    <xsl:param name="text"/>
    <xsl:param name="solution"/>
    <xsl:call-template name="logger">
      <xsl:with-param name="text" select="$text"/>
      <xsl:with-param name="solution" select="$solution"/>
      <xsl:with-param name="admon">WARNING</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="tip">
    <xsl:param name="text"/>
    <xsl:param name="solution"/>
    <xsl:call-template name="logger">
      <xsl:with-param name="text" 
        select="concat($text, '&#10;', $solution)"/>
      <xsl:with-param name="admon">TIP</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="result.logger">
    <xsl:param name="result"/>
    <xsl:choose>
      <xsl:when test="string-length($result) = 0">
        <xsl:message>=> No problems.&#10;&#10;</xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>=> Counted </xsl:text>
          <xsl:value-of select="string-length($result)"/> 
          <xsl:text> problems.&#10;&#10;</xsl:text>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ============================================================
    Template Rules 
  -->  
  <xsl:template match="text()"/>

  <xsl:template match="/">
    <xsl:apply-templates mode="root-element"/>
    <xsl:apply-templates select="/" mode="lonely-divs"/>
    <!--<xsl:apply-templates select="/" mode="id-check"/>-->
  </xsl:template>
  
  <!-- ============================================================
    Root element check 
  -->
  <xsl:template match="text()" mode="root-element"/>
  <xsl:template match="/*" mode="root-element">
    <xsl:call-template name="create-div">
      <xsl:with-param name="text">
        <xsl:text>Check root element</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:variable name="result">
      <xsl:call-template name="xml-lang-available"/>
      <xsl:call-template name="version-available"/>
      <xsl:call-template name="version-contains-right-value"/>
      <xsl:call-template name="xmlns-available"/>
    </xsl:variable>
    <xsl:call-template name="result.logger">
      <xsl:with-param name="result" select="$result"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="xml-lang-available">
    <xsl:if test="not(@xml:lang)">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>You document does not contain a xml:lang attribute</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Insert an xml:lang attribute in </xsl:text>          
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="version-available">
    <xsl:if test="not(@version)">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>You document does not contain a version attribute</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Insert a version attribute in </xsl:text>          
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="version-contains-right-value">
    <xsl:if test="@version != $check.root.version.attr">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>The version attribute contains the value </xsl:text>
          <xsl:value-of select="@version"/>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Insert a version attribute in </xsl:text>
          <xsl:value-of select="concat(local-name(), 
            ' with the value ', 
            $check.root.version.attr)"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="xmlns-available">
    <xsl:if test="namespace-uri() != 'http://docbook.org/ns/docbook'">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>You document does not belong to the DocBook5 namespace</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Insert an xmlns="http://docbook.org/ns/docbook" attribute in </xsl:text>          
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <!-- ============================================================
    Lonely section check
  -->
  <xsl:template match="text()" mode="lonely-divs"/>
  <xsl:template match="/" mode="lonely-divs">
    <xsl:call-template name="create-div">
      <xsl:with-param name="text">
        <xsl:text>Check lonely structures</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:variable name="result">
      <xsl:apply-templates mode="lonely-divs"/>
    </xsl:variable>
    <xsl:call-template name="result.logger">
      <xsl:with-param name="result" select="$result"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="d:book|d:part" mode="lonely-divs">
    <xsl:if test="count(d:chapter) = 1">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>Bad structure: </xsl:text>
          <xsl:value-of select="concat('Your ', 
            local-name(), 
            ' contains only 1 chapter')"/>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Add more chapters to your </xsl:text>
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:if test="count(d:appendix) = 1">
      <xsl:call-template name="tip">
        <xsl:with-param name="text">
          <xsl:text>Bad structure: </xsl:text>
          <xsl:value-of select="concat('Your ', 
            local-name(), 
            ' contains only 1 appendix')"/>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Add more appendices to your </xsl:text>
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:apply-templates mode="lonely-divs"/>
  </xsl:template>
  
  <xsl:template match="d:appendix|d:chapter|d:prefix" mode="lonely-divs">
    <xsl:if test="count(d:section) = 1">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>Bad structure: </xsl:text>
          <xsl:value-of select="concat('Your ', 
            local-name(), 
            ' contains only 1 section')"/>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Add more sections to your </xsl:text>
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:apply-templates mode="lonely-divs"/>
  </xsl:template>

  <xsl:template match="d:section" mode="lonely-divs">
    <xsl:if test="count(d:section) = 1">
      <xsl:call-template name="warning">
        <xsl:with-param name="text">
          <xsl:text>Bad structure: </xsl:text>
          <xsl:value-of select="concat('Your ', 
            local-name(), 
            ' contains only 1 section')"/>
        </xsl:with-param>
        <xsl:with-param name="solution">
          <xsl:text>Add more sections to your </xsl:text>
          <xsl:value-of select="local-name()"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>*</xsl:text>
    </xsl:if>
    <xsl:apply-templates mode="lonely-divs"/>
  </xsl:template>

  <!-- ============================================================
    ID checks
  -->
  
</xsl:stylesheet>