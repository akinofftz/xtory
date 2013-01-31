<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://apache.org/cocoon/zip-archive/1.0"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory xsl">

	<xsl:template match="/xtory:story">
		<archive>
			<entry name="{@xtory:id}.opf" src="cocoon:/oeb/{@xtory:id}.opf"/>
			<entry name="{@xtory:id}.html" src="cocoon:/oeb/{@xtory:id}.html"/>
			<xsl:if test="/xtory:story/xtory:meta/xtory:cover">
				<entry name="{@xtory:id}.jpg" src="cocoon:/gfx/{@xtory:id}.jpg"/>
				<entry name="{@xtory:id}-thumb.jpg" src="cocoon:/gfx/{@xtory:id}-thumb.jpg"/>
			</xsl:if>
		</archive>
		</xsl:template>
</xsl:stylesheet>
