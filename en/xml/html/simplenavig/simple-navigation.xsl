<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d">
    
  <xsl:template name="generate.simple.navigation">
    <xsl:param name="node" select="."/>
    <xsl:variable name="prev" select="$node/preceding-sibling::d:chapter"/>
    <xsl:variable name="next" select="$node/following-sibling::d:chapter"/>
    <xsl:variable name="up"   select="$node/parent::d:*"/>
   
    <div class="chapter-navigation">
      <ul>
        <xsl:if test="count($next) >0">
          <li class="next">
            <xsl:call-template name="gentext.nav.next"/>
            <xsl:text>: </xsl:text>
            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$next"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:value-of select="$next/d:title"/>
            </a>
          </li>
        </xsl:if>
        <xsl:if test="count($prev) >0">
          <li class="prev">
            <xsl:call-template name="gentext.nav.prev"/>
            <xsl:text>: </xsl:text>
            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$prev"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:value-of select="$prev/d:title"/>
            </a>
          </li>
        </xsl:if>
        <xsl:if test="count($up) >0">
          <li class="up">
            <xsl:call-template name="gentext.nav.up"/>
            <xsl:text>: </xsl:text>
            <a>
              <xsl:attribute name="href">
                <xsl:call-template name="href.target">
                  <xsl:with-param name="object" select="$up"/>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:value-of select="$up/d:title"/>
            </a>
          </li>
        </xsl:if>
      </ul>
    </div>
  </xsl:template>
</xsl:stylesheet>