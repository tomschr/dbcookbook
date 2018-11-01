<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:d="http://docbook.org/ns/docbook">

 <!-- Path to your logo file -->
 <xsl:param name="logo.src.path">logo/</xsl:param>
 <!-- Name of your logo file -->
 <xsl:param name="header.image.filename">Opensource.svg</xsl:param>
 <!-- Header rule yes (1) / no (0) -->
 <xsl:param name="header.rule" select="0"/>

 <xsl:template name="header.table">
  [...]
 </xsl:template>

 <xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <fo:block>
   <xsl:choose>
    <xsl:when test="$pageclass = 'titlepage'">
    <!-- No footer on titlepages -->
    </xsl:when>
    <xsl:otherwise>
    <!-- Not a titlepage -->
     <xsl:choose>
      <xsl:when test="$double.sided = 0">
       <!-- Start single-sided -->
       <xsl:choose>
        <xsl:when test="$position = 'left'">
         <!-- Nothing or maybe a customer logo -->
         <fo:block>
          <xsl:apply-templates select="." mode="titleabbrev.markup"/>
         </fo:block>
        </xsl:when>
        <xsl:when test="$position = 'center'">
         <!-- Nothing -->
        </xsl:when>
        <xsl:when test="$position = 'right'">
         <fo:block>
          <fo:external-graphic content-height="10mm">
           <xsl:attribute name="src">
            <xsl:call-template name="fo-external-image">
             <xsl:with-param name="filename" select="concat($logo.src.path, 
                $header.image.filename)"/>
            </xsl:call-template>
           </xsl:attribute>
          </fo:external-graphic>
         </fo:block>
        </xsl:when>
       </xsl:choose>
      </xsl:when>
      <!-- End single-sided -->
      <xsl:otherwise>
       <!-- Start double-sided -->
       <xsl:choose>
        <xsl:when test="$position = 'left'">
         <xsl:choose>
          <xsl:when test="$sequence = 'even' or $sequence = 'blank'">
           <fo:block>
            <fo:external-graphic content-height="10mm">
             <xsl:attribute name="src">
              <xsl:call-template name="fo-external-image">
               <xsl:with-param name="filename" select="concat($logo.src.path, 
                   $header.image.filename)"/>
              </xsl:call-template>
             </xsl:attribute>
            </fo:external-graphic>
           </fo:block>
          </xsl:when>
          <xsl:otherwise>
           <!-- Start left (odd) -->
           <fo:block>
            <xsl:apply-templates select="." mode="titleabbrev.markup"/>
             </fo:block>
              <!-- Nothing -->
          </xsl:otherwise>
         </xsl:choose>
        </xsl:when>
        <!-- End left (odd) -->
        <xsl:when test="$position = 'center'">
         <!-- Nothing -->
        </xsl:when>
        <!-- Start right (even) -->
        <xsl:when test="$position = 'right'">
         <xsl:choose>
          <xsl:when test=" $sequence = 'even' or $sequence = 'blank'">
           <fo:block>
            <xsl:apply-templates select="." mode="titleabbrev.markup"/>
           </fo:block>
          </xsl:when>
          <xsl:otherwise>
           <fo:block>
            <fo:external-graphic content-height="10mm">
             <xsl:attribute name="src">
              <xsl:call-template name="fo-external-image">
               <xsl:with-param name="filename" select="concat($logo.src.path, 
                   $header.image.filename)"/>
              </xsl:call-template>
             </xsl:attribute>
            </fo:external-graphic>
           </fo:block>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:when>
       </xsl:choose>
      </xsl:otherwise>
     <!-- Double-sided -->
     </xsl:choose>
    </xsl:otherwise>
   <!--Not a title page-->
   </xsl:choose>
  </fo:block>
 </xsl:template>
</xsl:stylesheet>
