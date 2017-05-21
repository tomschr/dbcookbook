<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % common.ent SYSTEM "../common/common.ent">
  %common.ent;
  <!ENTITY dbdir "../../db-xslt">
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="d">  
  
  <xsl:import href="&dbdir;/epub3/chunk.xsl"/>
  
  <xsl:param name="use.id.as.filename" select="1"/>
  <!--<xsl:param name="css.decoration" select="0"/>
  <xsl:param name="make.valid.html" select="1"/>-->
  <xsl:param name="img.src.path">img/</xsl:param>
  <xsl:param name="callout.graphics" select="0"/>
  <xsl:param name="callout.unicode" select="1"/>
  <!--<xsl:param name="epub.include.optional.metadata.dc.elements" select="0"/>-->
  
  <!--  -->
  <!--<xsl:template match="d:bibliosource" mode="opf.metadata">
    <xsl:element name="meta" namespace="{$opf.namespace}">
      <xsl:attribute name="property">dcterms:source</xsl:attribute>
      <xsl:value-of select="normalize-space(string(.))"/>
    </xsl:element>

    <!-\-<xsl:if test="$epub.include.optional.metadata.dc.elements != 0">
      <dc:source>
        <xsl:value-of select="normalize-space(string(.))"/>
      </dc:source>
    </xsl:if>-\->
  </xsl:template>-->
  
  
  <!--<xsl:template match="@rules|@frame|@border|@valign" mode="htmlTableAtt">
    <xsl:message>***** htmlTableAtt:<xsl:value-of select="local-name(.)"/></xsl:message>
  </xsl:template>-->
  
</xsl:stylesheet>