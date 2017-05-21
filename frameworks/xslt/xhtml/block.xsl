<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">

<xsl:template match="revhistory|d:revhistory">
  <!--<xsl:message>**** d:revhistory</xsl:message>-->
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <table border="0" width="100%" summary="Revision history x">
      <tbody>
      <tr>
        <th colspan="3">
          <span class="title">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
          </span>
        </th>
      </tr>
      <xsl:apply-templates/>
      </tbody>
    </table>
  </div>
</xsl:template>
  
<xsl:template match="revhistory/revision|d:revhistory/d:revision">
  <xsl:variable name="revnumber" select="revnumber|d:revnumber"/>
  <xsl:variable name="revdate"   select="date|d:date"/>
  <xsl:variable name="revauthor" select="authorinitials|author
                                         |d:authorinitials|d:author"/>
  <xsl:variable name="revremark" select="revremark|revdescription
                                         |d:revremark|d:revdescription"/>
  <tr class="revision">
    <td class="revnumber">
      <xsl:if test="$revnumber">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Revision'"/>
        </xsl:call-template>
        <xsl:call-template name="gentext.space"/>
        <xsl:apply-templates select="$revnumber"/>
      </xsl:if>
    </td>
    <td class="date">
      <xsl:apply-templates select="$revdate"/>
    </td>
    <xsl:choose>
      <xsl:when test="count($revauthor)=0">
        <td class="author">
          <xsl:call-template name="dingbat">
            <xsl:with-param name="dingbat">nbsp</xsl:with-param>
          </xsl:call-template>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td class="author">
          <xsl:for-each select="$revauthor">
            <xsl:apply-templates select="."/>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </tr>
  <xsl:if test="$revremark">
    <tr class="revdescription">
      <td>&amp;nbsp;</td>
      <td class="revdescription" colspan="2">
        <xsl:apply-templates select="$revremark"/>
      </td>
    </tr>
  </xsl:if>
</xsl:template>
  

</xsl:stylesheet>