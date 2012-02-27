<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY dbns "http://docbook.org/ns/docbook">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:param name="include.paths" select="1"/>
  <xsl:param name="include.copies" select="1"/>
  
  <xsl:template match="log">
    <revhistory xmlns="&dbns;">
      <xsl:apply-templates/>
    </revhistory>
  </xsl:template>
  
  <xsl:template match="logentry">
    <revhistory xmlns="&dbns;">
      <xsl:apply-templates select="@revision|*"/>
    </revhistory>
  </xsl:template>
  
  <xsl:template match="logentry/@revision">
    <revnumber xmlns="&dbns;">
      <xsl:apply-templates/>
    </revnumber>
  </xsl:template>
  
  <xsl:template match="tag">
    <revremark xmlns="&dbns;">
      <xsl:apply-templates/>
    </revremark>
  </xsl:template>
  
  <xsl:template match="date">
    <date xmlns="&dbns;">
      <xsl:apply-templates/>
    </date>
  </xsl:template>
  
  <xsl:template match="author">
    <xsl:variable name="firstname" select="substring-before(., ' ')"/>
    <xsl:variable name="surname" select="substring-after(., ' ')"/>
    <author xmlns="&dbns;">
      <personname>
        <firstname><xsl:value-of select="$firstname"/></firstname>
        <!--<othername></othername>-->
        <surname><xsl:value-of select="$surname"/></surname>
      </personname>
      <email><xsl:value-of select="@email"/></email>
    </author>
  </xsl:template>
  
  <xsl:template match="msg">
    <revdescription xmlns="&dbns;">
      <para>
        <xsl:apply-templates/>
      </para>
    </revdescription>
  </xsl:template>
  
  <xsl:template match="paths">
    <xsl:if test="$include.paths != 0">
      <itemizedlist xmlns="&dbns;">
        <title>Paths</title>
        <xsl:apply-templates/>
      </itemizedlist>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="path">
    <listitem xmlns="&dbns;">
      <para>
        <xsl:apply-templates select="@action|text()"/>
      </para>
    </listitem>    
  </xsl:template>
  
  <xsl:template match="path/@action">
    <xsl:text>[</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>] </xsl:text>
  </xsl:template>
  <xsl:template match="path/text()">
    <filename xmlns="&dbns;">
      <xsl:value-of select="."/>
    </filename>
  </xsl:template>

  <xsl:template match="copyies">
    <xsl:if test="$include.paths != 0">
      <listitem xmlns="&dbns;">
        <title>Copies</title>
        <para>
          <xsl:apply-templates select="@*|text()"/>
        </para>
      </listitem>
    </xsl:if>
  </xsl:template>
  <xsl:template match="copy">
    <listitem xmlns="&dbns;">
      <para>
        <xsl:apply-templates select="@*|text()"/>
      </para>
    </listitem>    
  </xsl:template>
  
  <xsl:template match="copy/@source">
    <filename xmlns="&dbns;">
      <xsl:value-of select="."/>
    </filename>
  </xsl:template>
  <xsl:template match="copy/text()">
    <xsl:text> -> </xsl:text>
    <filename xmlns="&dbns;">
      <xsl:value-of select="."/>
    </filename>
  </xsl:template>
  
</xsl:stylesheet>