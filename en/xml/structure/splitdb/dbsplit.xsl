<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet 
[
 <!ENTITY db "https://cdn.docbook.org/release/xsl/current"> 
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:exsl="http://exslt.org/common"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  extension-element-prefixes="exsl">

  <xsl:import href="chunker.xsl"/>
  <xsl:import href="copy.xsl"/>
  <xsl:output indent="yes"/>


  <xsl:param name="base.dir" select="'out/'"/>
  <xsl:param name="use.id.as.filename" select="0"/>
  <xsl:param name="rootid"/>

  <xsl:param name="dbsplit.root.filename">Index</xsl:param>
  <xsl:param name="dbsplit.ext">.xml</xsl:param>
  <xsl:param name="dbsplit.chunk.depth" select="2"/>

  <xsl:template name="object.id">
    <xsl:param name="object" select="."/>
    <xsl:choose>
      <xsl:when test="$object/@id">
        <xsl:value-of select="$object/@id"/>
      </xsl:when>
      <xsl:when test="$object/@xml:id">
        <xsl:value-of select="$object/@xml:id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="generate-id($object)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="recursive-chunk-filename">
    <xsl:param name="recursive" select="false()"/>
    <xsl:variable name="filename">
      <xsl:choose>
        <!-- if this is the root element, use the dbsplit.root.filename -->
        <xsl:when test="not(parent::*) and $dbsplit.root.filename != ''">
          <xsl:value-of select="$dbsplit.root.filename"/>
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:when>
        <!-- Special case -->
        <xsl:when
          test="self::d:legalnotice and not($generate.legalnotice.link = 0)">
          <xsl:choose>
            <xsl:when
              test="(@id or @xml:id) and not($use.id.as.filename = 0)">
              <!-- * if this legalnotice has an ID, then go ahead and use -->
              <!-- * just the value of that ID as the basename for the file -->
              <!-- * (that is, without prepending an "ln-" too it) -->
              <xsl:value-of select="(@id|@xml:id)[1]"/>
              <xsl:value-of select="$dbsplit.ext"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- * otherwise, if this legalnotice does not have an ID, -->
              <!-- * then we generate an ID... -->
              <xsl:variable name="id">
                <xsl:call-template name="object.id"/>
              </xsl:variable>
              <!-- * ...and then we take that generated ID, prepend an -->
              <!-- * "ln-" to it, and use that as the basename for the file -->
              <xsl:value-of select="concat('ln-',$id,$dbsplit.ext)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- if there's no dbhtml filename, and if we're to use IDs as -->
        <!-- filenames, then use the ID to generate the filename. -->
        <xsl:when test="(@id or @xml:id) and $use.id.as.filename != 0">
          <xsl:value-of select="(@id|@xml:id)[1]"/>
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="not($recursive) and $filename != ''">
        <!-- if this chunk has an explicit name, use it -->
        <xsl:value-of select="$filename"/>
      </xsl:when>

      <xsl:when test="self::d:set">
        <xsl:value-of select="$dbsplit.root.filename"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:book">
        <xsl:text>bk</xsl:text>
        <xsl:number level="any" format="01"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:article">
        <xsl:if test="/d:set">
          <!-- in a set, make sure we inherit the right book info... -->
          <xsl:apply-templates mode="recursive-chunk-filename"
            select="parent::*">
            <xsl:with-param name="recursive" select="true()"/>
          </xsl:apply-templates>
        </xsl:if>

        <xsl:text>ar</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:preface">
        <xsl:if test="/d:set">
          <!-- in a set, make sure we inherit the right book info... -->
          <xsl:apply-templates mode="recursive-chunk-filename"
            select="parent::*">
            <xsl:with-param name="recursive" select="true()"/>
          </xsl:apply-templates>
        </xsl:if>

        <xsl:text>pr</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:chapter">
        <xsl:if test="/d:set">
          <!-- in a set, make sure we inherit the right book info... -->
          <xsl:apply-templates mode="recursive-chunk-filename"
            select="parent::*">
            <xsl:with-param name="recursive" select="true()"/>
          </xsl:apply-templates>
        </xsl:if>

        <xsl:text>ch</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:appendix">
        <xsl:if test="/d:set">
          <!-- in a set, make sure we inherit the right book info... -->
          <xsl:apply-templates mode="recursive-chunk-filename"
            select="parent::*">
            <xsl:with-param name="recursive" select="true()"/>
          </xsl:apply-templates>
        </xsl:if>

        <xsl:text>ap</xsl:text>
        <xsl:number level="any" format="a" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:part">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>pt</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:reference">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>rn</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:refentry">
        <xsl:choose>
          <xsl:when test="parent::d:reference">
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="/d:set">
              <!-- in a set, make sure we inherit the right book info... -->
              <xsl:apply-templates mode="recursive-chunk-filename"
                select="parent::*">
                <xsl:with-param name="recursive" select="true()"/>
              </xsl:apply-templates>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:text>re</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:colophon">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>co</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:sect1 or self::d:sect2 or self::d:sect3 or 
                      self::d:sect4 or self::d:sect5 or self::d:section">
        <xsl:apply-templates mode="recursive-chunk-filename"
          select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
        <xsl:text>s</xsl:text>
        <xsl:number format="01"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:bibliography">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>bi</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:glossary">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>go</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:index">
        <xsl:choose>
          <xsl:when test="/d:set">
            <!-- in a set, make sure we inherit the right book info... -->
            <xsl:apply-templates mode="recursive-chunk-filename"
              select="parent::*">
              <xsl:with-param name="recursive" select="true()"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise> </xsl:otherwise>
        </xsl:choose>

        <xsl:text>ix</xsl:text>
        <xsl:number level="any" format="01" from="d:book"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="self::d:setindex">
        <xsl:text>si</xsl:text>
        <xsl:number level="any" format="01" from="d:set"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <xsl:text>chunk-filename-error-</xsl:text>
        <xsl:value-of select="name(.)"/>
        <xsl:number level="any" format="01" from="d:set"/>
        <xsl:if test="not($recursive)">
          <xsl:value-of select="$dbsplit.ext"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="generate-filename">
    <xsl:apply-templates select="." mode="recursive-chunk-filename"/>
  </xsl:template>

  <xsl:template name="generate-content">
    <xsl:variable name="filename">
      <xsl:call-template name="make-relative-filename">
        <xsl:with-param name="base.dir" select="$base.dir"/>
        <xsl:with-param name="base.name">
           <xsl:call-template name="generate-filename"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="depth" select="count(ancestor::*)"/>
    
    <!--<xsl:message>generate-content:
      name: <xsl:value-of select="name()"/>
      filename: <xsl:value-of select="$filename"/>
      depth: <xsl:value-of select="$depth"/>
      test: <xsl:value-of select="$depth >= $dbsplit.chunk.depth"/>
    </xsl:message>-->
    
    <xsl:choose>
      <xsl:when test="$depth &lt;= $dbsplit.chunk.depth">
        <xi:include href="{$filename}"/>
        <xsl:call-template name="write.xml.chunk">
          <xsl:with-param name="filename" select="$filename"/>
          <xsl:with-param name="content">
            <xsl:copy-of select="preceding-sibling::processing-instruction()|
                                 preceding-sibling::comment()"/>
            <xsl:copy>
              <xsl:apply-templates/>
            </xsl:copy>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template
    match="d:acknowledgements|d:appendix|d:article|
           d:bibliography|
           d:chapter|d:colophon|d:dedication|d:glossary|
           d:part|d:preface|d:reference|d:topic|
           d:sect1|d:section[not(parent::d:section)]">
    <xsl:call-template name="generate-content"/>
  </xsl:template>

</xsl:stylesheet>
