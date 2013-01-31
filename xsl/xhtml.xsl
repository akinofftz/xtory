<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 3.0
  HTML Ausgabe

  (c) 2000-2004 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xtory="http://stories.proc.org/xtory"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xtory html xsl">

<xsl:include href="global.xsl"/>

<!--
  XHTML-Dokument (allgemein)
-->
<xsl:template match="/">
	<xsl:comment> Xtory 3.0 (c) 2000-2003 Aki Alexandra Nofftz (stories@proc.org) </xsl:comment>
	<html xml:lang="{/*/@xml:lang}">
		<head>
			<title><xsl:call-template name="Titel"/></title>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
			<xsl:element name="meta">
				<xsl:attribute name="name">Author</xsl:attribute>
				<xsl:attribute name="content">
					<xsl:value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>
					<xsl:for-each select="/*/xtory:Global/xtory:Autor/xtory:eMail">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="."/>
						<xsl:text>)</xsl:text>
					</xsl:for-each>
				</xsl:attribute>
			</xsl:element>
			<meta name="Creator" content="Aki Alexandra Nofftz (stories@proc.org)"/>
			<meta name="Generator" content="Xtory 3.0 powered by Apache Cocoon 2.1"/>
			<style type="text/css">@import url(gfx/stories.css);</style>
		</head>
		<body>
			<xsl:call-template name="kapitelliste"/>
			<div id="text">
				<h1><xsl:call-template name="Titel"/></h1>
				<p id="titelbild">
					<img src="gfx/{$dateiname}.jpg" alt=""/>
				</p>
				<div id="rubriken">
					<xsl:apply-templates select="/*/xtory:Rubriken/xtory:WasBisherGeschah|/*/xtory:Rubriken/xtory:Hauptpersonen"/>
				</div>
				<xsl:apply-templates select="/*/xtory:Text"/>
				<p id="ende">
					<xsl:choose>
						<xsl:when test="/*/@xml:lang='de'">ENDE</xsl:when>
						<xsl:when test="/*/@xml:lang='en'">THE END</xsl:when>
						<xsl:when test="/*/@xml:lang='fr'">FIN</xsl:when>
					</xsl:choose>
				</p>
				<div id="vorschau">
					<xsl:apply-templates select="/*/xtory:Rubriken/xtory:Vorschau/*"/>
				</div>
				<xsl:apply-templates select="/*/xtory:Rubriken/xtory:Kommentar|/*/xtory:Rubriken/xtory:Glossar"/>
			</div>
			<p id="impressum">
				<small>
					<xsl:call-template name="Impressum"/>
				</small>
			</p>
		</body>
	</html>
</xsl:template>

<xsl:template name="kapitelliste">
	<dl id="navigation">
		<dt>Rubriken</dt>
		<xsl:for-each select="//xtory:WasBisherGeschah">
			<dd><a href="#wasbisher" class="rubrik">Was bisher geschah</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:Hauptpersonen">
			<dd><a href="#hauptpersonen" class="rubrik">Hauptpersonen</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:Kommentar">
			<dd><a href="#kommentar" class="rubrik">Kommentar</a></dd>
		</xsl:for-each>
		<dd><a href="#impressum" class="rubrik">Impressum</a></dd>

		<dt>Kapitelübersicht</dt>
		<xsl:apply-templates select="/*/xtory:Text/xtory:Kapitel/xtory:Titel" mode="kapitelliste"/>

		<dt>Einstellungen</dt>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='150%';">Große Schrift</a></dd>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='100%';">Normale Schrift</a></dd>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='75%';">Kleine Schrift</a></dd>
	</dl>
</xsl:template>

<!--
  Rubriken
-->

