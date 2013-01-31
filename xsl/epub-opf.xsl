<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 3.1
  ePUB Ausgabe - OPF

  (c) 2000-2010 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="2.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.idpf.org/2007/opf"
	exclude-result-prefixes="xtory html xsl">

<xsl:import href="global.xsl"/>

<xsl:param name="lang">de</xsl:param>
	
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/xtory:story">
<package version="2.0" unique-identifier="uri">
	<metadata>
		<dc:title><xsl:call-template name="title"/></dc:title>
		<xsl:for-each select="xtory:meta/xtory:author">
			<dc:creator role="aut"><xsl:value-of select="."/></dc:creator>
		</xsl:for-each>
		<dc:date><xsl:value-of select="xtory:meta/xtory:lastmod"/></dc:date>
		<dc:type>novel</dc:type>
		<dc:identifier id="uri">
			<xsl:text>http://www.stories.proc.org/</xsl:text>
			<xsl:value-of select="@xtory:id"/>
			<xsl:text>/</xsl:text>
			<xsl:value-of select="$lang"/>
		</dc:identifier>
		<dc:language><xsl:value-of select="$lang"/></dc:language>
		<dc:publisher>Perry Rhodan Online Club</dc:publisher>
		<dc:subject>Fan-Publikation des Perry Rhodan Online Club e.V.</dc:subject>
	</metadata>
	<manifest>
		<item id="ncx" href="xtory.ncx" media-type="application/x-dtbncx-xml"/>
		<xsl:if test="xtory:meta/xtory:cover">
			<item id="cover" href="cover.xhtml" media-type="application/xhtml+xml"/>
		</xsl:if>
		<item id="title" href="title.xhtml" media-type="application/xhtml+xml"/>
		<xsl:for-each select="xtory:prefix|xtory:text|xtory:appendix">
			<xsl:for-each select="xtory:*">
				<xsl:variable name="id"><xsl:apply-templates select="." mode="id"/></xsl:variable>
				<item id="{$id}" href="{$id}.xhtml" media-type="application/xhtml+xml"/>
			</xsl:for-each>
		</xsl:for-each>
		<item id="imprint" href="imprint.xhtml" media-type="application/xhtml+xml"/>
	</manifest>
	<spine toc="ncx">
		<xsl:if test="xtory:meta/xtory:cover">
			<itemref idref="cover"/>
		</xsl:if>
		<itemref idref="title"/>
		<xsl:for-each select="xtory:prefix|xtory:text|xtory:appendix">
			<xsl:for-each select="xtory:*">
				<itemref>
					<xsl:attribute name="idref">
						<xsl:apply-templates select="." mode="id"/>
					</xsl:attribute>
				</itemref>
			</xsl:for-each>
		</xsl:for-each>
		<itemref idref="imprint"/>
	</spine>
	<guide>
		<xsl:if test="xtory:meta/xtory:cover">
			<reference type="cover" title="Cover" href="cover.xhtml"/>
		</xsl:if>
		<reference type="title-page" title="Cover" href="title.xhtml"/>
		<xsl:for-each select="xtory:prefix|xtory:text|xtory:appendix">
			<xsl:for-each select="xtory:*">
				<reference type="text">
					<xsl:attribute name="title">
						<xsl:apply-templates select="." mode="label"/>
					</xsl:attribute>
					<xsl:attribute name="href">
						<xsl:apply-templates select="." mode="id"/>
						<xsl:text>.xhtml</xsl:text>
					</xsl:attribute>
				</reference>
			</xsl:for-each>
		</xsl:for-each>
		<reference type="copyright-page" title="Impressum" href="imprint.xhtml"/>
	</guide>
</package>
</xsl:template>

<xsl:template name="imprint-name"><!-- hier nicht verwendet --></xsl:template>

</xsl:stylesheet>
