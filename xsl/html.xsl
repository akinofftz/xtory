<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory xsl html">

<xsl:strip-space elements="xtory:story xtory:meta xtory:text"/>
<xsl:output method="xml" encoding="UTF-8" cdata-section-elements="cdata"
	doctype-public="-//W3C//DTD XHTML 1.1//EN"
	doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

<xsl:param name="lang">de</xsl:param>

<xsl:include href="global.xsl"/>
<xsl:include href="html-templates.xsl"/>

<xsl:template match="/xtory:story">
	<html xml:lang="{$lang}">
		<head>
			<xsl:apply-templates select="xtory:meta"/>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<meta name="creator" content="Aki Alexandra Nofftz (stories@proc.org)"/>
			<meta name="generator" content="Xtory 3.1"/>
			<style type="text/css">
				<xsl:text>@import url(gfx/stories.css);</xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">q{quotes:'»' '«' '&#x203A;' '&#x2039;'}</xsl:when>
					<xsl:when test="$lang='fr'">q{quotes:'«' '»' '&#x2039;' '&#x203A;'}</xsl:when>
					<xsl:when test="$lang='en'">q{quotes:'&#x201C;' '&#x201D;' '&#x2018;' '&#x2019;'}</xsl:when>
				</xsl:choose>
			</style>
			<script type="text/javascript" src="gfx/ie-bugfix.js">&#160;</script>
		</head>
		<body onload="iefix()">
			<xsl:call-template name="chapterlist"/>
			<div id="text">
				<h1>
					<xsl:if test="not(xtory:meta/xtory:cover)">
						<xsl:for-each select="xtory:meta/xtory:author">
							<small><xsl:value-of select="."/></small><br/>
						</xsl:for-each>
					</xsl:if>
					<xsl:call-template name="title"/>
				</h1>
				<xsl:if test="xtory:meta/xtory:cover">
					<p id="cover">
						<img alt="" src="gfx/{@xtory:id}.jpg" width="510" height="680"/>
					</p>
				</xsl:if>
				<xsl:apply-templates select="xtory:prefix/*[lang($lang)]"/>
				<xsl:apply-templates select="xtory:text[lang($lang)]"/>
				<xsl:apply-templates select="xtory:appendix/*[lang($lang)]"/>
			</div>
			<p id="imprint">
				<small>
					<xsl:call-template name="imprint"/>
				</small>
			</p>
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>
