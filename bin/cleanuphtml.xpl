<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="1.0" name="cleanhtml"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:t="urn:x-toms:xproc:library"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:cxf="http://xmlcalabash.com/ns/extensions/fileutils"
  xmlns:c="http://www.w3.org/ns/xproc-step">
 
 <p:import href="library-1.0.xpl"/>
 
  <p:input port="source">
    <p:empty/>
  </p:input>
  <!--<p:output port="result" sequence="true">
    <!-\-<p:pipe port="result"/>-\->
  </p:output>-->
  <p:option name="path" select="'../build/html/'"/>
  <p:option name="exclude-filter" select="'[A-Z].*\.html'"/>
  <p:option name="include-filter" select="'^.*\.html$'"/>

  <p:directory-list name="buildhtml">
    <p:with-option name="path" select="$path"/>
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
    
  <!--<p:store name="save" href="dirlisting.out"/>-->
  
  <p:for-each name="forloop">
    <p:iteration-source select="/c:directory/c:file"/>
    <p:variable name="absfile" select="/c:file/@name"/>
    <p:variable name="base" select="/c:directory/@xml:base"/>
    <p:variable name="file" select="tokenize($absfile, '/')[last()]">
      <p:documentation>
        <db:para>Extract only the filename</db:para>
      </p:documentation>
    </p:variable>
    
    <p:load name="loadhtml">
        <p:with-option name="href" select="$absfile"/>
    </p:load>
    <cx:message name="out">
			<p:with-option name="message" select="concat('*** Processing ', $file)"/>
		</cx:message>
    
    <p:xslt name="xsltcleanup">
      <p:input port="source"/>
      <p:input port="stylesheet">
        <p:document href="../frameworks/xslt/misc/html2cleanhtml.xsl"/>
      </p:input>  
      <p:input port="parameters">
         <p:empty/>
      </p:input>
    </p:xslt>
    
    <p:store name="write2file">
      <p:with-option name="href" select="concat($path,'/chunks/',$file)"/>
    </p:store>
  </p:for-each>
  
</p:declare-step>