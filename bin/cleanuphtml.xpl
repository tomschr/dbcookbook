<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="cleanhtml"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:t="urn:x-toms:xproc:library"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils"
  xmlns:c="http://www.w3.org/ns/xproc-step">
 <p:option name="debug" select="1" cx:type="1|0"/>
  
 <p:import href="xpl/library-1.0.xpl"/>
 <p:import href="xpl/tee.xpl"/>
  
  <p:input port="source">
    <p:empty/>
  </p:input>
  <!--<p:output port="result" sequence="true">
    <!-\-<p:pipe port="result"/>-\->
  </p:output>-->
  <p:option name="path" select="'../build/'"/>
  <p:option name="exclude-filter" select="'[A-Z].*\.html'"/>
  <p:option name="include-filter" select="'^.*\.html$'"/>

  <p:directory-list name="buildhtml">
    <p:with-option name="path" select="concat($path, 'tmp/')"/>
    <p:with-option name="exclude-filter" select="$exclude-filter"/>
    <p:with-option name="include-filter" select="$include-filter"/>
  </p:directory-list>
  <p:make-absolute-uris name="make-absolute-uris" match="c:file/@name">
     <p:with-option name="base-uri" select="/c:directory/@xml:base"/>
  </p:make-absolute-uris>
  <p:string-replace name="filereplace1"
    match="/c:directory/@xml:base" 
    replace="replace(., 'file:', 'file://')"> 
    <p:documentation>
      Fixes the URI from file:/ => file:// so that it can be used by 
      the p:http-request step.
    </p:documentation> 
  </p:string-replace>
  <p:string-replace name="filereplace2"
    match="/c:directory/c:file/@name" 
    replace="replace(., 'file:', 'file://')"> 
    <p:documentation>
      Fixes the URI from file:/ => file:// so that it can be used by 
      the p:http-request step.
    </p:documentation> 
  </p:string-replace>
    
  <cx:tee name="tee">
    <p:with-option name="debug" select="$debug"/>
    <p:with-option name="href" select="concat($path, 'tmp/dirlisting.xml')"/>
  </cx:tee>
  
  <p:for-each name="forloop">
    <p:iteration-source select="/c:directory/c:file"/>
    <p:variable name="absfile" select="/c:file/@name"/>
    <p:variable name="base" select="/c:directory/@xml:base"/>
    <p:variable name="file" select="tokenize($absfile, '/')[last()]">
      <p:documentation>
        <db:para>Extract only the filename</db:para>
      </p:documentation>
    </p:variable>
    
    <cx:message name="out">
      <p:with-option name="message" select="concat('*** Processing ', $file)"/>
    </cx:message>
    <p:load name="loadhtml">
      <p:with-option name="href" select="$absfile"/>
    </p:load>
    
    <p:xslt name="xsltcleanup">
      <p:input port="source"/>
      <p:input port="stylesheet">
        <p:document href="../frameworks/xslt/misc/html2cleanhtml.xsl"/>
      </p:input>  
      <p:input port="parameters">
         <p:empty/>
      </p:input>
    </p:xslt>
    
    <p:store name="write2file" omit-xml-declaration="false"
       indent="true">
      <p:with-option name="href" select="concat($path,'html/',$file)"/>
    </p:store>
  </p:for-each>
  
</p:declare-step>
