<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory xsl html">

<!--
Open-eBook Romantext
-->

<xsl:strip-space elements="xtory:story xtory:meta xtory:text"/>
<xsl:output method="xml" encoding="ISO-8859-1"
	doctype-public="+//ISBN 0-9673008-1-9//DTD OEB 1.2 Document//EN"
	doctype-system="http://openebook.org/dtds/oeb-1.2/oebdoc12.dtd"/>

<xsl:param name="lang">de</xsl:param>

<xsl:include href="global.xsl"/>
<xsl:include href="html-templates.xsl"/>

<xsl:template match="/xtory:story">
	<html xml:lang="{$lang}">
		<head>
			<xsl:apply-templates select="xtory:meta"/>
			<meta name="creator" content="Aki Alexandra Nofftz (stories@proc.org)"/>
			<meta name="generator" content="Xtory 3.0 powered by Apache Cocoon 2.1"/>
			<style type="text/x-oeb1-css">
				<xsl:text>body{font-family:serif}</xsl:text>
				<xsl:text>h1{font-size:200%}h2{font-size:175%}h3{font-size: 150%}</xsl:text>
				<xsl:text>h4{font-size:125%}h5{font-size:110%}</xsl:text>
				<xsl:text>h1,h2,h3,h4,h5{font-weight:bold;font-style:italic;margin:3em 0 0 1em;text-align:center}</xsl:text>
				<xsl:text>blockquote,.quote{margin:0 0 1em 3em;font-style:italic}</xsl:text>
				<xsl:text>div{margin:0 0 1em 0}dl{margin:0 0 1em 0}dt{font-weight:bold;margin:0.5em 0 0 0}dd{margin:0 0 0.25em 3em}</xsl:text>
				<xsl:text>p{text-indent:1em;margin:0 0 0.5em 0;text-align:justify}</xsl:text>
				<xsl:text>big{font-size:150%}small{font-size:80%}</xsl:text>
				<xsl:text>#theend{text-transform:uppercase;text-align:center;margin:1em 0 2em 0}</xsl:text>
				<xsl:text>#preview{font-style:italic;margin:0 0 2em 0}#next{text-align:center;font-weight:bold}</xsl:text>
				<xsl:text>#imprint{font:xx-small sans-serif;margin:1em 0 0 0;</xsl:text>
				<xsl:text>padding:0.25em;border-top:1pt solid black;text-indent:0}</xsl:text>
				<xsl:text>.c{text-align:center}</xsl:text>
			</style>
		</head>
		<body>
			<h1><xsl:call-template name="title"/></h1>
			<p class="c">
				<xsl:text>von </xsl:text>
				<xsl:for-each select="xtory:meta/xtory:author">
					<xsl:choose>
						<xsl:when test="position() &gt; 1 and position() = last()"> und </xsl:when>
						<xsl:when test="position() &gt; 1">, </xsl:when>
					</xsl:choose>
					<xsl:value-of select="."/>
				</xsl:for-each>
			</p>
			<xsl:apply-templates select="xtory:prefix/*[lang($lang)]"/>
			<xsl:apply-templates select="xtory:text[lang($lang)]"/>
			<xsl:apply-templates select="xtory:appendix/*[lang($lang)]"/>
			<p id="imprint">
				<small>
					<xsl:call-template name="imprint"/>
				</small>
			</p>
		</body>
	</html>
</xsl:template>

<xsl:template match="xtory:section">
	<div>
		<xsl:apply-templates select="*"/>
		<xsl:if test="position() != last() and not(following-sibling::xtory:*[1]/xtory:title)">
			<p class="c">* * *</p>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="xtory:quote">
	<blockquote class="quote">
		<xsl:apply-templates select="*"/>
		<xsl:if test="position() != last() and not(following-sibling::xtory:*[1]/xtory:title)">
			<p class="c">* * *</p>
		</xsl:if>
	</blockquote>
</xsl:template>

<xsl:template match="html:q//html:q">
	<xsl:choose>
		<xsl:when test="$lang='de'">&#x203A;<xsl:apply-templates/>&#x2039;</xsl:when>
		<xsl:when test="$lang='fr'">&#x2039;<xsl:apply-templates/>&#x203A;</xsl:when>
		<xsl:when test="$lang='en'">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:q">
	<xsl:choose>
		<xsl:when test="$lang='de'">»<xsl:apply-templates/>«</xsl:when>
		<xsl:when test="$lang='fr'">«<xsl:apply-templates/>»</xsl:when>
		<xsl:when test="$lang='en'">&#x201C;<xsl:apply-templates/>&#x201D;</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:img"/> <!-- Bilder ignorieren -->

</xsl:stylesheet>
