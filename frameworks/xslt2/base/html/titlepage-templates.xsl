<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:tmpl="http://docbook.org/xslt/titlepage-templates"
  xmlns:f="http://docbook.org/xslt/ns/extension"
  xmlns:t="http://docbook.org/xslt/ns/template"
  xmlns:m="http://docbook.org/xslt/ns/mode"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink tmpl m t f h l">
  
  <xsl:template name="t:user-titlepage-templates" as="element(tmpl:templates-list)?">
    <tmpl:templates-list>
      <tmpl:templates name="book">
        <tmpl:recto>
          <header tmpl:class="titlepage">
            <d:title/>
            <d:subtitle/>
            <d:author/>
            <d:pubdate/>
            <d:releaseinfo/>
            <d:legalnotice/>
            <!--<d:othercredit class="proofreader"/>-->
            <d:cover/>
            <d:revhistory/>          
            <d:abstract/>
            <d:annotation xml:id="draft"/>
          </header>
          <h:hr tmpl:keep="true"/>
        </tmpl:recto>
      </tmpl:templates>
      <tmpl:templates name="preface chapter appendix">
      <tmpl:titlepage>
        <header tmpl:class="titlepage">
          <d:title/>
          <d:subtitle/>
          <d:authorgroup/>
          <d:author/>
          <d:releaseinfo/>
          <d:abstract/>
          <d:revhistory/>
          <d:biblioid/>
        </header>
      </tmpl:titlepage>
     </tmpl:templates>
      <tmpl:templates name="section">
        <tmpl:titlepage>
          <div class="section-titlepage">
            <d:title/>
            <d:subtitle/>
            <d:authorgroup/>
            <d:author/>
            <d:othercredit/>
          </div>
        </tmpl:titlepage>
      </tmpl:templates>
    </tmpl:templates-list>
  </xsl:template>

</xsl:stylesheet>