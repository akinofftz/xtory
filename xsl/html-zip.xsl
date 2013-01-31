<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://apache.org/cocoon/zip-archive/1.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory xsl">

	<xsl:template match="/xtory:story">
		<archive>
			<entry name="{@xtory:id}.html" src="cocoon:/{@xtory:id}.html"/>
			<xsl:if test="xtory:meta/xtory:cover">
				<entry name="gfx/{@xtory:id}.jpg" src="cocoon:/gfx/{@xtory:id}.jpg"/>
				<entry name="gfx/stories.css" src="cocoon:/gfx/stories.css"/>
			</xsl:if>
			<xsl:for-each select="xtory:text//html:img">
				<entry name="{@src}" src="cocoon:/{@src}"/>
			</xsl:for-each>
			<entry name="gfx/ie-bugfix.js" src="cocoon:/gfx/ie-bugfix.js"/>
		</archive>
		</xsl:template>
</xsl:stylesheet>
