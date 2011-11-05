<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="db2xhtml"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:t="urn:x-toms:xproc:library"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:c="http://www.w3.org/ns/xproc-step">
<p:documentation>
  <db:para>Pipeline for creating single XHTML output</db:para>
</p:documentation>

  <p:input port="source">
    <p:document href="../en/xml/DocBook-Cookbook.xml"/>
  </p:input>
  <p:input port="schema">
    <p:document href="../frameworks/rng/5.1/dbref.rng"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="../frameworks/xslt2/base/html/docbook.xsl"/>
  </p:input>
  <p:input port="parameters" kind="parameter"/>
  <p:output port="result">
    <p:pipe port="result" step="store"/>
  </p:output>
  <p:option name="outfile" select="'../build/html/DocBook-Cookbook2.html'"/>
  
  <p:import href="validate-xinclude-xslt2.xpl"/>
  
  <t:xinclude-rng-xslt2 name="xinclude-rng-xslt2">
    <p:input port="source">
      <p:pipe port="source" step="db2xhtml"/>
    </p:input>
    <p:input port="schema">
      <p:pipe port="schema" step="db2xhtml"/>
    </p:input>
    <p:input port="stylesheet">
      <p:pipe port="stylesheet" step="db2xhtml"/>
    </p:input>
    <p:input port="parameters">
      <p:pipe port="parameters" step="db2xhtml"/>
    </p:input>
  </t:xinclude-rng-xslt2>
  
  <p:store name="store" 
    method="xhtml" indent="true" 
    encoding="utf-8" omit-xml-declaration="false">
    <p:with-option name="href" select="$outfile"/>
  </p:store>
  
</p:declare-step>