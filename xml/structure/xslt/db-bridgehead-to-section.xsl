<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"  
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="copy.xsl"/>
  
  <xsl:output indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="d:screen d:programlisting d:literallayout"/>
  
  <xsl:template match="d:section[d:bridgehead]">
    <!-- All nodes inside our section: -->
    <xsl:variable name="node1" select="node()"/>
    <!-- All nodes -->
    <xsl:variable name="node2" 
      select="d:bridgehead[1]|
              d:bridgehead[1]/following-sibling::node()"/>
    
    <!-- Copy our section with all attributes, apply the set difference
      and investigate the first bridgehead 
    -->
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="$node1[count(.|$node2) != count($node2)]"/>
      <xsl:apply-templates select="d:bridgehead[1]"/>
    </xsl:copy>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>
  
  <xsl:template match="d:bridgehead">
    <!-- All nodes who follow bridgeheads: -->
    <xsl:variable name="node1" 
      select="following-sibling::node()"/>
    <!-- All nodes who follow the next bridgehead including the next
         bridgehead.
         The next bridgehead element is included as we don't want it
         in the set difference:
    -->
    <xsl:variable name="node2"
      select="following-sibling::d:bridgehead[1]|
              following-sibling::d:bridgehead[1]/following-sibling::node()"/>   

    <!-- Create the section element with all attributes and apply
      standard rules for the diff set -->
    <xsl:element name="section">
      <xsl:copy-of select="@*"/>
      <xsl:text>&#10;  </xsl:text>
      <xsl:element name="title">
        <xsl:apply-templates select="node()"/>
      </xsl:element>
      <xsl:apply-templates select="$node1[count(.|$node2) != count($node2)]"/>
    </xsl:element>
    
    <!-- Process the next bridgehead -->
    <xsl:apply-templates select="following-sibling::d:bridgehead[1]"/>
  </xsl:template>
  
</xsl:stylesheet>