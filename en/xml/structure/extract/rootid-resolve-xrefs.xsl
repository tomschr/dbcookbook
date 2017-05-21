<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:d="http://docbook.org/ns/docbook">
  
  <xsl:import href="rootid.xsl"/>
  
  <xsl:template match="d:xref" mode="process.root">
    <xsl:variable name="xhref" select="@xlink:href"/>
    <!-- is the @xlink:href a local idref link? -->
    <xsl:variable name="xlink.idref">
      <xsl:choose>
        <xsl:when test="starts-with($xhref,'#')">
          <xsl:value-of select="substring($xhref, 2)"/>
        </xsl:when>
        <xsl:when test="contains($xhref, '://')">
         <xsl:message>
            <xsl:text>ERROR: Don't know what do do with @xlink:href: </xsl:text>
            <xsl:value-of select="$xhref"/></xsl:message> 
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="xlink.targets" select="key('id',$xlink.idref)"/>
    <xsl:variable name="linkend.targets" select="key('id',@linkend)"/>
    <xsl:variable name="target" select="($xlink.targets | $linkend.targets)[1]"/>
    <xsl:variable name="refelem" select="local-name($target)"/>
    
    <xsl:variable name="this.div" 
      select="ancestor-or-self::d:*[@xml:id = $rootid][1]"/>
    <xsl:variable name="target.div"
      select="$target/ancestor-or-self::d:*[@xml:id = $rootid][1]"/>

    <xsl:choose>
      <xsl:when test="generate-id($this.div) = generate-id($target.div)">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <phrase xmlns="http://docbook.org/ns/docbook" remap="xref">
          <xsl:choose>
            <xsl:when test="@linkend">
              <xsl:attribute name="role">
                <xsl:value-of select="@linkend"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:when test="$xlink.idref != ''">
              <xsl:attribute name="role">
                <xsl:value-of select="$xlink.idref"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="role">
                <xsl:value-of select="$xhref"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates
            select="@*[local-name() != 'linkend' and
                       local-name() != 'href']"
            mode="process.root"/>
          <xsl:apply-templates
            select="($target/ancestor-or-self::d:*[d:title])[last()]/d:title/node()"
            mode="process.root"/>
        </phrase>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
