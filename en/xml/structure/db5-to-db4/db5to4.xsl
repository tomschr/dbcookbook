<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="d xi xlink exsl html">

  <xsl:import href="copy.xsl"/>
  
  <xsl:output method="xml" indent="yes" 
    doctype-public="-//OASIS//DTD DocBook XML V4.5//EN"
    doctype-system="http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space 
    elements="d:screen d:programlisting d:literallayout xi:*"/>
  <xsl:variable name="inlines">abbrev accel acronym alt anchor
    annotation application author biblioref citation citebiblioid
    citerefentry citetitle classname code command computeroutput
    constant coref database date editor email emphasis envar errorcode
    errorname errortext errortype exceptionname filename firstterm
    footnote footnoteref foreignphrase function glossterm guibutton
    guiicon guilabel guimenu guimenuitem guisubmenu hardware indexterm
    initializer inlineequation inlinemediaobject interfacename jobtitle
    keycap keycode keycombo keysym link literal markup menuchoice
    methodname modifier mousebutton nonterminal olink ooclass
    ooexception oointerface option optional org orgname package
    parameter person personname phrase productname productnumber prompt
    property quote remark replaceable returnvalue shortcut subscript
    superscript symbol systemitem tag termdef token trademark type uri
    userinput varname wordasword xref</xsl:variable>
  
  <!-- Overwrite standard template and create elements without 
       a namespace node
  -->
  <xsl:template match="d:*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>
    
  <xsl:template match="@xml:id|@xml:lang">
    <xsl:attribute name="{local-name()}">
      <xsl:apply-templates/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- Suppress the following attributes: -->
  <xsl:template match="@annotations|@version"/>
  <xsl:template match="@xlink:*"/>
  
  <xsl:template match="@xlink:href">
    <xsl:choose>
      <xsl:when test="contains($inlines, local-name(..))">
        <ulink url="{.}" remap="{local-name(..)}">
          <xsl:value-of select=".."/>
        </ulink>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>@xlink:href could not be processed!
  parent element: <xsl:value-of select="local-name(..)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:*[@xlink:href]">
    <xsl:choose>
      <xsl:when test="contains($inlines, local-name())">
        <ulink url="{@xlink:href}" remap="{local-name(.)}">
          <xsl:element name="{local-name()}">
            <xsl:apply-templates 
              select="@*[local-name() != 'href' and
                         namespace-uri() != 'http://www.w3.org/1999/xlink']
                      |node()"/>
          </xsl:element>
        </ulink>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{local-name()}">
          <xsl:apply-templates 
            select="@*[local-name() != 'href' and
                       namespace-uri() != 'http://www.w3.org/1999/xlink']
                    |node()"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="d:link/@xlink:href">
    <xsl:attribute name="url">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="d:link[@xlink:href]">
    <ulink>
      <xsl:apply-templates select="@*|node()"/>
    </ulink>
  </xsl:template>
  
  <xsl:template match="d:link[@linkend]">
    <link>
      <xsl:apply-templates select="@*|node()"/>
    </link>
  </xsl:template>
  
  <xsl:template match="d:appendix[d:info]
                      |d:article[d:info]
                      |d:bibliography[d:info]
                      |d:book[d:info]
                      |d:chapter[d:info]
                      |d:colophon[d:info]
                      |d:equation[d:info]
                      |d:glossary[d:info]
                      |d:index[d:info]
                      |d:legalnotice[d:info]
                      |d:part[d:info]
                      |d:partintro[d:info]
                      |d:preface[d:info]
                      |d:reference[d:info]
                      |d:refsect1[d:info]
                      |d:refsect2[d:info]
                      |d:refsect3[d:info]
                      |d:refsection[d:info]
                      |d:refsynopsisdiv[d:info]
                      |d:sect1[d:info]
                      |d:sect2[d:info]
                      |d:sect3[d:info]
                      |d:sect4[d:info]
                      |d:sect5[d:info]
                      |d:section[d:info]
                      |d:set[d:info]
                      |d:setindex[d:info]">
    <!-- Change order of info and title  -->
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="d:title/preceding-sibling::processing-instruction()
                                   |d:title/preceding-sibling::comment()"/>
      <xsl:apply-templates select="d:info"/>
      <xsl:apply-templates select="d:title"/>
      <!-- Process the rest -->
      <xsl:apply-templates select="d:info/following-sibling::node()"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="d:bibliolist[d:info]
                      |d:blockquote[d:info]
                      |d:equation[d:info]
                      |d:example[d:info]
                      |d:figure[d:info]
                      |d:glosslist[d:info]
                      |d:informalequation[d:info]
                      |d:informalexample[d:info]
                      |d:informalfigure[d:info]
                      |d:informaltable[d:info]
                      |d:itemizedlist[d:info]
                      |d:legalnotice[d:info]
                      |d:msgset[d:info]
                      |d:orderedlist[d:info]
                      |d:procedure[d:info]
                      |d:qandadiv[d:info]
                      |d:qandaentry[d:info]
                      |d:qandaset[d:info]
                      |d:table[d:info]
                      |d:task[d:info]
                      |d:taskprerequisites[d:info]
                      |d:taskrelated[d:info]
                      |d:tasksummary[d:info]
                      |d:variablelist[d:info]">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="d:title/preceding-sibling::processing-instruction()
                                   |d:title/preceding-sibling::comment()"/>
      <xsl:apply-templates select="d:info">
        <xsl:with-param name="infoname">block</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="d:title|
                                   d:title/following-sibling::processing-instruction()[1]
                                   |d:title/following-sibling::comment()[1]"/>
      
      <!-- Process the rest -->
      <xsl:apply-templates select="d:info/following-sibling::node()"/>
    </xsl:element>
  </xsl:template>


  <!-- Suppress other info elements who has no direct mapping -->
  <xsl:template match="d:*[d:info]"/>
  
  <xsl:template match="d:info">
    <xsl:param name="infoname" select="local-name(..)"/>
    <xsl:variable name="rtf-node">
      <xsl:element name="{$infoname}info">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="count(exsl:node-set($rtf-node)/*/*) > 0">
        <xsl:copy-of select="$rtf-node"/>
      </xsl:when>
      <xsl:otherwise><!-- Don't copy, it's empty --></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Renamed DocBook elements -->
  <xsl:template match="d:personblurb">
    <authorblurb>
      <xsl:apply-templates select="@*|node()"/>
    </authorblurb>
  </xsl:template>
  <xsl:template match="d:tag">
    <sgmltag>
      <xsl:apply-templates select="@*|node()"/>
    </sgmltag>
  </xsl:template>
  
  <!-- New DocBook v5.1 and HTML elements, no mapping available -->
  <xsl:template match="d:acknowledgements|d:annotation|d:arc
                       |d:cover
                       |d:definitions
                       |d:extendedlink
                       |d:givenname
                       |d:locator
                       |d:org|d:tocdiv
                       |html:*">
    <xsl:message>Don't know how to transfer "<xsl:value-of
      select="local-name()"/>" element into DocBook 4</xsl:message>
  </xsl:template>
  
</xsl:stylesheet>