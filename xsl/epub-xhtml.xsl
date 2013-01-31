<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	exclude-result-prefixes="xtory xsl html exsl">

<!--
ePUB Romantext
-->

<xsl:strip-space elements="xtory:story xtory:meta xtory:text"/>
<xsl:output method="xml" encoding="UTF-8" indent="yes"
	doctype-public="-//W3C DTD XHTML 1.1//EN"
	doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

<xsl:param name="lang">de</xsl:param>

<xsl:include href="global.xsl"/>
<xsl:include href="html-templates.xsl"/>

<xsl:template match="/xtory:story">
	<!-- Restliche Dokumente erzeugen -->
	<xsl:apply-templates select="xtory:meta|xtory:prefix/xtory:*|xtory:text/xtory:*|xtory:appendix/xtory:*" mode="gendoc"/>
	<!-- Ausgabe dieses Stylesheets ist das Impressum -->
	<html xml:lang="{$lang}">
		<head>
			<title>Impressum</title>
		</head>
		<body>
			<h1>Impressum</h1>
			<p>
				<xsl:call-template name="imprint"/>
			</p>
		</body>
	</html>
</xsl:template>

<xsl:template match="xtory:meta" mode="gendoc">
	<xsl:if test="xtory:cover">
		<exsl:document href="cover.xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
			<html xml:lang="{$lang}">
				<head>
					<title><xsl:call-template name="title"/></title>
					<style type="text/css">@page,body,div{padding:0;margin:0;text-align:center}img{height:100%}</style>
				</head>
				<body><div><img alt="cover"><xsl:attribute name="href" value="concat(/xtory:story/@xtory:id, '.jpeg')"/></img></div></body>
			</html>
		</exsl:document>
	</xsl:if>
	<exsl:document href="title.xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
		<html xml:lang="{$lang}">
			<head>
				<title><xsl:call-template name="title"/></title>
				<style type="text/css">*{text-align:center}</style>
			</head>
			<body>
				<h1><xsl:call-template name="title"/></h1>
				<xsl:for-each select="xtory:subtitle">
					<h2><xsl:apply-templates/></h2>
				</xsl:for-each>
				<p>
					<xsl:text>von </xsl:text>
					<xsl:for-each select="xtory:author">
						<xsl:choose>
							<xsl:when test="position() &gt; 1 and position() = last()"> und </xsl:when>
							<xsl:when test="position() &gt; 1">, </xsl:when>
						</xsl:choose>
						<xsl:value-of select="."/>
					</xsl:for-each>
				</p>
				<xsl:if test="xtory:painter">
					<p>
						<xsl:text>Titelbild von </xsl:text>
						<xsl:for-each select="xtory:painter">
							<xsl:choose>
								<xsl:when test="position() &gt; 1 and position() = last()"> und </xsl:when>
								<xsl:when test="position() &gt; 1">, </xsl:when>
							</xsl:choose>
							<xsl:value-of select="."/>
						</xsl:for-each>
					</p>
				</xsl:if>
				<xsl:if test="xtory:illustrator">
					<p>
						<xsl:text>Illustrationen von </xsl:text>
						<xsl:for-each select="xtory:painter">
							<xsl:choose>
								<xsl:when test="position() &gt; 1 and position() = last()"> und </xsl:when>
								<xsl:when test="position() &gt; 1">, </xsl:when>
							</xsl:choose>
							<xsl:value-of select="."/>
						</xsl:for-each>
					</p>
				</xsl:if>
			</body>
		</html>
	</exsl:document>
</xsl:template>

<xsl:template match="xtory:prefix/xtory:*|xtory:text/xtory:*|xtory:appendix/xtory:*" mode="gendoc">
	<xsl:variable name="id"><xsl:apply-templates select="." mode="id"/></xsl:variable>
	<xsl:variable name="file" select="concat($id, '.xhtml')"/>
	<exsl:document href="{$file}" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
	<!--<xsl:result-document href="{$file}.xhtml" validation="strict">-->
		<html xml:lang="{$lang}">
			<head>
				<title><xsl:apply-templates select="." mode="label"/></title>
				<style type="text/css">.c{text-align:center}</style>
			</head>
			<body>
				<h1><xsl:apply-templates select="." mode="label"/></h1>
				<xsl:apply-templates/>
			</body>
		</html>
	<!--</xsl:result-document>-->
	</exsl:document>
</xsl:template>

<xsl:template match="xtory:prefix/xtory:characters">
	<ul>
		<xsl:apply-templates match="xtory:role"/>
	</ul>
</xsl:template>
<xsl:template match="xtory:role">
	<li>
		<strong><xsl:apply-templates select="xtory:name"/>:</strong>
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="xtory:action"/>
	</li>
</xsl:template>

<xsl:template match="xtory:appendix/xtory:preview/xtory:title">
	<p><strong><xsl:apply-templates/></strong></p>
</xsl:template>
<xsl:template match="xtory:text/xtory:*/xtory:title"/>
<xsl:template match="xtory:appendix/xtory:*/xtory:title"/>

<xsl:template match="xtory:section">
	<div>
		<xsl:apply-templates select="*"/>
<!--		<xsl:if test="position() != last() and not(following-sibling::xtory:*[1]/xtory:title)">
			<p class="c">* * *</p>
		</xsl:if>-->
	</div>
</xsl:template>

<xsl:template match="xtory:quote">
	<blockquote class="quote">
		<xsl:apply-templates select="*"/>
<!--		<xsl:if test="position() != last() and not(following-sibling::xtory:*[1]/xtory:title)">
			<p class="c">* * *</p>
		</xsl:if>-->
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

</xsl:stylesheet>
