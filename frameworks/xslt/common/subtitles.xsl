<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="d xlink">

  <xsl:template match="d:topic" mode="subtitle.markup">
    <xsl:param name="allow-anchors" select="'0'"/>
    <xsl:apply-templates select="(d:info/d:subtitle|d:subtitle)[1]"
      mode="subtitle.markup">
      <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>
