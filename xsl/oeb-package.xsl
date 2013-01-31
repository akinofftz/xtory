<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 3.0
  OeB Ausgabe - Package

  (c) 2000-2004 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="1.0"
	xmlns="http://openebook.org/namespaces/oeb-package/1.0/"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xtory="http://stories.proc.org/xtory/3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xtory html xsl">

<xsl:import href="global.xsl"/>

<xsl:param name="lang">de</xsl:param>
	
<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"
	doctype-public="+//ISBN 0-9673008-1-9//DTD OEB 1.2 Package//EN"
	doctype-system="http://openebook.org/dtds/oeb-1.2/oebpkg12.dtd"/>

<xsl:template match="/xtory:story">
<package unique-identifier="uri">
  <metadata>
    <dc-metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
      <dc:Title><xsl:call-template name="title"/></dc:Title>
			<xsl:for-each select="xtory:meta/xtory:author">
      	<dc:Creator role="aut" file-as="{.}"><xsl:value-of select="."/></dc:Creator>
			</xsl:for-each>
      <dc:Coverage>Perry Rhodan</dc:Coverage>
      <dc:Date><xsl:value-of select="xtory:meta/xtory:lastmod"/></dc:Date>
      <dc:Type>novel</dc:Type>
      <dc:Identifier id="uri">
        <xsl:text>http://stories.proc.org/</xsl:text>
        <xsl:value-of select="@xtory:id"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="$lang"/>
      </dc:Identifier> 
      <dc:Language><xsl:value-of select="$lang"/></dc:Language>
      <dc:Publisher>Perry Rhodan Online Club</dc:Publisher>
      <dc:Subject>Fan-Publikation des Perry Rhodan Online Clubs</dc:Subject>
    </dc-metadata>
  </metadata>
  <manifest>
    <item id="text" href="{@xtory:id}.html" media-type="text/x-oeb1-document"/>
		<xsl:if test="xtory:meta/xtory:cover">
			<item id="cover" href="{@xtory:id}.jpg" media-type="image/jpeg"/>
			<item id="thumb" href="{@xtory:id}-thumb.jpg" media-type="image/jpeg"/>
		</xsl:if>
  </manifest>
  <spine>
    <itemref idref="text"/>
  </spine>
  <guide>
		<xsl:if test="/xtory:story/xtory:meta/xtory:cover">
			<reference type="other.ms-coverimage-standard" title="cover image standard" href="{@xtory:id}.jpg"/>
			<reference type="other.ms-thumbimage-standard" title="thumb image standard" href="{@xtory:id}-thumb.jpg"/>
		</xsl:if>
		<reference type="other.ms-firstpage" title="first page" href="{@xtory:id}.html#roman"/>
    <reference type="other.ms-copyright" title="imprint" href="{@xtory:id}.html#imprint"/>
  </guide>
	<tours>
		<tour id="chaptertour" title="Tour">
			<site title="text" href="{@xtory:id}.html"/>
		</tour>
	</tours>
</package>
</xsl:template>

<xsl:template name="imprint-name"><!-- hier nicht verwendet --></xsl:template>

</xsl:stylesheet>
