<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x-alt="http://stories.proc.org/xtory"
	exclude-result-prefixes="x-alt xsl html">

<xsl:output method="xml" encoding="UTF-8" indent="yes" standalone="yes"/>


<xsl:template match="/*">
	<xtory:story>
		<xsl:apply-templates select="@x-alt:heft|@x-alt:story"/>
		<xsl:copy-of select="@xml:lang"/>
		<xsl:apply-templates select="x-alt:Global"/>
		<xtory:prefix>
			<xsl:apply-templates select="x-alt:Rubriken/x-alt:WasBisherGeschah|x-alt:Rubriken/x-alt:Hauptpersonen"/>
		</xtory:prefix>
		<xsl:apply-templates select="x-alt:Text"/>
		<xtory:appendix>
			<xsl:apply-templates select="x-alt:Rubriken/x-alt:*[not(local-name()='WasBisherGeschah') and not(local-name()='Hauptpersonen')]"/>
		</xtory:appendix>
	</xtory:story>
</xsl:template>

<xsl:template match="/x-alt:Dorgon/@x-alt:heft">
	<xsl:attribute name="id" namespace="http://stories.proc.org/xtory/3.0">dorgon<xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="x-alt:Global">
	<xtory:meta>
		<xsl:apply-templates select="x-alt:Titel"/>
		<xtory:subtitle><xsl:value-of select="x-alt:Untertitel"/></xtory:subtitle>
		<xsl:apply-templates select="x-alt:Autor"/>
		<xsl:for-each select="x-alt:Titelbild">
			<xtory:painter>
				<xsl:if test="x-alt:eMail">
					<xsl:attribute name="xtory:email"><xsl:value-of select="x-alt:eMail"/></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="x-alt:Name"/>
			</xtory:painter>
		</xsl:for-each>
		<xsl:for-each select="x-alt:Korrektur">
			<xtory:proofreader>
				<xsl:if test="x-alt:eMail">
					<xsl:attribute name="xtory:email"><xsl:value-of select="x-alt:eMail"/></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="x-alt:Name"/>
			</xtory:proofreader>
		</xsl:for-each>
		<xsl:for-each select="x-alt:Übersetzung">
			<xtory:translator>
				<xsl:if test="x-alt:eMail">
					<xsl:attribute name="xtory:email"><xsl:value-of select="x-alt:eMail"/></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="x-alt:Name"/>
			</xtory:translator>
		</xsl:for-each>
		<xsl:choose>
			<xsl:when test="/x-alt:Dorgon">
				<xtory:series>
					<xtory:title>Dorgon</xtory:title>
					<xtory:issue><xsl:value-of select="/*/@x-alt:heft"/></xtory:issue>
				</xtory:series>
			</xsl:when>
			<xsl:when	test="/x-alt:Vithau">
				<xtory:series>
					<xtory:title>Vithau</xtory:title>
					<xtory:issue><xsl:value-of select="/*/@x-alt:heft"/></xtory:issue>
				</xtory:series>
			</xsl:when>
		</xsl:choose>
		<xtory:last-mod><xsl:value-of select="/*/@x-alt:erschienen"/></xtory:last-mod>
	</xtory:meta>
</xsl:template>

<xsl:template match="x-alt:Titel">
	<xtory:title><xsl:apply-templates/></xtory:title>
</xsl:template>

<xsl:template match="x-alt:Autor">
	<xtory:author>
		<xsl:if test="x-alt:eMail">
			<xsl:attribute name="xtory:email"><xsl:value-of select="x-alt:eMail"/></xsl:attribute>
		</xsl:if>
		<xsl:value-of select="x-alt:Name"/>
	</xtory:author>
</xsl:template>

<xsl:template match="x-alt:WasBisherGeschah">
	<xtory:preface>
		<xsl:apply-templates select="*"/>
	</xtory:preface>
</xsl:template>

<xsl:template match="x-alt:Hauptpersonen">
	<xtory:characters>
		<xsl:for-each select="x-alt:Person">
			<xtory:role>
				<xsl:for-each select="x-alt:Name">
					<xtory:name><xsl:apply-templates/></xtory:name>
				</xsl:for-each>
				<xtory:action><xsl:apply-templates select="x-alt:Was/node()"/></xtory:action>
			</xtory:role>
		</xsl:for-each>
	</xtory:characters>
</xsl:template>

<xsl:template match="x-alt:Vorschau">
	<xtory:preview>
		<xsl:apply-templates select="*"/>
	</xtory:preview>
</xsl:template>

<xsl:template match="x-alt:Kommentar">
	<xtory:commentary>
		<xsl:apply-templates select="*"/>
	</xtory:commentary>
</xsl:template>

<xsl:template match="x-alt:Glossar">
<!-- FEHLT NOCH! -->
</xsl:template>

<xsl:template match="x-alt:Text">
	<xtory:text xtory:first-chapter="1">
		<xsl:apply-templates select="x-alt:Kapitel"/>
	</xtory:text>
</xsl:template>

<xsl:template match="x-alt:Kapitel[@x-alt:num=0]">
	<xtory:prologue>
		<xsl:apply-templates select="*"/>
	</xtory:prologue>
</xsl:template>

<xsl:template match="x-alt:Kapitel[@x-alt:num=99]">
	<xtory:epilogue>
		<xsl:apply-templates select="*"/>
	</xtory:epilogue>
</xsl:template>

<xsl:template match="x-alt:Kapitel">
	<xtory:chapter>
		<xsl:apply-templates select="*"/>
	</xtory:chapter>
</xsl:template>

<xsl:template match="x-alt:Abschnitt">
	<xtory:section>
		<xsl:apply-templates select="*"/>
	</xtory:section>
</xsl:template>

<xsl:template match="x-alt:Zitat">
	<xtory:quotation>
		<xsl:apply-templates select="*"/>
	</xtory:quotation>
</xsl:template>


<xsl:template match="*" priority="-2">
	<xsl:element name="{local-name()}" namespace="{namespace-uri()}">
		<xsl:apply-templates select="@*|*|text()"/>
	</xsl:element>
</xsl:template>

<xsl:template match="@*" priority="-2">
	<xsl:attribute name="{name()}" namespace="{namespace-uri()}">
		<xsl:value-of select="."/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="text()">
	<xsl:copy/>
</xsl:template>

</xsl:stylesheet>
