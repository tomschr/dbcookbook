<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook">

  <!-- Path and name of your graphic file-->
    <xsl:param name="img.src.path">graphic-pageheader/</xsl:param>
    <xsl:param name="header.image.filename">Opensource.svg</xsl:param>
    <!-- Header rule yes (1) / no (0) -->
    <xsl:param name="header.rule" select="0"/>

    <xsl:template name="header.content">
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="position" select="''"/>
        <xsl:param name="gentext-key" select="''"/>
        <fo:block>
            <!-- sequence can be odd, even, first, blank -->
            <!-- position can be left, center, right -->
            <xsl:choose>
                <xsl:when test="$sequence = 'blank'">
                    <!-- nothing -->
                </xsl:when>

                <xsl:when test="$position='left'">
                    <!-- Same for odd, even, empty, and blank sequences -->
                    <!-- nothing -->
                </xsl:when>

                <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
                    <!-- nothing -->
                </xsl:when>

                <xsl:when test="$position='center'">
                    <!-- nothing for empty and blank sequences -->
                </xsl:when>

                <xsl:when test="$position='right'">
                    <!-- Same for odd, even, empty, and blank sequences -->
                    <fo:external-graphic content-height="1in">
                       <xsl:attribute name="src">
                            <xsl:call-template name="fo-external-image">
                                <xsl:with-param name="filename" select="concat($img.src.path, $header.image.filename)"/>
                            </xsl:call-template>
                       </xsl:attribute>
                    </fo:external-graphic>
                </xsl:when>

                <xsl:when test="$sequence = 'first'">
                    <!-- nothing for first pages -->
                </xsl:when>

                <xsl:when test="$sequence = 'blank'">
                    <!-- nothing for blank pages -->
                </xsl:when>
            </xsl:choose>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
