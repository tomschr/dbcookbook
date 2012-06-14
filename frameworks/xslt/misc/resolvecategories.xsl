<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="copy.xsl"/>

  <xsl:output method="xml"/>
  
  <xsl:param name="category"/>
  <xsl:variable name="allsubjectterms" select="//d:subjectterm"/>
  <!--<xsl:key name="allsubjectterms" match="d:subjectterm" use=""/>-->
  
  
  <!--<xsl:template match="/">
    <xsl:apply-templates/>
    <!-\-<xsl:for-each select="$allsubjectterms[generate-id(.) =  generate-id(key('subjects', self::d:subjectterm))]">
      <xsl:sort select="key('subjects', .)"/>
      <xsl:value-of select="concat(., count($allsubjectterms[.=current()]), '&#10;')"/>
    </xsl:for-each>-\->
    <xsl:for-each select="$allsubjectterms[.=$cat]">
      <xsl:variable name="parent" select="ancestor::d:info/.."/>
      <xsl:value-of select="concat(' ', $parent/d:title, ' ', $parent/@xml:id, '&#10;')"/>      
    </xsl:for-each>
  </xsl:template>-->
  
  <!--<xsl:template match="d:subjectset">
    <xsl:variable name="title" select="../d:title|../../d:title"/>
    <xsl:variable name="subjects" select="d:subject/d:subjectterm[.=$cat]"/>
    
    <xsl:if test="count($subjects) > 0">
      <xsl:message>subject from <xsl:value-of select="$title"/></xsl:message>
    </xsl:if>
  </xsl:template>-->
  
  <xsl:template match="d:itemizedlist[@role='category']">
    <xsl:variable name="topic" select="ancestor::d:section[@remap='topic']"/>
    <xsl:variable name="maincategory" select="$topic/d:info//d:subjectterm[1]"/>
    <xsl:variable name="sbjcategories" select="$allsubjectterms[.=$maincategory]"/>
    
    <xsl:message>thistopic: <xsl:value-of select="concat($topic/@xml:id,
      ': ', count($allsubjectterms[.=$maincategory]) )"/></xsl:message>
    
    <xsl:if test="count($sbjcategories) > 0">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        
        <xsl:for-each select="$sbjcategories">
          <xsl:variable name="other" select="current()/ancestor::d:info/.."/>
          <!-- Only find other topics: -->
          <xsl:if test="$topic/@xml:id != $other/@xml:id">
            <xsl:message>topic: <xsl:value-of
              select="concat($other/d:title, ' ', $other/@xml:id)"/></xsl:message>
            <listitem>
              <para><xref linkend="{$other/@xml:id}"/></para>
            </listitem>
          </xsl:if>
        </xsl:for-each>    
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>