<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: param.xsl 991 2009-08-02 17:46:24Z tom $ -->
<!DOCTYPE xsl:stylesheet
[
   <!ENTITY % fontsizes SYSTEM "fontsizes.ent">
   %fontsizes;
]>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:fox="http://xml.apache.org/fop/extensions"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
>

<!-- Attribute Sets -->
<xsl:attribute-set name="section.level1.properties" use-attribute-sets="section.properties">
  <xsl:attribute name="page-break-before">always</xsl:attribute>
</xsl:attribute-set>

<!-- Use XEP extensions -->
<!--<xsl:param name="xep.extensions">0</xsl:param>-->

<!-- Should cropmarks be created? -->
<xsl:param name="crop.marks">0</xsl:param>

<!-- Should we use the Java extensions? -->
<xsl:param name="use.extensions">0</xsl:param>

<xsl:param name="paper.type">A4</xsl:param>

<!-- Path to all images -->
<xsl:param name="img.src.path">../../images/</xsl:param>

<!-- As long as we still authoring, we use draft mode -->
<xsl:param name="draft.mode"            select="'no'"/>
<xsl:param name="draft.watermark.image" select="concat($img.src.path,'/png/draft.png')"/>  <!-- select="concat($img.src.path,'/png/draft.png')"/> -->


<xsl:param name="booktitle.graphic"
           select="concat($img.src.path, 'png/logo.png')"/>

  
<!-- Should admonitions contain graphics, which extension and where? -->
<xsl:param name="admon.graphics" select="1"/>
<xsl:param name="admon.graphics.extension">.svg</xsl:param>
<xsl:param name="admon.graphics.path" select="concat($img.src.path,'admon/svg/')"/>


<!-- This is going to be a book, so we print doublesided -->
<xsl:param name="double.sided">1</xsl:param>

<xsl:param name="header.rule"            select="1"/>
<xsl:param name="footer.rule"            select="0"/>
<xsl:param name="headers.on.blank.pages" select="0"/>
<xsl:param name="footer.on.blank.pages"  select="0"/>


<!-- Indention of titles -->
<xsl:param name="title.margin.left" select="'0mm'"/>
<!-- Color of all Titles -->
<xsl:param name="title.color" select="'black'"/><!-- #303030 #00664D -->

<!-- Activate numbering of sections -->
<xsl:param name="section.label.includes.component.label" select="1"/>
<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="section.autolabel.max.depth" select="1"/>

<xsl:param name="refentry.generate.title" select="1"/>
<xsl:param name="refentry.generate.name" select="0"/>
<xsl:param name="refentry.pagebreak" select="0"/>

<!-- The start-indent for the body text -->
<xsl:param name="body.start.indent">0mm</xsl:param>

<!-- Use blocks for variable lists -->
<xsl:param name="variablelist.as.blocks" select="'1'"/>

<!-- Present glossarys using blocks instead of lists? -->
<xsl:param name="glossary.as.blocks" select="1"/>

<!-- Use blocks for glosslists? -->
<xsl:param name="glosslist.as.blocks" select="1"/>

<!-- Display glossentry acronyms? -->
<xsl:param name="glossentry.show.acronym">primary</xsl:param>

<!-- Indentation for blocks, variablelists, etc. -->
<xsl:param name="block.indentation">1.5em</xsl:param>

<!-- Collate copyright years into ranges? -->
<xsl:param name="make.year.ranges" select="1"/>
  
<!--<xsl:param name="itemizedlist.label.width" select="$block.indentation"/>
-->

<!-- Allow URLs to be automatically hyphenated
 SOFT HYPHEN       &#x00AD;
 SPACE, ZERO WIDTH &#x200B;
-->
<xsl:param name="ulink.hyphenate" select="'&#x200B;'"/>

<!-- Insert breakpoint /before/ the following characters: -->
<xsl:param name="ulink.hyphenate.before.chars"
  >.,%?&amp;#\-+{_</xsl:param>
<!-- Insert breakpoint /after/ the following characters: -->
<xsl:param name="ulink.hyphenate.after.chars"
  >/:@=};</xsl:param>

<xsl:param name="default.remark.color" select="'#3300cc'"/>

<xsl:param name="punct.honorific" select="''"/>

<!-- Shade verbatim (and progrmalisting) environments -->
<xsl:param name="shade.verbatim" select="'0'"/>

<!-- Place formal object types -->
<xsl:param name="formal.title.placement">
figure     after
example    before
equation   before
table      before
procedure  before
task       before
</xsl:param>

