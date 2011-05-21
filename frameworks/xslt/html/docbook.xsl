<?xml version="1.0"?>
<xsl:stylesheet version="1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:import
    href="http://docbook.sourceforge.net/release/xsl-ns/current/html/docbook.xsl"/>
  <xsl:include href="topic.titlepage.xsl"/>

  <xsl:template match="d:topic">
    <xsl:variable name="depth" select="1"/>

    <xsl:call-template name="id.warning"/>
    <div>
      <xsl:call-template name="common.html.attributes">
        <xsl:with-param name="inherit" select="1"/>
      </xsl:call-template>
      <xsl:call-template name="topic.titlepage"/>
      <xsl:variable name="toc.params">
        <xsl:call-template name="find.path.params">
          <xsl:with-param name="table"
            select="normalize-space($generate.toc)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if
        test="contains($toc.params, 'toc')
                  and $depth &lt;= $generate.section.toc.level">
        <xsl:call-template name="section.toc">
          <xsl:with-param name="toc.title.p"
            select="contains($toc.params, 'title')"/>
        </xsl:call-template>
        <xsl:call-template name="section.toc.separator"/>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:call-template name="process.chunk.footnotes"/>
    </div>
  </xsl:template>

  <xsl:template match="d:topic/d:title|d:topic/d:info/d:title"
                mode="titlepage.mode"
                priority="2">
    <!-- the context node should be the title of a section when called -->
    <xsl:variable name="section" select="ancestor::d:topic"/>

    <xsl:call-template name="section.heading">
      <xsl:with-param name="section" select="$section"/>
      <xsl:with-param name="level" select="1"/>
      <xsl:with-param name="title">
        <xsl:apply-templates select="$section"
          mode="object.title.markup">
          <xsl:with-param name="allow-anchors" select="1"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="d:topic/d:title"/>

</xsl:stylesheet>
