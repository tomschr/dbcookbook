<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                exclude-inline-prefixes="c h cx"
                name="main">
<p:input port="parameters" kind="parameter"/>
<p:option name="href" required="true"/>
<p:option name="rbase" select="$href"/>
<p:option name="base" select="'output'"/>
<p:option name="chunkdepth" select="2"/>
<p:option name="strict" select="1"/>

<!-- See http://norman.walsh.name/2010/06/09/epubxpl -->
<!-- Version 1.1 -->

<p:import href="/home/ndw/xmlcalabash.com/library/tee.xpl"/>
<p:import href="/home/ndw/xmlcalabash.com/extension/steps/library-1.0.xpl"/>

<p:variable name="website" select="substring-before(substring-after($href,'//'),'/')"/>

<p:add-attribute match="/c:request" attribute-name="href">
  <p:input port="source">
    <p:inline>
      <c:request method="get" detailed="false"/>
    </p:inline>
  </p:input>
  <p:with-option name="attribute-value" select="$href"/>
</p:add-attribute>

<p:http-request/>

<!--
<cx:message>
  <p:with-option name="message" select="concat('type: ', /c:body/@content-type)"/>
</cx:message>
-->

<p:choose>
  <p:when test="contains(/c:body/@content-type, 'text/html')
                or contains(/c:body/@content-type, 'application/octet')">
    <p:output port="result"/>
    <p:unescape-markup content-type="text/html"/>
    <p:identity>
      <p:input port="source" select="/c:body/h:html"/>
    </p:identity>
  </p:when>
  <p:otherwise>
    <p:output port="result"/>
    <p:identity/>
  </p:otherwise>
</p:choose>

<!--
<p:load>
  <p:with-option name="href" select="$href"/>
</p:load>

<cx:tee href="/tmp/out.xml">
  <p:with-option name="debug" select="1">
    <p:empty/>
  </p:with-option>
</cx:tee>
-->

<!-- hack to patch XProc -->

<p:add-attribute match="h:div[@class='appendix' or @class='glossary' or @class='bibliography']"
                 attribute-name="class" attribute-value="section"/>

<p:add-attribute match="h:div[@class='section' and not(ancestor::h:div[@class='section'])]"
                 attribute-name="class" attribute-value="div1"/>

<p:add-attribute match="h:div[@class='div1']/h:div[@class='section']"
                 attribute-name="class" attribute-value="div2"/>

<p:add-attribute match="h:div[@class='div2']/h:div[@class='section']"
                 attribute-name="class" attribute-value="div3"/>

<p:add-attribute match="h:div[@class='div3']/h:div[@class='section']"
                 attribute-name="class" attribute-value="div4"/>

<!-- /hack to patch XProc -->

<!-- hack to patch non-XHTML -->

<p:namespace-rename from="" to="http://www.w3.org/1999/xhtml" apply-to="elements"/>

<!-- /hack to patch non-XHTML -->

<p:identity name="html"/>

<p:for-each name="links">
  <p:iteration-source select="/h:html/h:head/h:link[@rel='stylesheet' and @href]"/>
  <p:output port="result"/>

  <p:string-replace match="/file/text()">
    <p:input port="source">
      <p:inline><file>@@</file>&#10;</p:inline>
    </p:input>
    <p:with-option name="replace"
                   select="concat('&quot;',resolve-uri(/h:link/@href, $rbase),'&quot;')"/>
  </p:string-replace>
</p:for-each>

<p:for-each name="images">
  <p:iteration-source select="//h:img[@src]">
    <p:pipe step="html" port="result"/>
  </p:iteration-source>
  <p:output port="result"/>

  <p:string-replace match="/file/text()">
    <p:input port="source">
      <p:inline><file>@@</file>&#10;</p:inline>
    </p:input>
    <p:with-option name="replace"
                   select="concat('&quot;',resolve-uri(/h:img/@src, $rbase),'&quot;')"/>
  </p:string-replace>
</p:for-each>

<p:for-each name="objects">
  <p:iteration-source select="//h:object[@data]">
    <p:pipe step="html" port="result"/>
  </p:iteration-source>
  <p:output port="result"/>

  <p:string-replace match="/file/text()">
    <p:input port="source">
      <p:inline><file>@@</file>&#10;</p:inline>
    </p:input>
    <p:with-option name="replace"
                   select="concat('&quot;',resolve-uri(/h:object/@data, $rbase),'&quot;')"/>
  </p:string-replace>
</p:for-each>

