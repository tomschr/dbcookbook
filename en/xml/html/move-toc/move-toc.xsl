<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="d">
  
  <xsl:template match="d:book">
    <xsl:call-template name="id.warning"/>
    <div>
      <xsl:apply-templates select="." mode="common.html.attributes"/>
      <xsl:if test="$generate.id.attributes != 0">
        <xsl:attribute name="id">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="book.titlepage"/>
      
      <xsl:apply-templates select="d:dedication" 
        mode="dedication"/>
      <xsl:apply-templates select="d:acknowledgements"
        mode="acknowledgements"/>
      
      <xsl:variable name="toc.params">
        <xsl:call-template name="find.path.params">
          <xsl:with-param name="table" 
            select="normalize-space($generate.toc)"/> 
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:apply-templates/>

      <xsl:call-template name="make.lots">
        <xsl:with-param name="toc.params" select="$toc.params"/>
        <xsl:with-param name="toc">
          <xsl:call-template name="division.toc">
            <xsl:with-param name="toc.title.p"
              select="contains($toc.params, 'title')"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:template>
  
</xsl:stylesheet>