<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline version="1.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:d="http://docbook.org/ns/docbook">
  <p:xinclude/>
  <p:validate-with-relax-ng>
    <p:input port="schema">
      <p:document href="xml/5.1/dbref.rng"/>
    </p:input>
  </p:validate-with-relax-ng>
  
  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="frameworks/xslt/html/docbook.xsl"/>
    </p:input>
  </p:xslt>
</p:pipeline>