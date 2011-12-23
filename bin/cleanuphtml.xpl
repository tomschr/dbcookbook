<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="cleanhtml"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:t="urn:x-toms:xproc:library"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils"
  xmlns:c="http://www.w3.org/ns/xproc-step">
  
  <p:import href="library-1.0.xpl"/>
  
  <p:input port="source"/>
  <p:output port="result" sequence="true">
    <!--<p:pipe port="result"/>-->
  </p:output>
  <p:option name="path" select="'../build/html/'"/>
    
  <p:directory-list name="buildhtml" 
    exclude-filter="[A-Z].*\.html$"
    include-filter="^.*\.html$">
    <p:with-option name="path" select="$path"/>
  </p:directory-list>
  
  <p:make-absolute-uris name="make-absolute-uris" 
    match="c:file/@name">
     <p:with-option name="base-uri" select="/c:directory/@xml:base"/>
  </p:make-absolute-uris>
  <p:string-replace name="filereplace"
    match="//c:file/@name" 
    replace="replace(., 'file:', 'file://')"> 
    <p:documentation>
      Fixes the URI from file:/ => file:// so that it can be used by 
      the p:http-request step.
    </p:documentation> 
  </p:string-replace>
  
  <!--<p:store name="save" href="dirlisting.out"/>-->
  <!--<p:identity name="identity">
    <p:input port="source">
      <p:pipe port="result" step="save"/>
    </p:input>
  </p:identity>-->
  
  <p:for-each name="forloop">
    <p:output port="result" sequence="true">
       <p:pipe port="result" step="write2file"/>
    </p:output>
    <p:iteration-source select="/c:directory/c:file"/>
    <p:variable name="file" select="/c:file/@name"/>

    <cx:message>
      <p:with-option name="message" select="$file"/>
    </cx:message>
    
    <p:load name="loadhtml">
        <p:with-option name="href" select="$file"/>
    </p:load>
    <!--
    <p:xslt name="xsltcleanup">
      <p:input port="source"/>
      <p:input port="stylesheet">
        <p:document href="../frameworks/xslt/misc/html2cleanhtml.xsl"/>
      </p:input>  
      <p:input port="parameters">
         <p:empty/>
      </p:input>
    </p:xslt>-->
    <p:store name="write2file">
      <p:with-option name="href" 
        select="concat('../build/html/chunks',$file)"/>
    </p:store>
  </p:for-each>
  
</p:declare-step>