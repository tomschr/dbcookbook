<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:exsl="http://exslt.org/common"
  exclude-result-prefixes="d xlink exsl">

  <xsl:attribute-set name="topic.titlepage.recto.style"
                   use-attribute-sets="section.titlepage.recto.style"/>
  <xsl:attribute-set name="topic.titlepage.verso.style"
                   use-attribute-sets="section.titlepage.verso.style"/>

  <xsl:template name="topic.titlepage.recto">
    <xsl:choose>
      <xsl:when test="d:info/d:title">
        <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
          select="d:info/d:title"/>
      </xsl:when>
      <xsl:when test="d:title">
        <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
          select="d:title"/>
      </xsl:when>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="d:info/d:subtitle">
        <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
          select="d:info/d:subtitle"/>
      </xsl:when>
      <xsl:when test="d:subtitle">
        <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
          select="d:subtitle"/>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:corpauthor"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:authorgroup"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:author"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:othercredit"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:releaseinfo"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:copyright"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:legalnotice"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:pubdate"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:revision"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:revhistory"/>
    <xsl:apply-templates mode="topic.titlepage.recto.auto.mode"
      select="d:info/d:abstract"/>
  </xsl:template>

  <xsl:template match="*" mode="topic.titlepage.recto.mode">
    <!-- if an element isn't found in this mode, -->
    <!-- try the generic titlepage.mode -->
    <xsl:apply-templates select="." mode="titlepage.mode"/>
  </xsl:template>

  <xsl:template match="*" mode="topic.titlepage.verso.mode">
    <!-- if an element isn't found in this mode, -->
    <!-- try the generic titlepage.mode -->
    <xsl:apply-templates select="." mode="titlepage.mode"/>
  </xsl:template>

  <xsl:template match="d:title" mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:subtitle"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:corpauthor"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:authorgroup"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:author" mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:othercredit"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:releaseinfo"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:copyright"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:legalnotice"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:pubdate" mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:revision"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:revhistory"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>

  <xsl:template match="d:abstract"
    mode="topic.titlepage.recto.auto.mode">
    <div xsl:use-attribute-sets="topic.titlepage.recto.style">
      <xsl:apply-templates select="." mode="topic.titlepage.recto.mode"
      />
    </div>
  </xsl:template>
  <xsl:template name="topic.titlepage.verso"/>

  <xsl:template name="topic.titlepage.separator">
    <xsl:if test="count(parent::*)='0'">
      <hr/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="topic.titlepage.before.recto"/>

  <xsl:template name="topic.titlepage.before.verso"/>


  <xsl:template name="topic.titlepage">
    <div class="titlepage">
      <xsl:variable name="recto.content">
        <xsl:call-template name="topic.titlepage.before.recto"/>
        <xsl:call-template name="topic.titlepage.recto"/>
      </xsl:variable>
      <xsl:variable name="recto.elements.count">
        <xsl:choose>
          <xsl:when test="function-available('exsl:node-set')">
            <xsl:value-of
              select="count(exsl:node-set($recto.content)/*)"/>
          </xsl:when>
          <xsl:when
            test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
            <!--Xalan quirk-->
            <xsl:value-of
              select="count(exsl:node-set($recto.content)/*)"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:if
        test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
        <div>
          <xsl:copy-of select="$recto.content"/>
        </div>
      </xsl:if>
      <xsl:variable name="verso.content">
        <xsl:call-template name="topic.titlepage.before.verso"/>
        <xsl:call-template name="topic.titlepage.verso"/>
      </xsl:variable>
      <xsl:variable name="verso.elements.count">
        <xsl:choose>
          <xsl:when test="function-available('exsl:node-set')">
            <xsl:value-of
              select="count(exsl:node-set($verso.content)/*)"/>
          </xsl:when>
          <xsl:when
            test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
            <!--Xalan quirk-->
            <xsl:value-of
              select="count(exsl:node-set($verso.content)/*)"/>
          </xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:if
        test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
        <div>
          <xsl:copy-of select="$verso.content"/>
        </div>
      </xsl:if>
      <xsl:call-template name="topic.titlepage.separator"/>
    </div>
  </xsl:template>


</xsl:stylesheet>
