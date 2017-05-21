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
  
  <p:option name="MAIN" select="'../en/xml/DocBook-Cookbook.xml'">
    <p:documentation>
      <db:para>Main file which contains everything.</db:para>
    </p:documentation>
  </p:option>
  <p:option name="rngschema" select="'../frameworks/rng/5.1/dbref.rng'">
    <p:documentation>
      <db:para>The RELAX NG file to validate.</db:para>
    </p:documentation>
  </p:option>
  <p:option name="stylesheet" select="'../frameworks/xslt2/base/html/docbook.xsl'">
    <p:documentation>
      <db:para>The DocBook XSLT2 stylesheet to create a single HTML file</db:para>
    </p:documentation>
  </p:option>
  <p:option name="outfile" select="'../build/html/DoCookBook.html'">
    <p:documentation>
      <db:para>The filename where to save the result HTML file</db:para>
    </p:documentation>
  </p:option>
  
  <!--<p:input port="source">
    <p:document href="../en/xml/DocBook-Cookbook.xml"/>
  </p:input>
  <p:input port="rngschema">
    <p:document href="../frameworks/rng/5.1/dbref.rng"/>
  </p:input>
  <p:input port="stylesheet">
    <p:document href="../frameworks/xslt2/base/html/docbook.xsl"/>
  </p:input>
  -->
  <p:input port="parameters" kind="parameter"/>
  
  <p:load name="load-main">
    <p:with-option name="href" select="$MAIN"/>
  </p:load>
  <p:load name="load-schema">
    <p:with-option name="href" select="$rngschema"/>
  </p:load>
  <p:load name="load-xslt">
    <p:with-option name="href" select="$stylesheet"/>
  </p:load>
  
  <p:import href="xpl/validate-xinclude-xslt2.xpl"/>
  
  <t:xinclude-rng-xslt2 name="xinclude-rng-xslt2">
    <p:input port="source">
      <p:pipe port="result" step="load-main"/>
    </p:input>
    <p:input port="schema">
      <p:pipe port="result" step="load-schema"/>
    </p:input>
    <p:input port="stylesheet">
      <p:pipe port="result" step="load-xslt"/>
    </p:input>
    <p:input port="parameters">
      <p:pipe port="parameters" step="db2xhtml"/>
    </p:input>
  </t:xinclude-rng-xslt2>
  
  <p:store name="store-html" 
    method="xhtml" indent="true" 
    encoding="utf-8" omit-xml-declaration="false">
    <p:with-option name="href" select="$outfile"/>
  </p:store>
  
</p:declare-step>
