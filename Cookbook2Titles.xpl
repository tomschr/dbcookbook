<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="db2html-pipe"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:d="http://docbook.org/ns/docbook">
  <p:input port="source"/>
  <p:input port="stylesheet">
    <p:document href="frameworks/xslt/html/docbook.xsl"/>
  </p:input>
  <p:input port="parameters" kind="parameter"/>
  <p:output port="result">
    <p:pipe port="result" step="store"/>
  </p:output>
  <p:log port="result" href="cookbook2titles.log"/>
  
  <!--<p:variable name="titles" select="count(//d:title)"/>-->
    
  <p:xinclude name="xinclude">
    <p:input port="source">
      <p:pipe step="db2html-pipe" port="source"/>
    </p:input>
  </p:xinclude>
 
  <!--<p:xslt name="db2html" version="1.0">
    <p:input port="stylesheet">
      <p:pipe step="db2html-pipe" port="stylesheet"/>
    </p:input>
    <p:input port="parameters">
      <p:pipe step="db2html-pipe" port="parameters"/>
    </p:input>
  </p:xslt>-->
  
  <p:store name="store" href="xml/.DocBook-Cookbook.xml" indent="true"/>
  
  <p:exec name="dbsaxon" command="bin/dbsaxon"></p:exec>
  
</p:declare-step>