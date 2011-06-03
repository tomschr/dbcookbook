<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="d xlink">
  
  
  <xsl:template name="user.head.content">
    <xsl:param name="node" select="."/>
    <link 
      href='http://fonts.googleapis.com/css?family=Maven+Pro:regular,500,bold,900' 
      rel='stylesheet' type='text/css'/>
    <link
      href='http://fonts.googleapis.com/css?family=PT+Serif:regular,italic,bold,bolditalic' 
      rel='stylesheet' type='text/css'/>
    <link
    href='http://fonts.googleapis.com/css?family=Cousine:regular,italic,bold,bolditalic' 
    rel='stylesheet' type='text/css'/>
  </xsl:template>

</xsl:stylesheet>