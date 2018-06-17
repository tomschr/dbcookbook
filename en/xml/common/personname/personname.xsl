<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="https://cdn.docbook.org/release/xsl/current/xhtml/docbook.xsl"/>
  
  <xsl:template name="person.lastname">
  <!-- Formats a personal name. Handles corpauthor as a special case. -->
  <xsl:param name="node" select="."/>

  <!--<xsl:message>  person.lastname=<xsl:value-of
    select="normalize-space($node)"/></xsl:message>-->

  <xsl:choose>
    <!-- the personname element is a specialcase -->
    <xsl:when test="$node/db:personname">
      <xsl:call-template name="person.lastname">
        <xsl:with-param name="node" select="$node/db:personname"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:otherwise>
      <xsl:choose>
        <!-- Handle case when personname contains only general markup (DocBook 5.0) -->
        <xsl:when test="$node/self::db:personname and 
                        not($node/db:firstname or 
                            $node/db:honorific or 
                            $node/db:lineage or 
                            $node/db:othername or 
                            $node/db:surname)">
          <xsl:apply-templates select="$node/node()"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:if test="$node/db:honorific">
              <xsl:apply-templates select="$node/db:honorific[1]"/>
              <xsl:value-of select="$punct.honorific"/>
              <xsl:text> </xsl:text>
            </xsl:if>
          <xsl:apply-templates select="$node/db:surname[1]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  
  <xsl:template name="person.lastname.list">
    <xsl:param name="person.list" select="db:author|db:corpauthor|db:othercredit|db:editor"/>
    <xsl:param name="person.count" select="count($person.list)"/>
    <xsl:param name="count" select="1"/>
    
   
    <xsl:choose>
    <xsl:when test="$count &gt; $person.count"></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="person.lastname">
        <xsl:with-param name="node" select="$person.list[position()=$count]"/>
      </xsl:call-template>

      <xsl:choose>
        <xsl:when test="$person.count = 2 and $count = 1">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'sep2'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$person.count &gt; 2 and $count+1 = $person.count">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'seplast'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$count &lt; $person.count">
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'authorgroup'"/>
            <xsl:with-param name="name" select="'sep'"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>

      <xsl:call-template name="person.lastname.list">
        <xsl:with-param name="person.list" select="$person.list"/>
        <xsl:with-param name="person.count" select="$person.count"/>
        <xsl:with-param name="count" select="$count+1"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
    
  </xsl:template>
  
  <xsl:template name="get.person.name">
    <xsl:param name="author"/>
    
    <xsl:message>get.person.name --------------------</xsl:message>
    <xsl:for-each select="$author">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.name">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="get.person.name.family-given">
    <xsl:param name="author"/>
    <xsl:message>get.person.name.family-given --------------------</xsl:message>
    <xsl:for-each select="$author">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.name.family-given">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="get.person.name.last-first">
    <xsl:param name="author"/>
    <xsl:message>get.person.name.last-first --------------------</xsl:message>
    <xsl:for-each select="$author">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.name.last-first">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="get.person.lastname">
    <xsl:param name="author"/>
    <xsl:message>get.person.lastname --------------------</xsl:message>
    <xsl:for-each select="$author">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.lastname">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  
  <xsl:template name="get.person.name.list">
    <xsl:param name="authorgroup"/>
    <xsl:message>get.person.name.list --------------------</xsl:message>
    <xsl:for-each select="$authorgroup">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.name.list">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="get.person.lastname.list">
    <xsl:param name="authorgroup"/>
    <xsl:message>get.person.lastname.list --------------------</xsl:message>
    <xsl:for-each select="$authorgroup">
      <xsl:message><xsl:value-of select="concat(local-name(.), '[',
        position(), ']=')"/><xsl:call-template name="person.lastname.list">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </xsl:message>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="/">
    <xsl:variable name="author" select="*/db:info/db:author"/>
    <xsl:variable name="authorgroup" select="*/db:info/db:authorgroup"/>
    
    <xsl:call-template name="get.person.name">
      <xsl:with-param name="author" select="$author"/>
    </xsl:call-template>
    <xsl:call-template name="get.person.name.family-given">
      <xsl:with-param name="author" select="$author"/>
    </xsl:call-template>
    <xsl:call-template name="get.person.name.last-first">
      <xsl:with-param name="author" select="$author"/>
    </xsl:call-template>
    <xsl:call-template name="get.person.lastname">
      <xsl:with-param name="author" select="$author"/>
    </xsl:call-template>
    
    <xsl:call-template name="get.person.name.list">
      <xsl:with-param name="authorgroup" select="$authorgroup"/>
    </xsl:call-template>
    <xsl:call-template name="get.person.lastname.list">
      <xsl:with-param name="authorgroup" select="$authorgroup"/>
    </xsl:call-template>
    
    <xsl:apply-imports/>
  </xsl:template>
  
</xsl:stylesheet>