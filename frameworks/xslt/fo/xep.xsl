<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template name="user-xep-pis">
  <xsl:processing-instruction name="xep-pdf-userprivileges">
    <xsl:text>print,modify,copy,annotate</xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-unicode-annotations">
    <xsl:text>true</xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-compress">
    <xsl:text>true</xsl:text>
  </xsl:processing-instruction>
  <!--<xsl:processing-instruction name="xep-pdf-pdf-x">
    <xsl:text>pdf-x-3</xsl:text>
    </xsl:processing-instruction>-->
  <xsl:processing-instruction name="xep-pdf-pdf-version">
    <xsl:text>1.5</xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-logical-page-numbering">
    <xsl:text>true</xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-initial-zoom">
    <xsl:text>fit-width</xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-userpassword">
    <xsl:text></xsl:text>
  </xsl:processing-instruction>
  <xsl:processing-instruction name="xep-pdf-userprivileges">
    <xsl:text>print,modify,copy,annotate</xsl:text>
  </xsl:processing-instruction>
</xsl:template>

</xsl:stylesheet>
