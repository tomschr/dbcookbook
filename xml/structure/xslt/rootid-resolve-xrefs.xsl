<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:d="http://docbook.org/ns/docbook">
  
  <xsl:import href="rootid.xsl"/>
  
  <xsl:template name="xpointer.idref">
    <xsl:param name="xpointer">http://...</xsl:param>
    <xsl:choose>
      <xsl:when test="starts-with($xpointer, '#xpointer(id(')">
        <xsl:variable name="rest"
          select="substring-after($xpointer, '#xpointer(id(')"/>
        <xsl:variable name="quote" select="substring($rest, 1, 1)"/>
        <xsl:value-of
          select="substring-before(substring-after($xpointer, $quote), $quote)"
        />
      </xsl:when>
      <xsl:when test="starts-with($xpointer, '#')">
        <xsl:value-of select="substring-after($xpointer, '#')"/>
      </xsl:when>
      <!-- otherwise it's a pointer to some other document -->
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:xref" mode="process.root">
    <xsl:param name="xhref" select="@xlink:href"/>
    <!-- is the @xlink:href a local idref link? -->
    <xsl:param name="xlink.idref">
      <xsl:if test="starts-with($xhref,'#')
                    and (not(contains($xhref,'&#40;'))
                    or starts-with($xhref, '#xpointer&#40;id&#40;'))">
        <xsl:call-template name="xpointer.idref">
          <xsl:with-param name="xpointer" select="$xhref"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:param>
    <xsl:param name="xlink.targets" select="key('id',$xlink.idref)"/>
    <xsl:param name="linkend.targets" select="key('id',@linkend)"/>
    <xsl:param name="target" select="($xlink.targets | $linkend.targets)[1]"/>
    <xsl:param name="refelem" select="local-name($target)"/>
    
    <xsl:variable name="target.div"
      select="$target/ancestor-or-self::d:*[@xml:id = $rootid][1]"/>
    <xsl:variable name="this.div" 
      select="ancestor-or-self::d:*[@xml:id = $rootid][1]"/>
    
    <xsl:choose>
      <xsl:when test="$this.div = $target.div">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <phrase xmlns="http://docbook.org/ns/docbook" 
          remap="xref" role="{$xhref}">
          <xsl:apply-templates
            select="@*[local-name() != 'linkend']"
            mode="process.root"/>
          <xsl:apply-templates
            select="($target/ancestor-or-self::d:*[d:title])[last()]/d:title/node()"
            mode="process.root"/>
        </phrase>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>