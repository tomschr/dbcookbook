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
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="gentext-key" select="''"/>

        <!-- default is a single table style for all headers -->
        <!-- Customize it for different page classes or sequence location -->

        <xsl:variable name="column1">
            <xsl:choose>
                <xsl:when test="$double.sided = 0">1</xsl:when>
                <xsl:when test="$sequence = 'first' or $sequence = 'odd'"
                    >1</xsl:when>
                <xsl:otherwise>3</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="column3">
            <xsl:choose>
                <xsl:when test="$double.sided = 0">3</xsl:when>
                <xsl:when test="$sequence = 'first' or $sequence = 'odd'"
                    >3</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="candidate">
            <fo:table xsl:use-attribute-sets="header.table.properties">
                <xsl:call-template name="head.sep.rule">
                    <xsl:with-param name="pageclass" select="$pageclass"/>
                    <xsl:with-param name="sequence" select="$sequence"/>
                    <xsl:with-param name="gentext-key" select="$gentext-key"/>
                </xsl:call-template>

                <fo:table-column column-number="1">
                    <xsl:attribute name="column-width">
                        <xsl:text>proportional-column-width(</xsl:text>
                        <xsl:call-template name="header.footer.width">
                            <xsl:with-param name="location"
                                >header</xsl:with-param>
                            <xsl:with-param name="position" select="$column1"/>
                            <xsl:with-param name="pageclass" select="$pageclass"/>
                            <xsl:with-param name="sequence" select="$sequence"/>
                            <xsl:with-param name="gentext-key"
                                select="$gentext-key"/>
                        </xsl:call-template>
                        <xsl:text>)</xsl:text>
                    </xsl:attribute>
                </fo:table-column>
                <fo:table-column column-number="2">
                    <xsl:attribute name="column-width">
                        <xsl:text>proportional-column-width(</xsl:text>
                        <xsl:call-template name="header.footer.width">
                            <xsl:with-param name="location"
                                >header</xsl:with-param>
                            <xsl:with-param name="position" select="2"/>
                            <xsl:with-param name="pageclass" select="$pageclass"/>
                            <xsl:with-param name="sequence" select="$sequence"/>
                            <xsl:with-param name="gentext-key"
                                select="$gentext-key"/>
                        </xsl:call-template>
                        <xsl:text>)</xsl:text>
                    </xsl:attribute>
                </fo:table-column>
                <fo:table-column column-number="3">
                    <xsl:attribute name="column-width">
                        <xsl:text>proportional-column-width(</xsl:text>
                        <xsl:call-template name="header.footer.width">
                            <xsl:with-param name="location"
                                >header</xsl:with-param>
                            <xsl:with-param name="position" select="$column3"/>
                            <xsl:with-param name="pageclass" select="$pageclass"/>
                            <xsl:with-param name="sequence" select="$sequence"/>
                            <xsl:with-param name="gentext-key"
                                select="$gentext-key"/>
                        </xsl:call-template>
                        <xsl:text>)</xsl:text>
                    </xsl:attribute>
                </fo:table-column>

                <fo:table-body>
                    <fo:table-row>
                        <xsl:attribute
                            name="block-progression-dimension.minimum">
                            <xsl:value-of select="$header.table.height"/>
                        </xsl:attribute>
                        <fo:table-cell text-align="start" display-align="center">
                            <xsl:if test="$fop.extensions = 0">
                                <xsl:attribute name="relative-align"
                                    >baseline</xsl:attribute>
                            </xsl:if>
                            <fo:block>
                                <xsl:call-template name="header.content">
                                    <xsl:with-param name="pageclass"
                                        select="$pageclass"/>
                                    <xsl:with-param name="sequence"
                                        select="$sequence"/>
                                    <xsl:with-param name="position"
                                        select="$direction.align.start"/>
                                    <xsl:with-param name="gentext-key"
                                        select="$gentext-key"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="center"
                            display-align="center">
                            <xsl:if test="$fop.extensions = 0">
                                <xsl:attribute name="relative-align"
                                    >baseline</xsl:attribute>
                            </xsl:if>
                            <fo:block>
                                <xsl:call-template name="header.content">
                                    <xsl:with-param name="pageclass"
                                        select="$pageclass"/>
                                    <xsl:with-param name="sequence"
                                        select="$sequence"/>
                                    <xsl:with-param name="position"
                                        select="'center'"/>
                                    <xsl:with-param name="gentext-key"
                                        select="$gentext-key"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right" display-align="center">
                            <xsl:if test="$fop.extensions = 0">
                                <xsl:attribute name="relative-align"
                                    >baseline</xsl:attribute>
                            </xsl:if>
                            <fo:block>
                                <xsl:call-template name="header.content">
                                    <xsl:with-param name="pageclass"
                                        select="$pageclass"/>
                                    <xsl:with-param name="sequence"
                                        select="$sequence"/>
                                    <xsl:with-param name="position"
                                        select="$direction.align.end"/>
                                    <xsl:with-param name="gentext-key"
                                        select="$gentext-key"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:variable>

        <!-- Really output a header? -->
        <xsl:choose>
            <xsl:when
                test="
                    $pageclass = 'titlepage' and $gentext-key = 'book'
                    and $sequence = 'first'">
                <!-- no, book titlepages have no headers at all -->
            </xsl:when>
            <xsl:when test="$sequence = 'blank' and $headers.on.blank.pages = 0">
                <!-- no output -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$candidate"/>
            </xsl:otherwise>
        </xsl:choose>
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
                                        <xsl:apply-templates select="."
                                        mode="titleabbrev.markup"/>
                                    </fo:block>
                                </xsl:when>
                                <xsl:when test="$position = 'center'">
                                    <!-- Nothing -->
                                </xsl:when>
                                <xsl:when test="$position = 'right'">
                                    <fo:block>
                                        <fo:external-graphic
                                        content-height="10mm">
                                        <xsl:attribute name="src">
                                        <xsl:call-template
                                        name="fo-external-image">
                                        <xsl:with-param name="filename"
                                        select="concat($logo.src.path, $header.image.filename)"
                                        />
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
                                        <xsl:when
                                        test="$sequence = 'even' or $sequence = 'blank'">
                                        <fo:block>
                                        <fo:external-graphic
                                        content-height="10mm">
                                        <xsl:attribute name="src">
                                        <xsl:call-template
                                        name="fo-external-image">
                                        <xsl:with-param name="filename"
                                        select="concat($logo.src.path, $header.image.filename)"
                                        />
                                        </xsl:call-template>
                                        </xsl:attribute>
                                        </fo:external-graphic>
                                        </fo:block>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        <!-- Start left (odd) -->
                                        <fo:block>
                                        <xsl:apply-templates select="."
                                        mode="titleabbrev.markup"/>
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
                                        <xsl:when
                                        test="
                                                $sequence = 'even' or
                                                $sequence = 'blank'">
                                        <fo:block>
                                        <xsl:apply-templates select="."
                                        mode="titleabbrev.markup"/>
                                        </fo:block>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        <fo:block>
                                        <fo:external-graphic
                                        content-height="10mm">
                                        <xsl:attribute name="src">
                                        <xsl:call-template
                                        name="fo-external-image">
                                        <xsl:with-param name="filename"
                                        select="concat($logo.src.path, $header.image.filename)"
                                        />
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
