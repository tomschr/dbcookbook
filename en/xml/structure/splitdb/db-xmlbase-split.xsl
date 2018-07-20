<?xml version="1.0" encoding="UTF-8"?>
<!--

-->
<xsl:stylesheet version="1.0"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/chunker.xsl"/>

 <xsl:param name="base.dir" select="'out/'"/>
 <xsl:param name="rootid"/>
 <xsl:param name="chunk.quietly" select="0"/>

 <xsl:param name="dbsplit.root.basename">index</xsl:param>
 <xsl:param name="dbsplit.ext">.xml</xsl:param>

 <!-- ================================================================== -->
 <xsl:template name="dirname">
  <xsl:param name="filename" select="''"/>
  <xsl:if test="contains($filename, '/')">
   <xsl:value-of select="substring-before($filename, '/')"/>
   <xsl:text>/</xsl:text><!-- separator -->
   <xsl:call-template name="dirname">
    <xsl:with-param name="filename" select="substring-after($filename, '/')"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

 <xsl:template name="basename">
  <!-- We assume all filenames are really URIs and use "/" -->
  <xsl:param name="filename"></xsl:param>
  <xsl:param name="recurse" select="false()"/>

  <xsl:choose>
   <xsl:when test="substring-after($filename, '/') != ''">
    <xsl:call-template name="basename">
     <xsl:with-param name="filename" select="substring-after($filename, '/')"/>
     <xsl:with-param name="recurse" select="true()"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$filename"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>


 <!-- ================================================================== -->
 <xsl:template match="node() | @*">
  <xsl:copy>
   <xsl:apply-templates select="@* | node()"/>
  </xsl:copy>
 </xsl:template>

 <!-- ================================================================== -->
 <xsl:template match="*" mode="xmlbase">
  <xsl:param name="path"/>

  <xsl:variable name="xbase" select="@xml:base"/>
  <xsl:variable name="dir">
   <xsl:variable name="tmp">
    <xsl:if test="$xbase">
     <xsl:call-template name="dirname">
      <xsl:with-param name="filename" select="$xbase"/>
     </xsl:call-template>
    </xsl:if>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="$tmp">
     <xsl:value-of select="concat($tmp, $path)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$path"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
<!--  <xsl:message>xmlbase mode:
  element <xsl:value-of select="concat(local-name(.), ' ', @xml:id)"/>
     path=<xsl:value-of select="$path"/></xsl:message>-->

  <xsl:choose>
   <xsl:when test="not(ancestor::*[1])">
    <xsl:value-of select="$path"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="ancestor::*[1]" mode="xmlbase">
     <xsl:with-param name="path" select="$dir"/>
    </xsl:apply-templates>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>


 <!-- ================================================================== -->

 <xsl:template name="get.filename">
  <xsl:param name="node" select="."/>

  <xsl:variable name="basename">
   <xsl:call-template name="basename">
    <xsl:with-param name="filename" select="$node/@xml:base"/>
   </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="dirs">
   <!--<xsl:call-template name="get.xml.base">
    <xsl:with-param name="node" select="$node"/>
   </xsl:call-template>-->
   <xsl:message>START</xsl:message>
   <xsl:apply-templates select="$node" mode="xmlbase"/>
   <xsl:message>END</xsl:message>
  </xsl:variable>

  <xsl:value-of select="concat($dirs, $basename)"/>
 </xsl:template>

 <xsl:template name="get.xml.base_toms">
  <xsl:param name="node" select="."/>
  <xsl:param name="path" select="''"/>

  <xsl:variable name="xmlbase" select="$node/@xml:base"/>
  <xsl:variable name="basename">
   <xsl:call-template name="basename">
    <xsl:with-param name="filename" select="$xmlbase"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="dirs">
   <xsl:message>start</xsl:message>
   <xsl:for-each select="$node/ancestor-or-self::*/@xml:base">
    <xsl:message>base=<xsl:value-of select="concat(name(..),'@', .)"/></xsl:message>
      <xsl:call-template name="dirname">
       <xsl:with-param name="filename" select="."/>
      </xsl:call-template>
   </xsl:for-each>
   <xsl:message>End</xsl:message>
  </xsl:variable>

 <xsl:value-of select="translate($dirs, '/', '-')"/>

<!--  <xsl:variable name="tmppath">
   <xsl:choose>
    <xsl:when test="$path = '' and $dir != ''">
     <xsl:value-of select="translate($dir, '/', '-')"/>
    </xsl:when>
    <xsl:when test="$path != '' and $dir != ''">
     <xsl:value-of select="concat($path, '-', $dir)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$path"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>

  <xsl:if test="$xmlbase">
   <xsl:message>get.xml.base (<xsl:value-of select="$xmlbase"/>)
    dir = "<xsl:value-of select="$dir"/>"
    path = "<xsl:value-of select="$path"/>"</xsl:message>
    <xsl:value-of select="$tmppath"/>
  </xsl:if>
  <xsl:if test="$node/..">
   <xsl:call-template name="get.xml.base">
    <xsl:with-param name="node" select="$node/.."/>
    <xsl:with-param name="path" select="$tmppath"/>
   </xsl:call-template>
  </xsl:if>-->
 </xsl:template>


 <xsl:template name="get.xml.base">
  <xsl:param name="node" select="."/>
  <xsl:param name="separator">.</xsl:param>
  <xsl:param name="path" select="''"/>
  <xsl:variable name="xmlbase" select="$node/@xml:base"/>
  <xsl:variable name="dir">
   <!--<xsl:call-template name="get_dirname">
    <xsl:with-param name="path_to_split" select="$xmlbase"/>
   </xsl:call-template>-->
   <xsl:call-template name="dirname">
    <xsl:with-param name="filename" select="$xmlbase"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="temp_path" select="concat($dir, $separator, $path)"/>

  <xsl:if test="$xmlbase != ''">
   <xsl:value-of select="$temp_path"/>
   <xsl:message> DIRNAME: <xsl:value-of select="$temp_path"/>
   </xsl:message>
  </xsl:if>
  <xsl:if test="$node/..">
   <xsl:call-template name="get.xml.base">
    <xsl:with-param name="node" select="$node/.."/>
    <xsl:with-param name="path" select="$temp_path"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>


 <!-- ================================================================== -->
 <xsl:template match="/*|*[@xml:base != '']">
  <xsl:variable name="dir">
<!--   <xsl:call-template name="get.filename"/>-->
   <xsl:apply-templates select="." mode="xmlbase"/>
  </xsl:variable>
  <xsl:variable name="basename">
   <xsl:call-template name="basename">
    <xsl:with-param name="filename" select="@xml:base"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="filename" select="concat($dir, $basename, $dbsplit.ext)"/>

  <xsl:call-template name="write.chunk">
   <xsl:with-param name="method">xml</xsl:with-param>
   <xsl:with-param name="filename">
    <xsl:choose>
     <xsl:when test="not(parent::*) and not(/*/@xml:base)">
      <xsl:value-of select="concat($base.dir, $dbsplit.root.basename, $dbsplit.ext)"/>
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
     <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
   </xsl:with-param>
  </xsl:call-template>
  <!--<xi:include href="{$filename}"/>-->
  <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
   <xsl:attribute name="href">
    <xsl:value-of select="$filename"/>
   </xsl:attribute>
  </xsl:element>
 </xsl:template>

</xsl:stylesheet>
