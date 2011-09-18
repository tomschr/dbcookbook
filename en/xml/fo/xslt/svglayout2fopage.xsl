<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:u="urn:x-toms:svg-units"
  exclude-result-prefixes="svg u">
  
  <xsl:param name="master-name">page</xsl:param>
  <xsl:output indent="yes"/>

  <u:units> 
    <!--http://www.w3.org/TR/SVG11/coords.html#Units-->
    <!-- All values are in mm -->
    <u:unit key="mm">1</u:unit>
    <u:unit key="px">0.2822222</u:unit>
    <u:unit key="pc">4.2333330</u:unit>
    <u:unit key="pt">0.35277775</u:unit>
    <u:unit key="cm">10</u:unit>
    <u:unit key="in">25.3999980</u:unit>
  </u:units>
  
  <xsl:variable name="unittab" select="document('')/*/u:units/u:unit"/>

  <xsl:template name="coord-sub">
    <!-- Calculates result = A - B -->
    <xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:param name="withunit" select="true()"/>
    
    <xsl:variable name="_a">
      <xsl:choose>
        <xsl:when test="string(number($a)) != 'NaN'">
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="concat(string($a), 'px')"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="$a"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="_b">
      <xsl:choose>
        <xsl:when test="string(number($b)) != 'NaN'">
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="concat(string($b), 'px')"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="$b"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="$_a - $_b"/>
    <xsl:if test="$withunit">
       <xsl:text>mm</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="coord-3sub">
    <!-- Calculates result = A - B - C -->
    <xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:param name="c"/>
    <xsl:param name="withunit" select="true()"/>
    
    <xsl:variable name="_a">
      <xsl:choose>
        <xsl:when test="string(number($a)) != 'NaN'">
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="concat(string($a), 'px')"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="$a"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="_b">
      <xsl:choose>
        <xsl:when test="string(number($b)) != 'NaN'">
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="concat(string($b), 'px')"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="$b"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="_c">
      <xsl:choose>
        <xsl:when test="string(number($c)) != 'NaN'">
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="concat(string($c), 'px')"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="unit2mm">
            <xsl:with-param name="unit" select="$c"/>
            <xsl:with-param name="withunit" select="false()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="$_a - $_b - $_c"/>
    <xsl:if test="$withunit">
       <xsl:text>mm</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="unit2mm">
    <xsl:param name="unit" select="."/>
    <xsl:param name="withunit" select="true()"/>
    
    <!--<xsl:message>*** unit2mm: <xsl:value-of 
      select="concat($unit, '::', number($unit))"/>
    </xsl:message>-->
    
    <xsl:choose>
      <xsl:when test="string(number($unit)) = 'NaN'">
        <xsl:variable name="v" select="substring($unit, 1,
          string-length($unit)-2)"/>
        <xsl:variable name="u" select="substring($unit,
          string-length($unit)-1, 2)"/>
        <xsl:message>   
  unit=<xsl:value-of select="concat($v, $u)"/> => <xsl:value-of 
           select="concat($v * $unittab[@key=$u], 'mm')"/>
        </xsl:message>
        <xsl:value-of select="$v * $unittab[@key=$u]"/>
        <xsl:if test="$withunit">
          <xsl:text>mm</xsl:text>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$unit * $unittab[@key='px']"/>
        <xsl:if test="$withunit">
          <xsl:text>mm</xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- ======================================================== 
     Template Rules
-->

  <xsl:template match="svg:svg">
    <xsl:message>svg:svg unittab=<xsl:value-of select="count($unittab)"/>
    </xsl:message>
    <xsl:variable name="pageheight">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@height"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="pagewidth">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@width"/>
      </xsl:call-template>
    </xsl:variable>
    
    <fo:layout-master-set>
      <fo:simple-page-master master-name="{$master-name}"
        page-height="{$pageheight}" page-width="{$pagewidth}">
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates select=".//svg:rect[@id='body']"/>
        <xsl:apply-templates select=".//svg:rect[@id='header']"/>
        <xsl:apply-templates select=".//svg:rect[@id='footer']"/>
      </fo:simple-page-master>
    </fo:layout-master-set>
  </xsl:template>

  <xsl:template match="svg:svg/@*"/>
  
  <xsl:template match="svg:svg/@width">
    <xsl:attribute name="page-width">
      <xsl:call-template name="unit2mm"/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="svg:svg/@height">
    <xsl:attribute name="page-height">
      <xsl:call-template name="unit2mm"/>
    </xsl:attribute>
  </xsl:template>
  
  
  <xsl:template match="svg:rect[@id='body']">
    <xsl:variable name="margin-top">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@y"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="margin-bottom">
      <xsl:call-template name="coord-3sub">
        <xsl:with-param name="a" select="/svg:svg/@height"/>
        <xsl:with-param name="b" select="@height"/>
        <xsl:with-param name="c" select="@y"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="margin-left">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@x"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="margin-right">
      <xsl:call-template name="coord-3sub">
        <xsl:with-param name="a" select="/svg:svg/@width"/>
        <xsl:with-param name="b" select="@width"/>
        <xsl:with-param name="c" select="@x"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:message>svg:rect[@id='body']
    x,y = <xsl:value-of select="concat('(', @x, ',', @y, ')')"/>
    width,height = <xsl:value-of select="concat('(', @width, ',',
      @height, ')')"/>
    margin-top = <xsl:value-of select="$margin-top"/>
    </xsl:message>
    
    <fo:region-body 
      margin-top="{$margin-top}"  margin-bottom="{$margin-bottom}"
      margin-left="{$margin-left}" margin-right="{$margin-right}"/>
  </xsl:template>
  
  <xsl:template match="svg:rect[@id='header']">
    <xsl:variable name="extend">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@height"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:message>svg:rect[@id='header']:
      extend = <xsl:value-of select="$extend"/>
    </xsl:message>
    <fo:region-before extent="{$extend}"/>
  </xsl:template>
  
  <xsl:template match="svg:rect[@id='footer']">
    <xsl:variable name="extend">
      <xsl:call-template name="unit2mm">
        <xsl:with-param name="unit" select="@height"/>
      </xsl:call-template>
    </xsl:variable>
    <fo:region-after extent="{$extend}"/>
  </xsl:template>
  
</xsl:stylesheet>