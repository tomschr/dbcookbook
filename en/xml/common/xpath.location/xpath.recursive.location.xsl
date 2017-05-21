<xsl:stylesheet version="1.0" xmlns:n="urn:x-toms:ns:namespaces"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="n">
  <namespaces xmlns="urn:x-toms:ns:namespaces">
    <ns prefix="cc">http://creativecommons.org/ns#</ns>
    <ns prefix="d">http://docbook.org/ns/docbook</ns>
    <ns prefix="fo">http://www.w3.org/1999/XSL/Format</ns>
    <ns prefix="svg">http://www.w3.org/2000/svg</ns>
    <ns prefix="xi">http://www.w3.org/2001/XInclude</ns>
    <ns prefix="xsl">http://www.w3.org/1999/XSL/Transform</ns>
    <ns prefix="rdf">http://www.w3.org/1999/02/22-rdf-syntax-ns#</ns>
  </namespaces>

  <xsl:variable name="nsnodes" select="document('')//n:namespaces/n:ns"/>
  <xsl:param name="method">prefix</xsl:param>

  <xsl:template name="xpath.location">
    <xsl:param name="node" select="."/>
    <xsl:apply-templates select="$node/ancestor-or-self::node()" mode="xpath-step"/>
  </xsl:template>

  <xsl:template match="/" mode="xpath-step"/>  
  
  <xsl:template match="node()" mode="xpath">
    <xsl:apply-templates select="ancestor::*|." mode="xpath-step"/>
  </xsl:template>
  
  <xsl:template name="addprefix">
    <xsl:param name="node" select="."/>
    <!--
    <xsl:message> * <xsl:value-of 
      select="concat(local-name(), ':', namespace-uri($node), ' -> ',
      $nsnodes[.=namespace-uri($node)]/@prefix )"/>
    </xsl:message>
    -->
    <xsl:choose>
      <xsl:when
        test="$method = 'prefix' and $nsnodes[. = namespace-uri($node)]">
        <xsl:value-of
          select="concat($nsnodes[. = namespace-uri($node)]/@prefix, ':')"/>
      </xsl:when>
      <xsl:when test="$method = 'clark' and namespace-uri($node) != ''">
        <xsl:value-of select="concat('{', namespace-uri($node), '}')"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*" mode="xpath-step">
    <xsl:text>/</xsl:text>
    <!-- Add prefix, if necessary -->
    <xsl:call-template name="addprefix"/>
    <xsl:value-of select="local-name()"/>
    <!-- Add predicate, if necessary -->
    <xsl:if test="count(../*[local-name()=local-name(current()) and
                             namespace-uri()=namespace-uri(current())]) > 1">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="count(preceding-sibling::*
              [local-name()=local-name(current()) and
               namespace-uri()=namespace-uri(current())]) + 1"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()" mode="xpath-step">
    <xsl:text>/text()</xsl:text>
    <xsl:if test="count(../text()) > 1">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="count(preceding-sibling::text()) + 1"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="processing-instruction()" mode="xpath-step">
    <xsl:text>/processing-instruction()</xsl:text>
    <xsl:if test="count(../processing-instruction()) > 1">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="count(
	                          preceding-sibling::processing-instruction()) + 1"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="comment()" mode="xpath-step">
    <xsl:text>/comment()</xsl:text>
    <xsl:if test="count(../comment()) > 1">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="count(preceding-sibling::comment()) + 1"/>
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@*" mode="xpath-step">
    <xsl:text>/@</xsl:text>
    <xsl:value-of select="name()"/>
  </xsl:template>
</xsl:stylesheet>
