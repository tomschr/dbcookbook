<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/chunker.xsl"/>
 <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/lib/lib.xsl"/>
 <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/common/common.xsl"/>

 <xsl:param name="base.dir" select="'out/'"/>
 <xsl:param name="rootid"/>
 <xsl:param name="chunk.quietly" select="0"/>

 <xsl:param name="dbsplit.root.basename">index</xsl:param>
 <xsl:param name="dbsplit.ext">.xml</xsl:param>

 <!-- ================================================================== -->
 <xsl:template match="node() | @*">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <!-- ================================================================== -->
 <xsl:template name="get.filename">
  <xsl:param name="node" select="."/>

  <xsl:value-of select="$node/@xml:base"/>
 </xsl:template>

 <!-- ================================================================== -->
 <xsl:template match="*[@xml:base != '']">
  <xsl:variable name="filename">
   <xsl:call-template name="get.filename"/>
  </xsl:variable>

  <xsl:call-template name="write.chunk">
   <xsl:with-param name="method">xml</xsl:with-param>
   <xsl:with-param name="filename">
    <xsl:choose>
     <xsl:when test="not(parent::*)">
      <xsl:value-of select="concat($base.dir, $dbsplit.root.filename, $dbsplit.ext)"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="concat($base.dir, $filename)"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:with-param>
   <xsl:with-param name="indent" select="'yes'"/>
   <xsl:with-param name="encoding">UTF-8</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:copy-of select="preceding-sibling::processing-instruction() |
                         preceding-sibling::comment()"/>
    <xsl:copy>
     <xsl:apply-templates/>
    </xsl:copy>
   </xsl:with-param>
  </xsl:call-template>
  <xi:include href="{$filename}"/>
 </xsl:template>

 <xsl:template match="/*"><!-- [not(@xml:base)] -->
  <xsl:call-template name="write.chunk">
   <xsl:with-param name="method">xml</xsl:with-param>
   <xsl:with-param name="filename" select="concat($base.dir, $dbsplit.root.basename, $dbsplit.ext)"/>
   <xsl:with-param name="indent" select="'yes'"/>
   <xsl:with-param name="encoding">UTF-8</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:copy>
     <xsl:copy-of select="/processing-instruction() | /comment()"/>
     <xsl:apply-templates />
    </xsl:copy>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
</xsl:stylesheet>
