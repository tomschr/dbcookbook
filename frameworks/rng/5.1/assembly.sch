<?xml version="1.0" encoding="utf-8"?>
<s:schema xmlns:s="http://purl.oclc.org/dsdl/schematron"
          xmlns:db="http://docbook.org/ns/docbook">
   <s:ns prefix="db" uri="http://docbook.org/ns/docbook"/>
   <s:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
   <s:pattern name="Glossary 'firstterm' type constraint">
      <s:rule context="db:firstterm[@linkend]">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on firstterm must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Footnote reference type constraint">
      <s:rule context="db:footnoteref">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'footnote' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on footnoteref must point to a footnote.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary 'glossterm' type constraint">
      <s:rule context="db:glossterm[@linkend]">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on glossterm must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Synopsis fragment type constraint">
      <s:rule context="db:synopfragmentref">
         <s:assert test="local-name(//*[@xml:id=current()/@linkend]) = 'synopfragment' and namespace-uri(//*[@xml:id=current()/@linkend]) = 'http://docbook.org/ns/docbook'">@linkend on synopfragmentref must point to a synopfragment.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glosssary 'see' type constraint">
      <s:rule context="db:glosssee[@otherterm]">
         <s:assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glosssee must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary 'seealso' type constraint">
      <s:rule context="db:glossseealso[@otherterm]">
         <s:assert test="local-name(//*[@xml:id=current()/@otherterm]) = 'glossentry' and namespace-uri(//*[@xml:id=current()/@otherterm]) = 'http://docbook.org/ns/docbook'">@otherterm on glossseealso must point to a glossentry.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Glossary term definition constraint">
      <s:rule context="db:termdef">
         <s:assert test="count(db:firstterm) = 1">A termdef must contain exactly one firstterm</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="XLink arc placement">
      <s:rule context="*[@xlink:type='arc']">
         <s:assert test="parent::*[@xlink:type='extended']">An XLink arc type element must occur as the direct child of an XLink extended type element.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="XLink extended placement">
      <s:rule context="*[@xlink:type='extended']">
         <s:assert test="not(parent::*[@xlink:type='extended'])">An XLink extended type element may not occur as the direct child of an XLink extended type element.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="XLink locator placement">
      <s:rule context="*[@xlink:type='locator']">
         <s:assert test="not(parent::*[@xlink:type='extended'])">An XLink locator type element must occur as the direct child of an XLink extended type element.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="XLink resource placement">
      <s:rule context="*[@xlink:type='resource']">
         <s:assert test="not(parent::*[@xlink:type='extended'])">An XLink resource type element must occur as the direct child of an XLink extended type element.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="XLink title placement">
      <s:rule context="*[@xlink:type='title']">
         <s:assert test="not(parent::*[@xlink:type='extended']) and not(parent::*[@xlink:type='locator']) and not(parent::*[@xlink:type='arc'])">An XLink title type element must occur as the direct child of an XLink extended, locator, or arc type element.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Root must have version">
      <s:rule context="/db:assembly">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:resources">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:module">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:relationships">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
      <s:rule context="/db:transforms">
         <s:assert test="@version">If this element is the root element, it must have a version attribute.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Cardinality of segments and titles">
      <s:rule context="db:seglistitem">
         <s:assert test="count(db:seg) = count(../db:segtitle)">The number of seg elements must be the same as the number of segtitle elements in the parent segmentedlist</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Specification of renderas">
      <s:rule context="db:structure">
         <s:assert test="@renderas and db:output/@renderas">The renderas attribute can be specified on either the structure or output, but not both.</s:assert>
      </s:rule>
      <s:rule context="db:module">
         <s:assert test="@renderas and db:output/@renderas">The renderas attribute can be specified on either the structure or output, but not both.</s:assert>
      </s:rule>
   </s:pattern>
   <s:pattern name="Element exclusion">
      <s:rule context="db:annotation">
         <s:assert test="not(.//db:annotation)">annotation must not occur among the children or descendants of annotation</s:assert>
      </s:rule>
      <s:rule context="db:caution">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of caution</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of caution</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of caution</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of caution</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of caution</s:assert>
      </s:rule>
      <s:rule context="db:important">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of important</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of important</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of important</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of important</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of important</s:assert>
      </s:rule>
      <s:rule context="db:note">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of note</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of note</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of note</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of note</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of note</s:assert>
      </s:rule>
      <s:rule context="db:tip">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of tip</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of tip</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of tip</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of tip</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of tip</s:assert>
      </s:rule>
      <s:rule context="db:warning">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of warning</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of warning</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of warning</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of warning</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of warning</s:assert>
      </s:rule>
      <s:rule context="db:caption">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:task)">task must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of caption</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of caption</s:assert>
      </s:rule>
      <s:rule context="db:equation">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of equation</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of equation</s:assert>
      </s:rule>
      <s:rule context="db:example">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of example</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of example</s:assert>
      </s:rule>
      <s:rule context="db:figure">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of figure</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of figure</s:assert>
      </s:rule>
      <s:rule context="db:table">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of table</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of table</s:assert>
      </s:rule>
      <s:rule context="db:footnote">
         <s:assert test="not(.//db:caution)">caution must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:epigraph)">epigraph must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:equation)">equation must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:example)">example must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:figure)">figure must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:footnote)">footnote must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:important)">important must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:note)">note must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:task)">task must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:tip)">tip must not occur among the children or descendants of footnote</s:assert>
         <s:assert test="not(.//db:warning)">warning must not occur among the children or descendants of footnote</s:assert>
      </s:rule>
      <s:rule context="db:sidebar">
         <s:assert test="not(.//db:sidebar)">sidebar must not occur among the children or descendants of sidebar</s:assert>
      </s:rule>
      <s:rule context="db:entry">
         <s:assert test="not(.//db:informaltable)">informaltable must not occur among the children or descendants of entry</s:assert>
         <s:assert test="not(.//db:table)">table must not occur among the children or descendants of entry</s:assert>
      </s:rule>
   </s:pattern>
</s:schema>