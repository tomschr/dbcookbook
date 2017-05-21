<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d">

  <xsl:param name="breadcrumbs.separator" select="' > '"/>

  <xsl:template name="generate.breadcrumbs">
    <xsl:param name="current.node" select="."/>
    <div class="breadcrumbs">
      <xsl:for-each select="$current.node/ancestor::*">
        <span class="breadcrumb-link">
          <a>
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="."/>
                <xsl:with-param name="context" select="$current.node"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates select="." mode="title.markup"/>
          </a>
        </span>
        <xsl:copy-of select="$breadcrumbs.separator"/>
      </xsl:for-each>
      <!-- Display the current node, but not as a link -->
      <span class="breadcrumb-node">
        <xsl:apply-templates select="$current.node" mode="title.markup"/>
      </span>
    </div>
  </xsl:template>
</xsl:stylesheet>
