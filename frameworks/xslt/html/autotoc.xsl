<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template name="component.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>

    <xsl:call-template name="make.toc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
      <xsl:with-param name="nodes"
        select="d:section|d:sect1
                |d:topic
                |d:simplesect[$simplesect.in.toc != 0]
                |d:refentry
                |d:article|d:bibliography|d:glossary
                |d:appendix|d:index
                |d:bridgehead[not(@renderas)
                  and $bridgehead.in.toc != 0]
                |.//d:bridgehead[@renderas='sect1'
                  and $bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="d:part|d:reference" mode="toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="d:appendix|d:chapter|d:article
                |d:topic|d:index|d:glossary|d:bibliography
                |d:preface|d:reference|d:refentry
                |d:bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="d:preface|d:chapter|d:appendix|d:article|d:topic"
    mode="toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="d:section|d:sect1
                |d:simplesect[$simplesect.in.toc != 0]
                |d:refentry
                |d:glossary|d:bibliography|d:index
                |d:bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>

  <!--<xsl:template match="d:topic" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="d:sect1|d:bridgehead[$bridgehead.in.toc != 0]"
      />
    </xsl:call-template>
  </xsl:template>-->

  <xsl:template name="section.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>

    <xsl:call-template name="make.toc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
      <xsl:with-param name="nodes"
        select="d:topic|d:section|d:sect1|d:sect2|d:sect3|d:sect4|d:sect5|d:refentry
                           |d:bridgehead[$bridgehead.in.toc != 0]"/>

    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
