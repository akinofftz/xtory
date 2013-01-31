<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xtory="http://stories.proc.org/xtory/3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">
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
	</xsl:template>
</xsl:transform>

