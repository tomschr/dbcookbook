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
  
</xsl:stylesheet>