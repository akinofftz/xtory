<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 2.0
  HTML Ausgabe -> Online Ansicht

  (c) 2000-2003 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="1.1"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="html:img/@src[substring(.,1,5)='skin/' or substring(.,1,4)='gfx/']">
		<xsl:attribute name="src">
			<xsl:text>/</xsl:text>
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="/|@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>