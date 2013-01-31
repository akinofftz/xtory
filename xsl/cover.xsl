<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:ext="http://xml.apache.org/batik/ext"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	exclude-result-prefixes="xtory xsl">

<xsl:param name="pdf"/>

<xsl:template match="/">
	<xsl:apply-templates select="xtory:story" mode="cover">
		<xsl:with-param name="scale">
			<xsl:choose>
				<xsl:when test="$pdf">2</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="height">
			<xsl:choose>
				<xsl:when test="$pdf">721</xsl:when>
				<xsl:otherwise>680</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="xtory:story" mode="cover">
	<xsl:param name="scale"/>
	<xsl:param name="height"/>
	<xsl:variable name="boxcolor"><!-- Farbe vom Titelkasten und Nummer -->
		<xsl:choose>
			<xsl:when test="xtory:meta/xtory:series/xtory:title = 'Thydery'">#dd0000</xsl:when>
			<xsl:otherwise>#c9b72b</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<svg width="{510 * $scale}" height="{$height * $scale}">
		<defs>
			<font-face font-family="Trebuchet MS">
				<font-face-src>
					<font-face-name name="Trebuchet MS" />
					<font-face-uri xlink:href="tibis/trebuchet.svg#trebuchet">
						<font-face-format string="svg" />
					</font-face-uri>
					<font-face-uri xlink:href="tibis/trebuchet.svg#trebuchetbold">
						<font-face-format string="svg" />
					</font-face-uri>
				</font-face-src>
			</font-face>
			<style type="text/css" id="style">
				<xsl:text>flowText{font-family:'Trebuchet MS'}</xsl:text>
				<xsl:if test="xtory:meta/xtory:series">
					<xsl:text>#series{font-family:'Trebuchet MS';font-size:11;fill:</xsl:text>
					<xsl:value-of select="$boxcolor"/>
					<xsl:text>}</xsl:text>
				</xsl:if>
				<xsl:for-each select="xtory:meta/xtory:cover">
					<xsl:if test="@xtory:author">
						<xsl:text>.author{font-size:22;fill:</xsl:text>
						<xsl:value-of select="@xtory:author"/>
						<xsl:text>}</xsl:text>
					</xsl:if>
					<xsl:if test="@xtory:title">
						<xsl:text>.title{font-size:36;margin-bottom:5px;font-weight:bold;fill:</xsl:text>
						<xsl:value-of select="@xtory:title"/>
						<xsl:text>}</xsl:text>
					</xsl:if>
					<xsl:if test="@xtory:subtitle">
						<xsl:text>.subtitle{font-size:14;font-weight:bold;fill:</xsl:text>
						<xsl:value-of select="@xtory:subtitle"/>
						<xsl:text>}</xsl:text>
					</xsl:if>
					<xsl:if test="@xtory:author or @xtory:title or @xtory:subtitle">
						<xsl:text>.shadow flowPara{fill:#000 !important;fill-opacity:</xsl:text>
						<xsl:choose>
							<xsl:when test="@xtory:shadow"><xsl:value-of select="@xtory:shadow"/></xsl:when>
							<xsl:otherwise>0.5</xsl:otherwise>
						</xsl:choose>
						<xsl:text>}</xsl:text>
					</xsl:if>
				</xsl:for-each>
			</style>
		</defs>
		<g transform="scale({$scale})">
			<rect x="0" y="0" width="510" height="{$height}" fill="#000000"/>
			<image xlink:href="tibis/{@xtory:id}.jpg" x="0" y="0" width="510" height="{$height}"/>
			<rect x="20" y="20" width="250" height="100" fill="#000" stroke-width="2" stroke="{$boxcolor}"/>
			<image x="25" y="25" height="90" width="53" xlink:href="tibis/proc.png"/>
			<xsl:choose>
				<xsl:when test="xtory:meta/xtory:series/xtory:title = 'Dorgon'">
					<image x="78" y="43" height="54" width="180" xlink:href="tibis/dorgon.png"/>
				</xsl:when>
				<xsl:when test="xtory:meta/xtory:series/xtory:title = 'Vithau'">
					<image x="78" y="43" height="54" width="180" xlink:href="tibis/vithau.png"/>
				</xsl:when>
				<xsl:when test="xtory:meta/xtory:series/xtory:title = 'Shadow Warrior'">
					<image x="78" y="43" height="54" width="180" xlink:href="tibis/sw.png"/>
				</xsl:when>
				<xsl:when test="xtory:meta/xtory:series/xtory:title = 'Thydery'">
					<image x="78" y="43" height="54" width="180" xlink:href="tibis/thydery.png"/>
				</xsl:when>
				<xsl:otherwise>
					<image x="78" y="43" height="54" width="180" xlink:href="tibis/stories.png"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="xtory:meta/xtory:series">
				<ext:flowText id="series">
					<ext:flowRegion vertical-align="top">
						<ext:rect x="78" y="95" width="177" height="12"/>
					</ext:flowRegion>
					<ext:flowDiv>
						<ext:flowRegionBreak justification="end">
							<xsl:if test="xtory:subtitle">
								<xsl:value-of select="xtory:subtitle"/>
							</xsl:if>
							<xsl:if test="xtory:subtitle and xtory:issue"> &#183; </xsl:if>
							<xsl:if test="xtory:issue">
								<xsl:text>Band </xsl:text>
								<xsl:value-of select="xtory:issue"/>
							</xsl:if>
						</ext:flowRegionBreak>
					</ext:flowDiv>
				</ext:flowText>
			</xsl:for-each>
			<ext:flowText class="shadow">
				<ext:flowRegion vertical-align="bottom">
					<ext:rect x="22" y="462" width="470" height="200"/>
				</ext:flowRegion>
				<xsl:apply-templates select="xtory:meta"/>
			</ext:flowText>
			<ext:flowText>
				<ext:flowRegion vertical-align="bottom">
					<ext:rect x="20" y="460" width="470" height="200"/>
				</ext:flowRegion>
				<xsl:apply-templates select="xtory:meta"/>
			</ext:flowText>
		</g>
	</svg>
</xsl:template>

<xsl:template match="xtory:meta">
		<ext:flowDiv>
			<xsl:if test="xtory:cover/@xtory:author">
				<xsl:for-each select="xtory:author">
					<ext:flowPara class="author">
						<xsl:attribute name="justification"><xsl:value-of select="../xtory:cover/@xtory:align"/></xsl:attribute>
						<xsl:value-of select="."/>
					</ext:flowPara>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="xtory:cover/@xtory:title">
				<ext:flowPara class="title">
					<xsl:attribute name="justification"><xsl:value-of select="xtory:cover/@xtory:align"/></xsl:attribute>
					<xsl:value-of select="xtory:title"/>
				</ext:flowPara>
			</xsl:if>
			<xsl:if test="xtory:cover/@xtory:subtitle">
				<ext:flowPara font-size="6pt">&#160;</ext:flowPara>
				<xsl:for-each select="xtory:subtitle">
					<ext:flowPara class="subtitle">
						<xsl:attribute name="justification"><xsl:value-of select="../xtory:cover/@xtory:align"/></xsl:attribute>
						<xsl:value-of select="."/>
					</ext:flowPara>
				</xsl:for-each>
			</xsl:if>-->
		</ext:flowDiv>
</xsl:template>

</xsl:stylesheet>
