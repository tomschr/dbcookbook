<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="d">

<!-- 
  New elements:
  * acknowledgements
  * arc
  * annotation
  * cover
  * extendedlink
  * givenname
  * info
  * locator
  * org
  * tocdiv
  * topic
-->

  <xsl:import href="copy.xsl"/>
  
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="d:screen d:programlisting
    d:literallayout"/>
  
  
  <xsl:template match="@xml:id|@xml:lang|@xmlns"/>
  
  <xsl:template name="create-attribute">
    <xsl:param name="node" select="."/>
    <xsl:if test="$node/@xml:id">
      <xsl:attribute name="id">
        <xsl:value-of select="$node/@xml:id"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="$node/@xml:lang">
      <xsl:attribute name="lang">
        <xsl:value-of select="$node/@xml:lang"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="$node/@*[local-name() !='id' or
                                          local-name() != 'lang']"/>
  </xsl:template>
  
  <xsl:template match="d:*">
    <xsl:element name="{local-name()}">
      <xsl:call-template name="create-attribute"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="d:appendix/d:topic[d:section]
                       |d:chapter/d:topic[d:section]
                       |/d:topic[d:section]">
    <section remap="topic">
      <xsl:call-template name="create-attribute"/>
      <xsl:apply-templates select="d:info"/>
      <xsl:apply-templates select="node()[not(self::d:info)]"/>
    </section>
  </xsl:template>
  
  <xsl:template match="d:appendix/d:topic[d:section]/d:info
                       |d:chapter/d:topic[d:section]/d:info
                       |/d:topic[d:section]/d:info">
    <xsl:variable name="parent" select="local-name(..)"/>
    <sectioninfo remap="info">
      <xsl:call-template name="create-attribute"/>
      <xsl:apply-templates/>
    </sectioninfo>
  </xsl:template>
  
  <xsl:template match="d:info">
    <xsl:variable name="parent" select="local-name(..)"/>
    <xsl:element name="{$parent}info">
      <xsl:call-template name="create-attribute"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <!-- New DocBook v5.x elements -->
  <xsl:template match="d:acknowledgements|d:annotation|d:arc
                       |d:cover
                       |d:definitions
                       |d:extendedlink
                       |d:givenname
                       |d:locator
                       |d:org|d:tocdiv">
    <xsl:message>Don't know how to transfer <xsl:value-of select="local-name()"/></xsl:message>
  </xsl:template>
</xsl:stylesheet>