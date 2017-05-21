<?xml version="1.0" encoding="utf-8"?>
<p:library version="1.0"
  xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:wxp="http://www.wordsinboxes.com/xproc">


  <!-- This step sends it's primary input to a file specified by "step-name." 
       It is used for seeing the output of an intermediary step.  -->

  <p:declare-step name="debug" type="wxp:debug-output">
    <p:input port="source" primary="true"/>
    <p:output port="result">
      <p:pipe step="ident" port="result"/>
    </p:output>
    <p:option name="debug" select="'false'"/>
    <p:option name="step-name" required="true"/>

    <p:identity name="ident"/>

    <p:choose>
      <p:when test="$debug = 'true'">
        <p:store>
          <p:with-option name="href" select="concat($step-name, '.debug')"/>
          <p:input port="source">
            <p:pipe port="result" step="ident"/>
          </p:input>
        </p:store>
      </p:when>
      <p:otherwise>
        <p:sink/>
      </p:otherwise>
    </p:choose>
  </p:declare-step>


  <!-- This is used to assert that either the two documents on 'source'
       and 'alternate' are equal, or that an xpath expression defined
       by "xpath" evaluates to the same value.  -->

  <!-- TODO: This should return an XML error document  -->

  <p:declare-step name="assert" type="wxp:assert" xmlns:wxp="http://www.wordsinboxes.com/xproc"
    xmlns:p="http://www.w3.org/ns/xproc">

    <p:input port="source" primary="true"/>
    <p:input port="alternate"/>
    <p:input port="parameters" kind="parameter"/>
    <p:output port="result" primary="true"/>

    <p:option name="label" select="'Unlabeled Assertion'"/>
    <p:option name="xpath-source" select="''"/>
    <p:option name="xpath-alternate" select="''"/>
    <p:option name="fail-on-error" select="'true'"/>
    <p:option name="print-results" select="'true'"/>


    <!-- Wrap the two documents in a single element so it can be 
         passed to a transform as a single document -->

    <p:pack wrapper="wxp:wrapper">
      <p:input port="source">
        <p:pipe step="assert" port="source"/>
      </p:input>
      <p:input port="alternate">
        <p:pipe step="assert" port="alternate"/>
      </p:input>
    </p:pack>

    <p:xslt>
      <p:input port="stylesheet">
        <p:inline>
          <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            xmlns:wxp="http://www.wordsinboxes.com/xproc" xmlns:saxon="http://saxon.sf.net/"
            xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">

            <xsl:param name="label" select="'Unlabeled Assertion'"/>
            <xsl:param name="print-results" select="'true'"/>
            <xsl:param name="xpath-source" select="'.'"/>
            <xsl:param name="xpath-alternate" select="'.'"/>

            <xsl:template match="/">

              <xsl:variable name="source" select="/wxp:wrapper/*[1]"/>
              <xsl:variable name="alternate" select="/wxp:wrapper/*[2]"/>

              <!-- Test each nodeset using the supplied XPath expression -->
              <xsl:variable name="source-tested">
                <xsl:for-each select="$source">
                  <xsl:copy-of select="saxon:evaluate($xpath-source)"/>
                </xsl:for-each>
              </xsl:variable>
              <xsl:variable name="alternate-tested">
                <xsl:for-each select="$alternate">
                  <xsl:copy-of select="saxon:evaluate($xpath-alternate)"/>
                </xsl:for-each>
              </xsl:variable>

              <!-- Compare the resulting nodesets -->
              <xsl:variable name="result"
                select="if (deep-equal($source-tested, $alternate-tested)) 
                        then 'PASS' 
                        else 'FAIL'"/>

              <!-- Create a PASS or FAIL element -->
              <xsl:element name="{$result}"/>

              <!-- Send messages to console -->
              <xsl:message select="concat('* ', $result, '* Assertion: ', $label)"/>
              <xsl:if test="$print-results = 'true'">
                <xsl:message select="concat('  ', $source-tested)"/>
                <xsl:message select="concat('  ', $alternate-tested)"/>
              </xsl:if>
            </xsl:template>

          </xsl:stylesheet>
        </p:inline>
      </p:input>
      <p:with-param name="label" select="$label"/>
      <p:with-param name="print-results" select="$print-results"/>
      <p:with-param name="xpath-source" select="$xpath-source"/>
      <p:with-param name="xpath-alternate" select="$xpath-alternate"/>
    </p:xslt>

    <p:choose>
      <p:when test="/FAIL and $fail-on-error = 'true'">
        <p:error code="wxp:assert-fail" name="assertion-failed"/>
      </p:when>
      <p:otherwise>
        <p:sink/>
      </p:otherwise>
    </p:choose>

    <!-- Spit back out the original input -->
    <p:identity>
      <p:input port="source">
        <p:pipe step="assert" port="source"/>
      </p:input>
    </p:identity>

  </p:declare-step>


</p:library>
