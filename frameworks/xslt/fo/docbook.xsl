<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % common.ent SYSTEM "../common/common.ent">
  %common.ent;
]>
<xsl:stylesheet version="1.0"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Import the current version of the DocBook NS stylesheets  -->
<xsl:import href="&dburi;/fo/docbook.xsl"/>

<!--<xsl:include href="attributesets.xsl"/>-->
<xsl:include href="param.xsl"/>
<!--<xsl:include href="fonts.xsl"/>-->
<xsl:include href="xep.xsl"/>

</xsl:stylesheet>
