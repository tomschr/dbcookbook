<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">
  
  <xsl:template name="user.footer.content">
    <xsl:if test="$use.piwik != 0">
      <xsl:call-template name="generate.piwik"/>
    </xsl:if>
    
  </xsl:template>
  
  <xsl:template name="user.footer.navigation">
    <xsl:param name="prev" />
    <xsl:param name="next" />
    <script src="highlighter/prettify.js">/* */</script>
    <script>prettyPrint();</script>
  </xsl:template>
  
</xsl:stylesheet>