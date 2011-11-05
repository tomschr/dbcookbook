<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="main" type="t:xinclude-rng-xslt2"
  xmlns:t="urn:x-toms:xproc:library"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:err="http://www.w3.org/ns/xproc-error">
  <p:documentation>
    <db:para>      
    </db:para>
  </p:documentation>

  <p:input port="source" primary="true"/>
  <p:input port="schema"/>
  <p:input port="stylesheet"/>
  <p:input port="parameters" kind="parameter"/>

  <p:output port="result">
    <p:pipe step="transform" port="result"/>
  </p:output>
  
  <p:xinclude name="xinclude">
    <p:input port="source">
      <p:pipe step="main" port="source"/>
      
    </p:input>
  </p:xinclude>

  <p:validate-with-relax-ng name="rng-validate">
    <p:input port="source">
      <p:pipe step="xinclude" port="result"/>
    </p:input>
    <p:input port="schema">
      <p:pipe step="main" port="schema"/>
    </p:input>
  </p:validate-with-relax-ng>

  <p:xslt name="transform" version="2.0">
    <p:input port="source">
      <p:pipe step="rng-validate" port="result"/>
    </p:input>
    <p:input port="stylesheet">
      <p:pipe step="main" port="stylesheet"/>
    </p:input>
    <p:input port="parameters">
      <p:pipe step="main" port="parameters"/>
    </p:input>
  </p:xslt>

</p:declare-step>