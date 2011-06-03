<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY db "http://docbook.sourceforge.net/release/xsl-ns/current"> 
]>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:import href="&db;/profiling/profile.xsl"/>

<xsl:output indent="yes" method="xml"/>

<xsl:strip-space elements="d:*"/>
<xsl:preserve-space elements="d:abstract d:address d:appendix
  d:annotation
  d:bibliography d:bibliodiv d:biblioentry d:bibliolist 
  d:blockinfo d:blockquote d:book  
  d:calloutlist d:callout d:caution d:classsynopsis d:chapter d:cover
  d:dedication d:destructorsynopsis
  d:equation d:epigraph d:example
  d:figure d:fieldsynopsis
  d:imageobject d:informaltable d:informalfigure d:informalexample
  d:literallayout d:itemizedlist d:listitem
  d:mediaobject
  d:glossary d:glossdiv d:glossentry d:glosslist d:glossterm
  d:orderedlist 
  d:part d:preface d:programlisting d:para d:procedure 
  d:reference
  d:screen d:screenshot d:sect1 d:sect2 d:sect3 d:segmentedlist
  d:sidebar d:simplelist d:step d:textobject
  d:synopsis 
  d:table d:task d:tbody d:tgroup d:tfoot d:thead d:tip
  d:variablelist d:varlistentry
  d:warning"/>

<xsl:include href="&db;/common/common.xsl"/>
<xsl:include href="profile-tags.xsl"/>

<!-- Do profiling with this conditions: -->
<xsl:param name="profile.condition">without-example,normal</xsl:param>

</xsl:stylesheet>
