<xsl:transform version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:dir="http://apache.org/cocoon/directory/2.0"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory">

<xsl:template match="/dir:directory">
	<html>
		<head>
			<title>Xtory - Übersicht</title>
		</head>
		<body>
			<h1>Xtory - Übersicht</h1>
			<xsl:apply-templates select="dir:file[position()=1 or preceding-sibling::dir:file/dir:xpath/xtory:series/xtory:title != dir:xpath/xtory:series/xtory:title]" mode="series">
				<xsl:sort select="dir:xpath/xtory:series/xtory:title"/>
				<xsl:sort select="dir:xpath/xtory:series/xtory:subtitle"/>
				<xsl:sort select="dir:xpath/xtory:series/xtory:issue" data-type="number"/>
			</xsl:apply-templates>
		</body>
	</html>
</xsl:template>

<xsl:template match="dir:file" mode="series">
	<h2>
		<xsl:choose>
			<xsl:when test="not(dir:xpath/xtory:series)">Einzelromane</xsl:when>
			<xsl:otherwise><xsl:value-of select="dir:xpath/xtory:series/xtory:title"/></xsl:otherwise>
		</xsl:choose>
	</h2>
	<xsl:variable name="series" select="dir:xpath/xtory:series/xtory:title"/>
	<table border="1" width="100%">
		<tr>
			<th>Cover</th>
			<th>Nummer</th>
			<th>Zyklus</th>
			<th>Titel</th>
			<th>Autor</th>
		</tr>
		<xsl:apply-templates select="../dir:file[dir:xpath/xtory:series/xtory:title = $series]">
			<xsl:sort select="dir:xpath/xtory:series/xtory:title"/>
			<xsl:sort select="dir:xpath/xtory:series/xtory:subtitle"/>
			<xsl:sort select="dir:xpath/xtory:series/xtory:issue" data-type="number"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template match="dir:file">
	<xsl:variable name="id" select=".//text()"/>
	<tr>
		<td><xsl:if test="dir:xpath/xtory:cover"><img alt="" src="gfx/{$id}-thumb.jpg" /></xsl:if></td>
		<td><xsl:value-of select="dir:xpath/xtory:series/xtory:issue"/></td>
		<td><xsl:value-of select="dir:xpath/xtory:series/xtory:subtitle"/></td>
		<td>
			<big><a href="{$id}.html"><xsl:value-of select="dir:xpath//xtory:title"/></a></big>
			<xsl:for-each select="dir:xpath/xtory:subtitle"><br/><xsl:value-of select="."/></xsl:for-each>
		</td>
		<td><xsl:value-of select="dir:xpath//xtory:author"/></td>
	</tr>
</xsl:template>

</xsl:transform>
