<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet
[
  <!--<!ENTITY db "http://docbook.sourceforge.net/release/xsl/current/xhtml">-->
  <!ENTITY db "../../db-xslt/xhtml5">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:exsl="http://exslt.org/common"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d db ng xlink exsl"
  extension-element-prefixes="exsl">

  <xsl:import href="&db;/chunk.xsl"/>
  <xsl:import href="docbook.xsl"/>
  <xsl:output method="xml"/>
  
  <!-- To use the same stripped nodeset everywhere, it should
       be created as a global variable here.
       Used by docbook.xsl, chunk-code.xsl and chunkfast.xsl
  -->
  <xsl:variable name="no.namespace">
    <xsl:if test="$exsl.node.set.available != 0 and 
                  (*/self::ng:* or */self::db:*)">
      <xsl:apply-templates select="/*" mode="stripNS"/>
    </xsl:if>
  </xsl:variable>
  
  <xsl:template name="user.footer.navigation">
    <div class="html5">
      <a href="http://www.w3.org/html/logo/"><img
        src="http://www.w3.org/html/logo/badge/html5-badge-h-css3-semantics.png"
        width="165" height="64" align="middle"
        alt="HTML5 Powered with CSS3 / Styling, and Semantics"
        title="HTML5 Powered with CSS3 / Styling, and Semantics"/></a>
      <span>HTML5 Logo by <a href="http://www.w3.org/"><abbr
        title="World Wide Web Consortium">W3C</abbr></a></span>
    </div>
  </xsl:template>
</xsl:stylesheet>
