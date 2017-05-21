<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">
  
  <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="yes"/>
  
  <xsl:param name="appendixid">acronyms</xsl:param>
  <xsl:param name="docbookversion">5.0</xsl:param>
  
  <xsl:template match="/">
    <!-- The comment below appears in the output file-->
<xsl:comment>
 This file is dynamically generated at build time from a glossary file. 
 To change this file, make changes to the appropriate glossary.xml file. 
 In order to generate the acronyms file, any glossary entries with an 
 acronym tag must have an xml:id. 
</xsl:comment>
    <appendix version="{$docbookversion}">
      <xsl:if test="$appendixid != ''">
        <xsl:attribute name="xml:id">
          <xsl:value-of select="$appendixid"/>
        </xsl:attribute>
      </xsl:if>
      <title>Acronyms</title>
      <para> This appendix displays acronyms sorted alphabetically and 
        linked to their definition in the glossary. </para>
      <xsl:apply-templates select=".//d:glossary[1]"/>
    </appendix>
  </xsl:template>
  
  <xsl:template match="d:glossary">
    <itemizedlist remap="glossary">
      <xsl:apply-templates select="d:glossentry[d:acronym]">
        <xsl:sort select="d:acronym"/>
      </xsl:apply-templates>
    </itemizedlist>
  </xsl:template>
  
  <xsl:template match="d:glossentry[d:acronym]">
    <listitem>
      <xsl:apply-templates select="d:acronym"/>
    </listitem>
  </xsl:template>
  
  <xsl:template match="d:acronym">
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="(ancestor-or-self::d:*/@xml:id)[last()]">
          <xsl:value-of select="(ancestor-or-self::d:*/@xml:id)[last()]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message>No ID found!</xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
      <para>
        <xsl:copy>
          <xsl:if test="$id != ''">
            <xsl:attribute name="linkend">
              <xsl:value-of select="$id"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:attribute name="remap">acronym</xsl:attribute>
          <xsl:copy-of select="node()"/>
        </xsl:copy>
      </para>
  </xsl:template>
    
</xsl:stylesheet>