<!-- Was bisher geschah -->
<xsl:template match="xtory:WasBisherGeschah">
	<div id="wasbisher" class="rubrik">
		<h3>
			<xsl:choose>
				<xsl:when test="/*/@xml:lang='de'">Was bisher geschah</xsl:when>
				<xsl:when test="/*/@xml:lang='en'">Previously in <em>Dorgon</em></xsl:when>
				<xsl:when test="/*/@xml:lang='fr'">Was bisher geschah</xsl:when>
			</xsl:choose>
		</h3>
		<xsl:apply-templates select="html:p"/>
	</div>
</xsl:template>

<!-- Hauptpersonen -->
<xsl:template match="xtory:Hauptpersonen">
	<div id="hauptpersonen" class="rubrik">
		<h3>
			<xsl:choose>
				<xsl:when test="/*/@xml:lang='de'">Hauptpersonen</xsl:when>
				<xsl:when test="/*/@xml:lang='en'">Main characters</xsl:when>
				<xsl:when test="/*/@xml:lang='fr'">Hauptpersonen</xsl:when>
			</xsl:choose>
		</h3>
		<dl>
			<xsl:apply-templates select="xtory:Person"/>
		</dl>
	</div>
</xsl:template>
<xsl:template match="xtory:Hauptpersonen/xtory:Person">
	<dt><xsl:apply-templates select="xtory:Name"/>: </dt>
	<dd><xsl:value-of select="xtory:Was"/></dd>
</xsl:template>
<xsl:template match="xtory:Hauptpersonen/xtory:Person/xtory:Name[position()&gt;1]">
	<xsl:text>, </xsl:text>
	<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="xtory:Hauptpersonen/xtory:Person/xtory:Name[last()]">
	<xsl:text> und </xsl:text>
	<xsl:value-of select="."/>
</xsl:template>
<xsl:template match="xtory:Hauptpersonen/xtory:Person/xtory:Name[1]">
	<xsl:value-of select="."/>
</xsl:template>


<!-- Kommentar -->
<xsl:template match="xtory:Kommentar">
	<div id="kommentar" class="rubrik">
		<h3><xsl:apply-templates select="xtory:Titel"/></h3>
		<xsl:apply-templates select="*[position() &gt; 1]"/>
	</div>
</xsl:template>
<xsl:template match="/xtory:Dorgon//xtory:Kommentar/xtory:Titel">
	<xsl:choose>
		<xsl:when test="/*/@xml:lang='de'">DORGON Kommentar</xsl:when>
		<xsl:when test="/*/@xml:lang='en'"><em>Dorgon</em> commentary</xsl:when>
		<xsl:when test="/*/@xml:lang='fr'">DORGON Kommentar</xsl:when>
	</xsl:choose>
	<br/>
	<small><xsl:value-of select="."/></small>
</xsl:template>
<xsl:template match="/xtory:Xtory//xtory:Kommentar/xtory:Titel|/xtory:Terracom//xtory:Kommentar/xtory:Titel">
  <xsl:text>Der Kommentar</xsl:text>
  <br/>
  <small><xsl:value-of select="."/></small>
</xsl:template>
<xsl:template match="xtory:Kommentar/xtory:Autor">
  <p style="text-align:right"><strong><xsl:value-of select="xtory:Name"/></strong></p>
</xsl:template>

<!-- Glossar -->
<xsl:template match="xtory:Glossar">
	<div id="glossar" class="rubrik">
		<h3>
			<xsl:text>Glossar</xsl:text>
			<xsl:apply-templates select="xtory:Titel"/>
		</h3>
		<dl>
			<xsl:apply-templates select="xtory:Erklärung"/>
		</dl>
	</div>
</xsl:template>
<xsl:template match="xtory:Glossar/xtory:Erklärung">
	<dt><xsl:value-of select="xtory:Titel"/>: </dt>
	<dd>
		<xsl:apply-templates select="xtory:p"/>
	</dd>
</xsl:template>
<xsl:template match="xtory:Glossar/xtory:Titel">
  <br/><small><xsl:value-of select="."/></small>
</xsl:template>



