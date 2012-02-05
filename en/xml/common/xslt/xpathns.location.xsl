<xsl:stylesheet version="1.0"
  xmlns:n="urn:x-toms:ns:namespaces"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="n">
  <namespaces xmlns="urn:x-toms:ns:namespaces">
    <ns prefix="d">http://docbook.org/ns/docbook</ns>
    <ns prefix="xi">http://www.w3.org/2001/XInclude</ns>
    <ns prefix="rdf">http://www.w3.org/1999/02/22-rdf-syntax-ns#</ns>
    <ns prefix="cc">http://creativecommons.org/ns#</ns>
    <ns prefix="svg">http://www.w3.org/2000/svg</ns>
  </namespaces>
  
  <xsl:variable name="nsnodes" select="document('')//n:namespaces/n:ns"/>
  
  <xsl:template name="xpath.location">
    <xsl:param name="node" select="."/>
    <xsl:param name="path" select="''"/>
    <xsl:param name="method">prefix</xsl:param>
    
    <xsl:message>xpath.location<xsl:value-of select="concat('(',
      local-name(.), '): ', '  ', 
      $path)"/>
    </xsl:message>
    
    <xsl:variable name="next.path">
      <xsl:choose>
        <xsl:when test="$method = 'prefix' and $nsnodes[namespace-uri($node) = .]">
          <xsl:value-of select="concat($nsnodes[namespace-uri($node) = .]/@prefix, ':')"/>
        </xsl:when>
        <!--<xsl:choose>
            <xsl:when test="namespace-uri($node) = '&dbns;'">d:</xsl:when>
            <xsl:when test="namespace-uri($node) = '&xins;'">xi:</xsl:when>
            <xsl:when test="namespace-uri($node) = '&rdfns;'">rdf:</xsl:when>
            <xsl:when test="namespace-uri($node) = '&ccns;'">cc:</xsl:when>
            <xsl:when test="namespace-uri($node) = '&svgns;'">svg:</xsl:when>            
          </xsl:choose>
        -->
        <xsl:when test="$method = 'clark'">
          <xsl:value-of select="concat('{', namespace-uri($node), '}')"/>
        </xsl:when>
      </xsl:choose>  
      <xsl:value-of select="local-name($node)"/>
      <xsl:if test="$path != ''">
        <xsl:text>/</xsl:text>
      </xsl:if>
      <xsl:value-of select="$path"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="$node/parent::*">
        <xsl:call-template name="xpath.location">
          <xsl:with-param name="node" select="$node/parent::*"/>
          <xsl:with-param name="path" select="$next.path"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('/', $next.path)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>