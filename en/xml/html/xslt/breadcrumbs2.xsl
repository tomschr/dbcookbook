<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="d">

  <xsl:param name="breadcrumbs.separator" select="' > '"/>

  <xsl:template name="generate.breadcrumbs">
    <xsl:param name="node" select="."/>
    <xsl:if test="generate-id($node) != generate-id(/*)">
      <div class="breadcrumbs">
        <xsl:apply-templates select="$node/parent::*" mode="breadcrumbs">
          <xsl:with-param name="node" select="$node/parent::*"/>
          <xsl:with-param name="orig.node" select="$node"/>
        </xsl:apply-templates>
        <span class="breadcrumb-node">
          <xsl:apply-templates select="$node" mode="title.markup"/>
        </span>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*" mode="breadcrumbs">
    <xsl:param name="node"/>
    <xsl:param name="orig.node"/>

    <xsl:apply-templates select="$node/parent::*" mode="breadcrumbs">
      <xsl:with-param name="node" select="$node/parent::*"/>
      <xsl:with-param name="orig.node" select="$orig.node"/>
    </xsl:apply-templates>

    <span class="breadcrumb-link">
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="."/>
            <xsl:with-param name="context" select="$orig.node"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-templates select="$node" mode="title.markup"/>
      </a>
      <xsl:copy-of select="$breadcrumbs.separator"/>
    </span>
  </xsl:template>

</xsl:stylesheet>
