<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xtory="http://stories.proc.org/xtory/3.0" xmlns:html="http://www.w3.org/1999/xhtml">

<xsl:output method="text"/>

<xsl:template match="/xtory:story">
	<xsl:text>INSERT INTO stories (id, kategorie, titel, untertitel, autor, autoremail,
tibi, tibiemail, html, pdf, lit, rb, doc, mobi, oeb, text, beschreibung,
stand)
 VALUES ('</xsl:text>
 	<xsl:value-of select="/xtory:story/@xtory:id"/>
	<xsl:text>',1150,'</xsl:text>
	<xsl:for-each select="/xtory:story/xtory:meta/xtory:series">
		<xsl:choose>
			<xsl:when test="xtory:title = 'PROC Stories' and xtory:subtitle">
				<xsl:value-of select="xtory:subtitle"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="xtory:title"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>
		<xsl:if test="(xtory:title = 'Dorgon') and (xtory:subtitle = 'Dorgon Extra')">Extra </xsl:if>
		<xsl:value-of select="xtory:issue"/>
		<xsl:text>: </xsl:text>
	</xsl:for-each>
	<xsl:value-of select="/xtory:story/xtory:meta/xtory:title"/>
<xsl:text>',</xsl:text>
<xsl:choose>
	<xsl:when test="xtory:meta/xtory:subtitle">'<xsl:value-of select="xtory:meta/xtory:subtitle"/>'</xsl:when>
	<xsl:otherwise>NULL</xsl:otherwise>
</xsl:choose>,
'<xsl:value-of select="xtory:meta/xtory:author"/>',
<xsl:choose>
	<xsl:when test="xtory:meta/xtory:author/@xtory:email">'<xsl:value-of select="xtory:meta/xtory:author/@xtory:email"/>'</xsl:when>
	<xsl:otherwise>NULL</xsl:otherwise>
</xsl:choose>,
<xsl:choose>
	<xsl:when test="xtory:meta/xtory:painter">'<xsl:value-of select="xtory:meta/xtory:painter"/>'</xsl:when>
	<xsl:otherwise>NULL</xsl:otherwise>
</xsl:choose>,
<xsl:choose>
	<xsl:when test="xtory:meta/xtory:painter/@xtory:email">'<xsl:value-of select="xtory:meta/xtory:painter/@xtory:email"/>'</xsl:when>
	<xsl:otherwise>NULL</xsl:otherwise>
</xsl:choose>,
0, 0, -1, 0, 0, 0, 0, 0,
'<xsl:apply-templates select="xtory:prefix/xtory:preface"/>',
NOW())
</xsl:template>

<xsl:template match="xtory:preface">
	<xsl:apply-templates select="html:p"/>
</xsl:template>

<xsl:template match="html:*">
	<xsl:text>&lt;</xsl:text>
	<xsl:value-of select="name()"/>
	<xsl:text>&gt;</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>&lt;/</xsl:text>
	<xsl:value-of select="name()"/>
	<xsl:text>&gt;</xsl:text>
</xsl:template>

</xsl:transform>

