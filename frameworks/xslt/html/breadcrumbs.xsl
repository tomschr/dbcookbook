<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="d xlink">

  <xsl:template name="user.header.navigation">
    <xsl:if test="generate.breadcrumbs != 0">
      <xsl:call-template name="breadcrumbs"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="breadcrumbs">
    <xsl:param name="this.node" select="."/>
    <xsl:if test="parent::*">
    <div class="breadcrumbs">
      <xsl:for-each select="$this.node/ancestor::*">
        <span class="breadcrumb-link">
          <a>
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="."/>
                <xsl:with-param name="context" select="$this.node"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates select="." mode="title.markup"/>
          </a>
        </span>
        <xsl:copy-of select="$breadcrumbs.separator"/>
      </xsl:for-each>
      <!-- And display the current node, but not as a link -->
      <span class="breadcrumb-node">
        <xsl:apply-templates select="$this.node" mode="title.markup"/>
      </span>
    </div>
      </xsl:if>
  </xsl:template>




</xsl:stylesheet>
