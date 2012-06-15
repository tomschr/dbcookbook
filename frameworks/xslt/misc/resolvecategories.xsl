<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="copy.xsl"/>
  <xsl:output method="xml" indent="yes"/>  
  <xsl:variable name="allsubjectterms" select="//d:subjectterm"/>
    
  <xsl:template match="d:itemizedlist[@role='category']">
    <xsl:variable name="topic" select="ancestor::d:section[@remap='topic']"/>
    <xsl:variable name="maincategory" select="$topic/d:info//d:subjectterm[1]"/>
    <xsl:variable name="sbjcategories" select="$allsubjectterms[.=$maincategory]"/>
    
    <xsl:message>thistopic: <xsl:value-of select="concat($topic/@xml:id,
      ': ', count($allsubjectterms[.=$maincategory]) )"/></xsl:message>
    
    <xsl:if test="count($sbjcategories) > 0">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates/>
        <xsl:for-each select="$sbjcategories">
          <xsl:variable name="other" select="ancestor::d:info/.."/>
          <!-- Only find other topics: -->
          <xsl:if test="$topic/@xml:id != $other/@xml:id">
            <xsl:message>  topic: <xsl:value-of
              select="concat($other/d:title, ' (', $other/@xml:id, ')')"/></xsl:message>
            <listitem>
              <para><xref linkend="{$other/@xml:id}"/></para>
            </listitem>
          </xsl:if>
        </xsl:for-each>    
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>