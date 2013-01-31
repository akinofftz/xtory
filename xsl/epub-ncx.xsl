<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 3.1
  ePUB Ausgabe - OPF

  (c) 2000-2010 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="2.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.daisy.org/z3986/2005/ncx"
	exclude-result-prefixes="xtory html xsl">

<xsl:import href="global.xsl"/>

<xsl:param name="lang">de</xsl:param>
	
<xsl:output method="xml" encoding="UTF-8" indent="yes"
	doctype-public="-//NISO//DTD ncx 2005-1//EN"
	doctype-system="http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"/>

<xsl:template match="/xtory:story">
<ncx version="2005-1" xml:lang="{$lang}">
	<head>
		<meta name="dtb:uid" content="{concat('http://www.stories.proc.org/',@xtory:id,'/',$lang)}"/>
		<meta name="dtb:depth" content="2"/>
		<meta name="dtb:totalPageCount" content="0"/>
		<meta name="dtb:maxPageNumber" content="0"/>
	</head>
	<docTitle>
		<text><xsl:call-template name="title"/></text>
	</docTitle>
	<navMap>
		<navPoint id="title" playOrder="1">
			<navLabel><text><xsl:call-template name="title"/></text></navLabel>
			<content>
				<xsl:attribute name="src">
					<xsl:choose>
						<xsl:when test="xtory:meta/xtory:cover">cover.xhtml</xsl:when>
						<xsl:otherwise>title.xhtml</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</content>
		</navPoint>
		<xsl:apply-templates select="xtory:prefix/xtory:*|xtory:text/xtory:*|xtory:appendix/xtory:*" mode="navPoint"/>
		<navPoint id="imprint" playOrder="{count(xtory:prefix/xtory:*|xtory:text/xtory:*|xtory:appendix/xtory:*) + 2}">
			<navLabel><text>Impressum</text></navLabel>
			<content src="imprint.xhtml"/>
		</navPoint>
	</navMap>
</ncx>
</xsl:template>

<xsl:template match="xtory:*" mode="navPoint">
	<xsl:variable name="id"><xsl:apply-templates select="." mode="id"/></xsl:variable>
	<navPoint playOrder="{position() + 1}" id="{$id}">
		<navLabel><text><xsl:apply-templates select="." mode="label"/></text></navLabel>
		<content src="{$id}.xhtml"/>
	</navPoint>
</xsl:template>

<xsl:template name="imprint-name"><!-- hier nicht verwendet --></xsl:template>

</xsl:stylesheet>
