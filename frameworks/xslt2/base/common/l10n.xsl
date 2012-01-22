<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
   xmlns:f="http://docbook.org/xslt/ns/extension"
   xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
   xmlns:t="http://docbook.org/xslt/ns/template"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xdmp="http://marklogic.com/xdmp"
   xmlns:mldb="http://docbook.github.com/ns/marklogic"
   exclude-result-prefixes="doc f l t xs xdmp mldb"
   extension-element-prefixes="xdmp">
  
  <xsl:template name="t:user-localization-data">
    <l:i18n>
      <l:l10n language="en" english-language-name="English">
        <l:gentext key="Difficulty" text="Difficulty: "/>
        <l:gentext key="Ticket" text="See also Ticket#"/>
        <l:context name="datetime">
          <l:template name="format" 
            text="[D01] [MNn,*-3] [Y0001], [H01]:[m] [Z]"/>
        </l:context>        
      </l:l10n>
    </l:i18n>
  </xsl:template>
  
</xsl:stylesheet>