<!--
<p:for-each name="files">
  <p:iteration-source select="//h:a[@href
                                    and not(starts-with(@href,'mailto:'))
                                    and not(starts-with(@href,'http:'))
                                    and not(starts-with(@href,'https:'))
                                    and not(starts-with(@href,'#'))]">
    <p:pipe step="html" port="result"/>
  </p:iteration-source>
  <p:output port="result"/>

  <p:string-replace match="/file/text()">
    <p:input port="source">
      <p:inline><file>@@</file>&#10;</p:inline>
    </p:input>
    <p:with-option name="replace"
                   select="concat('&quot;',resolve-uri(/h:a/@href, $rbase),'&quot;')"/>
  </p:string-replace>
</p:for-each>
-->

<p:wrap-sequence wrapper="irrelevant">
  <p:input port="source">
    <p:pipe step="links" port="result"/>
    <p:pipe step="images" port="result"/>
    <p:pipe step="objects" port="result"/>
<!--
    <p:pipe step="files" port="result"/>
-->
  </p:input>
</p:wrap-sequence>

<p:exec source-is-xml="false" result-is-xml="true" method="text" command="perl">
  <p:with-option name="args" select="concat('./getfiles.pl ', $base)"/>
</p:exec>

<p:add-attribute name="xmlman" match="/manifest" attribute-name="xml:base">
  <p:input port="source" select="/c:result/manifest"/>
  <p:with-option name="attribute-value" select="$rbase">
    <p:empty/>
  </p:with-option>
</p:add-attribute>

<!-- ============================================================ -->

<p:wrap-sequence wrapper="doc">
  <p:input port="source">
    <p:pipe step="xmlman" port="result"/>
    <p:pipe step="html" port="result"/>
  </p:input>
</p:wrap-sequence>

<cx:tee href="/tmp/out.xml">
  <p:with-option name="debug" select="1">
    <p:empty/>
  </p:with-option>
</cx:tee>

<p:xslt name="style" version="2.0" initial-mode="split">
  <p:input port="stylesheet">
    <p:document href="/projects/w3c/epub/spec2epub.xsl"/>
  </p:input>
  <p:with-param name="base" select="concat(string($base), '/')">
    <p:empty/>
  </p:with-param>
  <p:with-param name="website" select="$website">
    <p:empty/>
  </p:with-param>
  <p:with-param name="chunkdepth" select="$chunkdepth">
    <p:empty/>
  </p:with-param>
  <p:with-param name="strict" select="$strict">
    <p:empty/>
  </p:with-param>
</p:xslt>

<p:sink/>

<p:for-each>
  <p:iteration-source>
    <p:pipe step="style" port="secondary"/>
  </p:iteration-source>

  <p:store>
    <p:with-option name="href" select="base-uri(/)"/>
    <p:with-option name="method"
                   select="if (ends-with(base-uri(/),'.html')) then 'xhtml' else 'xml'"/>
    <p:with-option name="indent"
                   select="not(ends-with(base-uri(/),'.html'))"/>
  </p:store>
</p:for-each>

<p:add-attribute match="c:container/c:rootfiles/c:rootfile"
                 xmlns:c="urn:oasis:names:tc:opendocument:xmlns:container"
                 attribute-name="full-path">
  <p:input port="source">
    <p:inline><container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
      <rootfiles>
        <rootfile full-path="@@" media-type="application/oebps-package+xml"/>
      </rootfiles>
    </container></p:inline>
  </p:input>
  <p:with-option name="attribute-value" select="concat($website,'/content.opf')"/>
</p:add-attribute>

<p:store>
  <p:with-option name="href" select="concat($base,'/META-INF/container.xml')"/>
</p:store>

<p:delete match="h:div[@class='body']|h:div[@class='back']|h:div[@class='toc']|h:div[@class='div1']">
  <p:input port="source">
    <p:pipe step="html" port="result"/>
  </p:input>
</p:delete>

<p:store name="store" href="/tmp/cover.html" encoding="US-ASCII"/>

<p:exec command="webkit2png" name="makecover"
        args="-o /tmp/cover --clipheight=800 --clipwidth=600 --scale=1 -C /tmp/cover.html">
  <p:input port="source">
    <p:empty/>
  </p:input>
  <p:with-option name="result-is-xml" select="'false'">
    <p:pipe step="store" port="result"/>
  </p:with-option>
</p:exec>

<p:exec command="convert">
  <p:input port="source">
    <p:empty/>
  </p:input>
  <p:with-option name="args"
                 select="concat('-bordercolor black -border 1 /tmp/cover-clipped.png ',
                                $base, '/', $website, '/cover-clipped.png')"/>
  <p:with-option name="result-is-xml" select="'false'">
    <p:pipe step="makecover" port="result"/>
  </p:with-option>
</p:exec>

<p:store method="text">
  <p:input port="source"><p:inline><doc>application/epub+zip</doc></p:inline></p:input>
  <p:with-option name="href" select="concat($base,'/mimetype')"/>
</p:store>

</p:declare-step>
