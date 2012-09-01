<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="d xlink">


  <xsl:template name="header.navigation__new">
    <xsl:param name="prev" select="/d:foo"/>
    <xsl:param name="next" select="/d:foo"/>
    <xsl:param name="nav.context"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:variable name="row1" select="$navig.showtitles != 0"/>
    <xsl:variable name="row2"
      select="count($prev) &gt; 0 or (count($up) &gt; 0 
                and generate-id($up) != generate-id($home) 
                and $navig.showtitles != 0)
              or count($next) &gt; 0"/>
    <xsl:variable name="nextdiv"
            select="(ancestor-or-self::d:appendix
                    |ancestor-or-self::d:bibliography
                    |ancestor-or-self::d:chapter
                    |ancestor-or-self::d:colophon
                    |ancestor-or-self::d:glossary
                    |ancestor-or-self::d:index
                    |ancestor-or-self::d:part
                    |ancestor-or-self::d:preface
                    |ancestor-or-self::d:reference
                    )[1]/following-sibling::d:*[1]"/>
    <xsl:variable name="prevdiv"
            select="(ancestor-or-self::d:appendix
                    |ancestor-or-self::d:bibliography
                    |ancestor-or-self::d:chapter
                    |ancestor-or-self::d:colophon
                    |ancestor-or-self::d:glossary
                    |ancestor-or-self::d:index
                    |ancestor-or-self::d:part
                    |ancestor-or-self::d:preface
                    |ancestor-or-self::d:reference
                    )[1]/preceding-sibling::d:*[not(self::d:title|self::d:subtitle|self::d:info)][1]"/>

    <div class="navheader">
      <xsl:if test="$row2">
        <ul>
          <xsl:if test="$home != . or $nav.context = 'toc'">
            <li class="home">
              <a accesskey="h">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$home"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:copy-of select="$home.navigation"/>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'home'"/>
                </xsl:call-template>
              </a>
              <!--<xsl:if
                test="$chunk.tocs.and.lots != 0 and 
                              $nav.context != 'toc'">
                <xsl:text>&#160;|&#160;</xsl:text>
              </xsl:if>-->
            </li>
          </xsl:if>
          <xsl:if test="$chunk.tocs.and.lots != 0 and $nav.context != 'toc'">
            <li class="toclink">
              <a accesskey="t">
                <xsl:attribute name="href">
                  <xsl:apply-templates select="/*[1]"
                    mode="recursive-chunk-filename">
                    <xsl:with-param name="recursive" select="true()"/>
                  </xsl:apply-templates>
                  <xsl:text>-toc</xsl:text>
                  <xsl:value-of select="$html.ext"/>
                </xsl:attribute>
                <xsl:copy-of select="$toc.navigation"/>
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key" select="'nav-toc'"/>
                </xsl:call-template>
              </a>
            </li>
          </xsl:if>

          <xsl:if test="count($up)&gt;0 and generate-id($up) != generate-id($home)">
            <li class="up">
              <a accesskey="u">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$up"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:copy-of select="$up.navigation"/>
                <xsl:call-template name="navig.content">
                  <xsl:with-param name="direction" select="'up'"/>
                </xsl:call-template>
                <!--<xsl:apply-templates select="$up"
                          mode="object.title.markup"/>-->
              </a>
            </li>
          </xsl:if>

          <li class="prev">
            <xsl:if test="count($prev)&gt;0">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:copy-of select="$prev.navigation"/>
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$prev"
                    mode="object.title.markup"/>
                </xsl:if>
              </a>
            </xsl:if>
          </li>
          <li class="next">
            <xsl:if test="count($next)&gt;0">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <!--<xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                      </xsl:call-template>-->
                <xsl:copy-of select="$next.navigation"/>
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$next"
                    mode="object.title.markup"/>
                </xsl:if>
              </a>
            </xsl:if>
          </li>
          
          <xsl:if test="count($prevdiv)&gt;0">
            <li class="prevdiv">
              <a accesskey="x">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prevdiv"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:copy-of select="$prevdiv.navigation"/>
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$prevdiv"
                    mode="object.title.markup"/>
                </xsl:if>
              </a>
            </li>
          </xsl:if>
          
          <xsl:if test="count($nextdiv)&gt;0">
            <li class="nextdiv">
              <a accesskey="y">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$nextdiv"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:copy-of select="$nextdiv.navigation"/>
                <xsl:if test="$navig.showtitles != 0">
                  <xsl:apply-templates select="$nextdiv"
                    mode="object.title.markup"/>
                </xsl:if>
              </a>
            </li>
          </xsl:if>
          
        </ul>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="user.footer.navigation">
    <xsl:param name="prev" select="/d:foo"/>
    <xsl:param name="next" select="/d:foo"/>
    <xsl:param name="nav.context"/>
    <xsl:variable name="ticketnr" 
      select="ancestor-or-self::d:*/d:info/d:biblioid[@class='other'][@otherclass='ticket']"/>

    <div class="userfooter">
      <hr/>
      <table width="100%" class="userfooter">
        <tbody>
          <tr>
            <td><a href="{$base.project.url}">Project @Sourceforge.net®</a></td>
            <td>
              <xsl:if test="$ticketnr">
                <a href="{concat($ticket.url, $ticketnr, '/')}" 
                  title="Ticket#{$ticketnr}">Ticket#<xsl:value-of 
                    select="$ticketnr"/></a>
              </xsl:if>
            </td>
            <td align="right"><a href="{$base.code.url}">Code @Sourceforge.net®</a></td>
          </tr>
        </tbody>
      </table>
    </div>
  </xsl:template>

</xsl:stylesheet>
