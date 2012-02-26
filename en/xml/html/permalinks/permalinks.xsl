<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="generate.permalink" select="1"/>
  <xsl:param name="permalink.text">¶</xsl:param>

  <xsl:template name="permalink">
    <xsl:param name="id"/>

    <xsl:if test="$generate.permalink != '0'">
      <span class="permalink">
        <a alt="Permalink" title="Permalink" href="#{$id}">
          <xsl:copy-of select="$permalink.text"/>
        </a>
      </span>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>