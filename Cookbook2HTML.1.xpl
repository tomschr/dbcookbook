<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="db2html-pipe"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:d="http://docbook.org/ns/docbook">
  <p:option name="schema"  select="'xml/5.1/dbref.rng'"/>
  <p:option name="stylesheet" select="'frameworks/xslt/html/docbook.xsl'"/>

  <p:xinclude name="include"/>

  <p:load name="load-schema">
    <p:with-option name="href" select="$schema"/>
  </p:load>

  <p:load name="load-stylesheet">
    <p:with-option name="href" select="$stylesheet"/>
  </p:load>

  <p:validate-with-relax-ng name="validate">
    <p:input port="source">
      <p:pipe step="include" port="result"/>
    </p:input>
    <p:input port="schema">
      <p:pipe step="load-schema" port="result"/>
    </p:input>
  </p:validate-with-relax-ng>

  <p:xslt name="db2html">
    <p:input port="stylesheet">
      <p:pipe step="load-stylesheet" port="result"/>
    </p:input>
  </p:xslt>

</p:declare-step>
