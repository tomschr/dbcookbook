<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  
  <xsl:attribute-set name="topic.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
  <xsl:attribute-set name="topic.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

  <xsl:param name="local.l10n.xml" select="document('../common/l10n.xml')"/>
</xsl:stylesheet>