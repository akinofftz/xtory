<?xml version='1.0' encoding='UTF-8'?>
<!--
  Xtory 3.2
  Globale Variablen

  (c) 2000-2010 Aki Alexandra Nofftz
-->
<xsl:transform version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xtory="http://stories.proc.org/xtory/3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="html xtory">

	<xsl:template match="/">
		<xsl:comment> Xtory 3.2 © 2000‑2010 Aki Alexandra Nofftz (stories@proc.org) </xsl:comment>
		<xsl:if test="not(//*[lang($lang)])">
			<xsl:message terminate="yes">Fatal: Language not supported by this document.</xsl:message>
		</xsl:if>
		<xsl:apply-templates select="xtory:story"/>
	</xsl:template>

	<!--
		ID für Kapitel oder Rubrik (preface1, chapter5, appendix2)
	-->
	<xsl:template match="xtory:prefix/xtory:*|xtory:text/xtory:*|xtory:appendix/xtory:*" mode="id">
		<xsl:value-of select="concat(local-name(..), 1 + count(preceding-sibling::xtory:*))"/>
	</xsl:template>

	<!--
		Bezeichner eines Abschnitts, z.B. für Navigation (»Was bisher geschah«, »5. Kapitel«)
	-->
	<xsl:template match="xtory:preface" mode="label">Was bisher geschah</xsl:template>
	<xsl:template match="xtory:characters" mode="label">Hauptpersonen</xsl:template>
	<xsl:template match="xtory:preview" mode="label">Vorschau</xsl:template>
	<xsl:template match="xtory:commentary" mode="label">Kommentar</xsl:template>
	<xsl:template match="xtory:glossary" mode="label">Glossar</xsl:template>
	<xsl:template match="xtory:prologue" mode="label">Prolog</xsl:template>
	<xsl:template match="xtory:epilogue" mode="label">Epilog</xsl:template>
	<xsl:template match="xtory:text/xtory:chapter" mode="label">
		<xsl:if test="../@xtory:first-chapter">
			<xsl:value-of select="count(preceding-sibling::xtory:chapter) + ../@xtory:first-chapter"/>
			<xsl:text>. </xsl:text>
		</xsl:if>
		<xsl:value-of select="xtory:title[1]"/>
	</xsl:template>
	<xsl:template match="xtory:*" mode="label"><xsl:value-of select="local-name()"/></xsl:template>

  <!--
    Titel (mit Heftnummer)
  -->
	<xsl:template name="title">
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
		<xsl:value-of select="/xtory:story/xtory:meta/xtory:title[lang($lang)]"/>
  </xsl:template>

  <!--
    Impressum
  -->
  <xsl:template name="imprint">
    <xsl:choose>
      <!-- Impressum für Dorgon (Anfang) -->
      <xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
        <xsl:choose>
          <!-- Deutsches DORGON-Impressum -->
          <xsl:when test="$lang='de'">
            <xsl:text>Die DORGON-Serie </xsl:text>
						<xsl:if test="/xtory:story/xtory:meta/xtory:series/xtory:subtitle">
							<xsl:text>&#8211; </xsl:text>
							<xsl:value-of select="/xtory:story/xtory:meta/xtory:series/xtory:subtitle"/>
							<xsl:text> &#8211; </xsl:text>
						</xsl:if>
						<xsl:text>ist eine nicht </xsl:text>
            <xsl:text>kommerzielle Publikation des PERRY RHODAN ONLINE CLUB e.V.</xsl:text>
					</xsl:when>
          <!-- Englisches DORGON-Impressum -->
          <xsl:when test="$lang='en'">
            <xsl:text>Set in the Perry Rhodan universe, the </xsl:text>
            <em>Dorgon</em>
            <xsl:text> space adventure series is a non-commercial fan publication</xsl:text>
            <xsl:text> of the Perry Rhodan Online Club e.V., Germany</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<!-- VITHAU-Impressum -->
			<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Vithau'">
				<xsl:text>VITHAU - eine interaktive Story - ist eine nicht </xsl:text>
				<xsl:text>kommerzielle Publikation des PERRY RHODAN ONLINE CLUB e.V.</xsl:text>
			</xsl:when>
			<!-- THYDERY-Impressum -->
			<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Thydery'">
				 <xsl:text>Die Internet SF-Serie THYDERY </xsl:text>
						<xsl:if test="/xtory:story/xtory:meta/xtory:series/xtory:subtitle">
							<xsl:text>&#8211; </xsl:text>
							<xsl:value-of select="/xtory:story/xtory:meta/xtory:series/xtory:subtitle"/>
							<xsl:text> &#8211; </xsl:text>
						</xsl:if>
						<xsl:text>ist eine nicht </xsl:text>
	            <xsl:text>kommerzielle Publikation des PERRY RHODAN ONLINE CLUB e.V.</xsl:text>
			</xsl:when>
			<!-- Shadow Warrior-Impressum -->
			<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Shadow Warrior'">
				<xsl:text>Shadow Warrior - eine Internet-Fanserie - ist eine nicht </xsl:text>
				<xsl:text>kommerzielle Publikation des PERRY RHODAN ONLINE CLUB e.V.</xsl:text>
			</xsl:when>
			<!-- PROC Stories -->
			<xsl:otherwise>
         <xsl:text>PROC STORIES - Fan-Stories vom PROC - ist eine nicht </xsl:text>
         <xsl:text>kommerzielle Publikation des PERRY RHODAN ONLINE CLUB e.V.. Kurzgeschichte »</xsl:text>
				 <xsl:value-of select="/xtory:story/xtory:meta/xtory:title[lang($lang)]"/>
				 <xsl:text>«</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$lang='de'">
				<xsl:choose>
					<xsl:when test="/xtory:story/xtory:meta/xtory:series">
						<xsl:text>. Band </xsl:text>
						<xsl:value-of select="/xtory:story/xtory:meta/xtory:series/xtory:issue"/>
						<xsl:text> z</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>. Z</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>uletzt geändert am </xsl:text>
			</xsl:when>
			<xsl:when test="$lang='en'">
				<xsl:choose>
					<xsl:when test="/xtory:story/xtory:meta/xtory:series">
						<xsl:text>. Episode </xsl:text>
						<xsl:value-of select="/xtory:story/xtory:meta/xtory:series/xtory:issue"/>
						<xsl:text> l</xsl:text>
						</xsl:when>
						<xsl:otherwise>
						<xsl>. L</xsl>
						</xsl:otherwise>
					</xsl:choose>
				<xsl:text>ast modified: </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="/xtory:story/xtory:meta/xtory:lastmod[lang($lang)]"/>
		<xsl:apply-templates select="/xtory:story/xtory:meta/xtory:author" mode="imprint"/>
		<xsl:apply-templates select="/xtory:story/xtory:meta/xtory:painter" mode="imprint"/>
		<xsl:apply-templates select="/xtory:story/xtory:meta/xtory:illustrations" mode="imprint"/>
		<xsl:apply-templates select="/xtory:story/xtory:meta/xtory:translator[lang($lang)]" mode="imprint"/>
		<xsl:apply-templates select="/xtory:story/xtory:meta/xtory:proofreader[lang($lang)]" mode="imprint"/>
		<xsl:choose>
			<xsl:when test="$lang='de'">. Generiert mit Xtory 3.2 von </xsl:when>
			<xsl:when test="$lang='en'">. Generated using Xtory 3.2 by </xsl:when>
		</xsl:choose>
		<xsl:call-template name="imprint-name">
			<xsl:with-param name="email">stories@proc.org</xsl:with-param>
			<xsl:with-param name="name">Aki Alexandra Nofftz</xsl:with-param>
		</xsl:call-template>
    <xsl:choose>
      <!-- Impressum für Dorgon -->
      <xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
				<xsl:text>. Homepage: http://www.dorgon.net/</xsl:text>
				<xsl:text>. E-Mail: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">dorgon@proc.org</xsl:with-param>
					<xsl:with-param name="name">dorgon@proc.org</xsl:with-param>
				</xsl:call-template>
				<xsl:choose>
          <xsl:when test="$lang='de'">
            <!--<xsl:text>. Technischer Berater: </xsl:text>
            <xsl:call-template name="imprint-name">
							<xsl:with-param name="email">its.laire@online.de</xsl:with-param>
							<xsl:with-param name="name">Sebastian Schäfer</xsl:with-param>
						</xsl:call-template>-->
            <xsl:text>. Adresse: PROC e.V.; z. Hd. Nils Hirseland; Redder 15; </xsl:text>
            <xsl:text>D-23730 Sierksdorf; Deutschland. Copyright © 1999–2010. Alle Rechte vorbehalten!</xsl:text>
          </xsl:when>
					<xsl:when test="$lang='en'">
            <xsl:text>. Postal Address: Perry Rhodan Online Club, c/o Nils Hirseland, </xsl:text>
            <xsl:text>Redder 15, D-23730 Sierksdorf, Germany. Any income from printed versions of </xsl:text>
            <xsl:text>Dorgon is used solely to cover expenses. All rights in Dorgon </xsl:text>
            <xsl:text>are held by the Perry Rhodan Online Club, except as otherwise stated. </xsl:text>
            <xsl:text>The rights in each individual episode of Dorgon </xsl:text>
            <xsl:text>are held by the respective author, and the rights in any artwork created for </xsl:text>
            <xsl:text>Dorgon are held by the respective artist. All rights in PERRY RHODAN&#174; </xsl:text>
            <xsl:text>and in all related characters and creations are owned by Verlag Pabel-Moewig KG, Germany.</xsl:text>
            <xsl:text>Dorgon is a work of fiction. All characters and events portrayed in Dorgon </xsl:text>
            <xsl:text>are fictitious, and any resemblance to real people or events is purely coincidental. </xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
      <!-- Impressum für VITHAU -->
      <xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Vithau'">
				<xsl:text>. Nach einer Idee von: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">proc@schwippl.de</xsl:with-param>
					<xsl:with-param name="name">Rainer Schwippl</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Homepage: http://www.vithau.proc.org/. E-Mail: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">vithau@proc.org</xsl:with-param>
					<xsl:with-param name="name">vithau@proc.org</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Copyright © 2000-2010. Alle Rechte vorbehalten!</xsl:text>
			</xsl:when>
	  <!-- Impressum für THYDERY -->
      <xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Thydery'">
				<xsl:text>. Nach einer Idee von: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">dennis_mathiak@yahoo.de</xsl:with-param>
					<xsl:with-param name="name">Dennis Mathiak</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Homepage: http://www.thydery.de/. E-Mail: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">meinung@thydery.de</xsl:with-param>
					<xsl:with-param name="name">meinung@thydery.de</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Copyright © 2006-2010. Alle Rechte vorbehalten!</xsl:text>
			</xsl:when>
      <!-- Impressum für Shadow Warrior -->
      <xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Shadow Warrior'">
				<xsl:text>. Nach einer Idee von: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">ralf.koenig@dorgon.net</xsl:with-param>
					<xsl:with-param name="name">Ralf König</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Homepage: http://www.shadowwarrior.proc.org/. E-Mail: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">shadowwarrior@proc.org</xsl:with-param>
					<xsl:with-param name="name">shadowwarrior@proc.org</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Copyright © 2003-2010. Alle Rechte vorbehalten!</xsl:text>
			</xsl:when>
			<!-- Impressum für PROC Stories -->
			<xsl:otherwise>
				<xsl:text>. Homepage: http://www.stories.proc.org/. E-Mail: </xsl:text>
				<xsl:call-template name="imprint-name">
					<xsl:with-param name="email">stories@proc.org</xsl:with-param>
					<xsl:with-param name="name">stories@proc.org</xsl:with-param>
				</xsl:call-template>
				<xsl:text>. Copyright © 2000-2010. Alle Rechte beim Autor!</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
		Autorennamen fürs Impressum
	-->
	<xsl:template match="xtory:author|xtory:painter|xtory:illustrations|xtory:proofreader|xtory:translater" mode="imprint2">
		<xsl:call-template name="imprint-name">
			<xsl:with-param name="email"><xsl:value-of select="@xtory:email"/></xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="xtory:author" mode="imprint">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<xsl:text>. </xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">Autor</xsl:when>
					<xsl:when test="$lang='en'">Author</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last())">
					<xsl:choose>
						<xsl:when test="$lang='de'">en</xsl:when>
						<xsl:when test="$lang='en'">s</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:text>: </xsl:text>
			</xsl:when>
			<xsl:when test="position() = last()">
				<xsl:choose>
					<xsl:when test="$lang='de'"> und </xsl:when>
					<xsl:when test="$lang='en'"> and </xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="imprint2"/>
	</xsl:template>

	<xsl:template match="xtory:painter" mode="imprint">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<xsl:text>. </xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">Titelbild-Zeichner</xsl:when>
					<xsl:when test="$lang='en'">Cover Painter</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last()) and ($lang='en')">s</xsl:if>
				<xsl:text>: </xsl:text>
			</xsl:when>
			<xsl:when test="position() = last()">
				<xsl:choose>
					<xsl:when test="$lang='de'"> und </xsl:when>
					<xsl:when test="$lang='en'"> and </xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="imprint2"/>
	</xsl:template>

	<xsl:template match="xtory:illustrations" mode="imprint">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<xsl:text>. </xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">Illustrationen</xsl:when>
					<xsl:when test="$lang='en'">Illustrations</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last()) and ($lang='en')">s</xsl:if>
				<xsl:text>: </xsl:text>
			</xsl:when>
			<xsl:when test="position() = last()">
				<xsl:choose>
					<xsl:when test="$lang='de'"> und </xsl:when>
					<xsl:when test="$lang='en'"> and </xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="imprint2"/>
	</xsl:template>

	<xsl:template match="xtory:proofreader" mode="imprint">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<xsl:text>. </xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">Korrekturleser</xsl:when>
					<xsl:when test="$lang='en'">Proofreader</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last()) and ($lang='en')">s</xsl:if>
				<xsl:text>: </xsl:text>
			</xsl:when>
			<xsl:when test="position() = last()">
				<xsl:choose>
					<xsl:when test="$lang='de'"> und </xsl:when>
					<xsl:when test="$lang='en'"> and </xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="imprint2"/>
	</xsl:template>

	<xsl:template match="xtory:translator" mode="imprint">
		<xsl:choose>
			<xsl:when test="position() = 1">
				<xsl:text>. </xsl:text>
				<xsl:choose>
					<xsl:when test="$lang='de'">Übersetzer</xsl:when>
					<xsl:when test="$lang='en'">Translator</xsl:when>
				</xsl:choose>
				<xsl:if test="not(position()=last()) and ($lang='en')">s</xsl:if>
				<xsl:text>: </xsl:text>
			</xsl:when>
			<xsl:when test="position() = last()">
				<xsl:choose>
					<xsl:when test="$lang='de'"> und </xsl:when>
					<xsl:when test="$lang='en'"> and </xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>, </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="." mode="imprint2"/>
	</xsl:template>

</xsl:transform>