<!--
  Romantext
-->

<xsl:template match="xtory:Text">
	<div id="roman">
		<xsl:apply-templates select="xtory:Kapitel"/>
	</div>
</xsl:template>

<xsl:template match="xtory:Kapitel">
	<div id="kap{@xtory:num}">
		<h2><xsl:apply-templates select="xtory:Titel"/></h2>
		<xsl:apply-templates select="xtory:Abschnitt|xtory:Zitat"/>
	</div>
</xsl:template>

<xsl:template match="xtory:Kapitel/@xtory:num">
	<xsl:choose>
		<xsl:when test=".=0">
			<xsl:choose>
				<xsl:when test="/*/@xml:lang='de'">Prolog</xsl:when>
				<xsl:when test="(/*/@xml:lang='en') or (/*/@xml:lang='fr')">Prologue</xsl:when>
			</xsl:choose>
		</xsl:when>
		<xsl:when test=".=99">
			<xsl:choose>
				<xsl:when test="/*/@xml:lang='de'">Epilog</xsl:when>
				<xsl:when test="(/*/@xml:lang='en') or (/*/@xml:lang='fr')">Epilogue</xsl:when>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
	</xsl:choose>
	<xsl:text>. </xsl:text>
</xsl:template>

<xsl:template match="xtory:Titel">
	<span class="nummer">
		<xsl:apply-templates select="../@xtory:num"/>
		<xsl:if test="../@xtory:num != 0 and ../@xtory:num != 99">
			<xsl:text>Kapitel</xsl:text>
		</xsl:if>
	</span>
	<br/>
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="xtory:Titel" mode="kapitelliste">
	<dd>
		<a href="#kap{../@xtory:num}">
			<xsl:apply-templates select="../@xtory:num"/>
			<xsl:value-of select="."/>
<!--
			<xsl:variable name="titel"><xsl:apply-templates select="."/></xsl:variable>
			<xsl:choose>
				<xsl:when test="string-length($titel) &gt; 20">
					<xsl:value-of select="substring($titel, 0, 20)"/>
					<xsl:text>&#xA0;&#x2026;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$titel"/>
				</xsl:otherwise>
			</xsl:choose>
-->
		</a>
	</dd>
</xsl:template>

<xsl:template match="xtory:Vorschau/xtory:Titel">
	<p id="naechstes">
		<xsl:value-of select="."/>
	</p>
</xsl:template>

<xsl:template match="xtory:Abschnitt/html:p[1]/text()[1]">
	<xsl:choose>
		<xsl:when test="(substring(self::text(),1,1)='»') or (substring(self::text(),1,1)='«') or (substring(self::text(),1,1)='&#8220;')">
			<big><xsl:value-of select="substring(self::text(),2,1)"/></big>
			<xsl:value-of select="substring(self::text(),3)"/>
		</xsl:when>
		<xsl:otherwise>
			<big><xsl:value-of select="substring(self::text(),1,1)"/></big>
			<xsl:value-of select="substring(self::text(),2)"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- kopierter Driss ;-) -->

<xsl:template match="xtory:Zitat">
	<blockquote>
		<xsl:apply-templates select="html:p"/>
	</blockquote>
</xsl:template>

<xsl:template match="xtory:Abschnitt">
	<div>
		<xsl:apply-templates select="html:p"/>
	</div>
</xsl:template>

<xsl:template match="html:ol|html:ul">
	<xsl:copy>
		<xsl:apply-templates select="html:li"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="html:p">
	<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="html:small">
	<small><xsl:apply-templates/></small>
</xsl:template>

<xsl:template match="html:em">
	<em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="html:sup">
	<sup><xsl:apply-templates/></sup>
</xsl:template>

<xsl:template match="html:li">
	<li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="html:br">
	<br/>
</xsl:template>

<xsl:template match="text()">
	<xsl:copy/>
</xsl:template>

</xsl:stylesheet>
