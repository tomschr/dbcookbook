<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:param name="toc.personname.style"></xsl:param>

  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="depth" select="1"/>
    <xsl:param name="depth.from.context" select="8"/>

    <xsl:variable name="author" select="*/author[1]"/>

    <xsl:if test="$author">
      <span class="author">
        <xsl:choose>
          <xsl:when test="$toc.personname.style = 'family-given'">
            <xsl:call-template name="person.name.family-given">
              <xsl:with-param name="node" select="$author"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$toc.personname.style = 'last-first'">
            <xsl:call-template name="person.name.last-first">
              <xsl:with-param name="node" select="$author"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="person.name.first-last">
              <xsl:with-param name="node" select="$author"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>: </xsl:text>
      </span>
    </xsl:if>
    <span class="{local-name(.)}">
      <xsl:if test="$autotoc.label.in.hyperlink = 0">
        <xsl:variable name="label">
          <xsl:apply-templates select="." mode="label.markup"/>
        </xsl:variable>
        <xsl:copy-of select="$label"/>
        <xsl:if test="$label != ''">
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
      </xsl:if>

      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="context" select="$toc-context"/>
            <xsl:with-param name="toc-context" select="$toc-context"/>
          </xsl:call-template>
        </xsl:attribute>

        <xsl:if test="not($autotoc.label.in.hyperlink = 0)">
          <xsl:variable name="label">
            <xsl:apply-templates select="." mode="label.markup"/>
          </xsl:variable>
          <xsl:copy-of select="$label"/>
          <xsl:if test="$label != ''">
            <xsl:value-of select="$autotoc.label.separator"/>
          </xsl:if>
        </xsl:if>

        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
      </a>
    </span>
  </xsl:template>
</xsl:stylesheet>