<!-- How deep should recursive sections appear in the TOC? -->
<xsl:param name="toc.section.depth">1</xsl:param>

<!-- How maximaly deep should be each TOC? -->
<xsl:param name="toc.max.depth">2</xsl:param>

<!-- Change default TOC settings -->
<xsl:param name="generate.toc">
/appendix title
article/appendix  nop
/article  title
book      toc,title
/chapter  title
part      nop
/preface  title
reference toc,title
/sect1    nop
/sect2    nop
/sect3    nop
/sect4    nop
/sect5    nop
/section  nop
set       toc,title
</xsl:param>

<!-- Generate the index? 0=no, 1=yes -->
<xsl:param name="generate.index" select="1"/>


<xsl:param name="bibliography.style">toms</xsl:param>
<xsl:param name="bibliography.numbered" select="1"/>
<xsl:param name="biblioentry.show.abstract" select="1"/>


<!-- Use Unicode characters rather than images for callouts -->
<xsl:param name="callout.unicode.font">toms-callouts</xsl:param> 
<xsl:param name="callout.graphics.extension">.svg</xsl:param>
<xsl:param name="callout.unicode" select="1"/>
<xsl:param name="callout.graphics" select="0"/>
<xsl:param name="callout.graphics.path">images/thesis-callouts/</xsl:param>
<xsl:param name="callout.unicode.number.limit">20</xsl:param>
<xsl:param name="callout.unicode.start.character">9352</xsl:param>
  <!-- 9332, 9312, 10102 -->
  
<!--<xsl:param name="footnote.number.symbols"
    >&#x2020;&#x2021;*+</xsl:param>-->
<!-- &#x22c7; = &divonx;
     &#x25CA; = &loz;
     &#x2720; = &malt;
     &#x2666; = &diams;
-->

<!-- Select which mediaobject to use based on this value of an
     object's role attribute
-->
<xsl:param name="preferred.mediaobject.role">fo</xsl:param>


<!-- Table parameter -->
<xsl:param name="table.frame.border.style">solid</xsl:param>
<xsl:param name="table.cell.border.style">dotted</xsl:param>
<xsl:param name="table.cell.border.thickness" select="'0.75pt'"/>
<xsl:param name="table.frame.border.thickness" select="'0.75pt'"/>
<xsl:param name="table.font-size.overview.style">&footnotesize;</xsl:param>
<xsl:param name="default.table.frame">topbot</xsl:param>

<!-- Figure parameter -->
<xsl:param name="figure.float.width" select="'5cm'"/>
<xsl:param name="figure.float.type">outside</xsl:param>

<!-- Select indexterms based on type attribute value -->
<xsl:param name="index.on.type" select="1"/>
<!-- Which index method should be used? -->
<xsl:param name="index.method">basic</xsl:param>

<!-- Typographical parameters -->
<xsl:param name="rulethickness">0.25pt</xsl:param>

<!-- Localisation -->
<!--<xsl:param name="local.l10n.xml" select="document('../common/l10n/l10n.xml')"/>-->

<!-- Set to 1 to generate changebars in XEP -->
<xsl:param name="use.xep.changebars">0</xsl:param>

<!-- Insert page numbers in xrefs? -->
<xsl:param name="insert.xref.page.number">yes</xsl:param>

<!-- <xsl:param name="xref.title-page.separator"/> -->
<xsl:param name="xref.label-page.separator"/>

<!--<xsl:param name="space.hairspace.width">0.1pt</xsl:param>--><!-- U+200A -->
<xsl:param name="space.hairspace.width">0.05em</xsl:param><!-- U+200A -->
<xsl:param name="space.mmsp.width">(4 div 18) * 1em</xsl:param><!-- U+205F -->

<xsl:param name="menuchoice.separator"> > </xsl:param><!-- &#x2192; -->
  

<xsl:param name="epigraph.separator">&#x02014;</xsl:param><!-- mdash=&#x02014;, ndash=&#x02013; -->
<xsl:param name="runinhead.default.title.end.punct"/>

<xsl:param name="local.l10n.xml" select="document('../common/l10n.xml')"/>

<xsl:param name="use.typo.xep.superior" select="1"/>
<!--<xsl:param name="typo.sup.xml" select="document('typo.superiors.xml')"/>
-->
<!-- Controls fo:floats in formal titles and section titles -->
<xsl:param name="use.float.in.formaltitles" select="1"/>
<xsl:param name="use.float.in.sectiontitles" select="1"/>
  
<!--  -->
<xsl:param name="body.font.master">9.5</xsl:param>

</xsl:stylesheet>
