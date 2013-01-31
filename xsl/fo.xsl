<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/XSL/Format"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	exclude-result-prefixes="xtory xsl html">

<xsl:output method="xml" indent="yes"/>
<xsl:param name="lang">de</xsl:param>
<xsl:param name="url">.</xsl:param>

<xsl:include href="global.xsl"/>
<xsl:include href="cover.xsl"/>

<xsl:attribute-set name="page-size">
	<xsl:attribute name="page-width">210mm</xsl:attribute>
	<xsl:attribute name="page-height">297mm</xsl:attribute>
	<xsl:attribute name="margin-top">10mm</xsl:attribute>
	<xsl:attribute name="margin-bottom">15mm</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="/">
	<xsl:apply-templates select="xtory:story"/>
</xsl:template>

<xsl:template match="/xtory:story">
	<root>
		<xsl:choose>
			<xsl:when test="$lang='de'">
				<xsl:attribute name="language">de_DR</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="language"><xsl:value-of select="$lang"/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>

		<layout-master-set>
			<!-- Titelseite -->
			<simple-page-master master-name="cover-page" page-width="210mm" page-height="297mm">
				<region-body region-name="main" display-align="center" background-color="blue">
					<xsl:attribute name="background-color">
						<xsl:choose>
							<xsl:when test="xtory:meta/xtory:cover/@xtory:cover">
								<xsl:value-of select="xtory:meta/xtory:cover/@xtory:cover"/>
							</xsl:when>
							<xsl:otherwise>black</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</region-body>
			</simple-page-master>
			<simple-page-master master-name="cover-back" xsl:use-attribute-sets="page-size">
				<region-body region-name="main"/>
			</simple-page-master>

			<!-- Seite mit Titel, Hauptpersonen, Einleitung und Impresum (Seite 3) -->
			<simple-page-master master-name="text-title" margin-right="15mm" margin-left="25mm" xsl:use-attribute-sets="page-size">
				<region-body region-name="main"/>
				<region-before extent="110mm" region-name="title" precedence="true"/>
				<region-after extent="22mm" region-name="imprint" precedence="true"/>
				<region-start extent="102mm" region-name="preface"/>
				<region-end extent="60mm" region-name="characters"/>
			</simple-page-master>

			<!-- Romantext (Ungerade Seite) -->
			<simple-page-master master-name="text-odd" margin-right="15mm" margin-left="25mm" xsl:use-attribute-sets="page-size">
				<region-body region-name="main" margin-top="12mm" column-count="2" column-gap="10mm" />
				<region-before extent="10mm" region-name="head-odd"/>
			</simple-page-master>

			<!-- Romantext (Gerade Seite) -->
			<simple-page-master master-name="text-even" margin-right="25mm" margin-left="15mm" xsl:use-attribute-sets="page-size">
				<region-body region-name="main" margin-top="12mm" column-count="2" column-gap="10mm" />
				<region-before extent="10mm" region-name="head-even"/>
			</simple-page-master>

			<!-- Anhang mit Titel -->
			<simple-page-master master-name="appendix-title" margin-right="25mm" margin-left="25mm" page-width="210mm" page-height="297mm" margin-top="20mm" margin-bottom="15mm">
				<region-body region-name="main" margin-top="15mm" column-count="2" column-gap="10mm"/>
				<region-before extent="10mm" region-name="title"/>
			</simple-page-master>

			<!-- Anhang (nur Text) -->
			<simple-page-master master-name="appendix-text" margin-right="25mm" margin-left="25mm" page-width="210mm" page-height="297mm" margin-top="20mm" margin-bottom="15mm">
				<region-body region-name="main" column-count="2" column-gap="10mm"/>
			</simple-page-master>

			<!-- Titelbild (mit 2. leerer Seite) -->
			<page-sequence-master master-name="cover">
				<single-page-master-reference master-reference="cover-page"/>
				<single-page-master-reference master-reference="cover-back"/>
			</page-sequence-master>

			<!-- Seitenreihenfolge -->
			<page-sequence-master master-name="xtory">
				<!-- Titelseite -->
				<single-page-master-reference master-reference="text-title"/>
				<!-- restliche Seiten abwechselnd gerade/ungerade -->
				<repeatable-page-master-alternatives>
					<conditional-page-master-reference master-reference="text-even" odd-or-even="even"/>
					<conditional-page-master-reference master-reference="text-odd" odd-or-even="odd"/>
				</repeatable-page-master-alternatives>
			</page-sequence-master>

			<!-- Seiten-Master für Rubriken -->
			<page-sequence-master master-name="appendix">
				<single-page-master-reference master-reference="appendix-title"/>
				<repeatable-page-master-reference master-reference="appendix-text"/>
			</page-sequence-master>
		</layout-master-set>

		<xsl:if test="xtory:meta/xtory:cover">
			<page-sequence master-reference="cover">
				<flow flow-name="main">
					<block width="210mm" height="297mm" text-align="center" margin-top="0" margin-left="0">
						<external-graphic content-width="210mm" content-height="297mm" src="{@xtory:id}.svg" />
					</block>
					<block break-before="page">&#160;</block>
				</flow>
			</page-sequence>
		</xsl:if>

		<page-sequence master-reference="xtory">
			<!-- ungerade Seiten -->
			<xsl:call-template name="heading">
				<xsl:with-param name="page">odd</xsl:with-param>
			</xsl:call-template>

			<!-- gerade Seiten -->
			<xsl:call-template name="heading">
				<xsl:with-param name="page">even</xsl:with-param>
			</xsl:call-template>

			<static-content flow-name="imprint" hyphenate="false">
				<block font-size="8pt" font-family="sans-serif" text-align="justify"
						border-top="0.1pt solid black" padding-top="1pt">
					<xsl:call-template name="imprint"/>
				</block>
			</static-content>

			<xsl:apply-templates select="xtory:prefix/xtory:characters"/>
			
			<xsl:apply-templates select="xtory:meta"/>
			<xsl:apply-templates select="*/xtory:preface[lang($lang)]"/>

			<flow flow-name="main" font-family="serif" font-size="12pt" hyphenate="true">
				<xsl:apply-templates select="xtory:text[lang($lang)]"/>
			</flow>
		</page-sequence>
		<xsl:apply-templates select="xtory:appendix/xtory:*[local-name() != 'preview']"/>
  </root>
</xsl:template>

<xsl:template name="imprint-name">
	<xsl:param name="name"/>
	<xsl:param name="email"/>
	<xsl:value-of select="$name"/>
	<xsl:if test="$email">
		<xsl:text> (</xsl:text>
		<xsl:value-of select="$email"/>
		<xsl:text>)</xsl:text>
	</xsl:if>
</xsl:template>


<xsl:template name="heading">
	<xsl:param name="page"/>
	<static-content flow-name="head-{$page}">
		<table table-layout="fixed" width="100%" font-family="serif" font-size="12pt"
				border-bottom-color="black" border-bottom-style="solid" border-bottom-width="0.25pt">
			<table-column column-width="proportional-column-width(3)"/>
			<table-column column-width="proportional-column-width(1)"/>
			<table-column column-width="proportional-column-width(3)"/>
			<table-body>
				<table-row>
					<table-cell>
						<block text-align="start">
							<xsl:choose>
								<xsl:when test="$page = 'odd'">
									<inline text-transform="uppercase" font-style="italic">
										<xsl:choose>
											<xsl:when test="string-length(/xtory:story/xtory:meta/xtory:title[lang($lang)]) &lt; 20">
												<xsl:value-of select="/xtory:story/xtory:meta/xtory:title[lang($lang)]"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="concat(substring(/xtory:story/xtory:meta/xtory:title[lang($lang)],1,20),' …')"/>
											</xsl:otherwise>
										</xsl:choose>
									</inline>
								</xsl:when>
								<xsl:when test="$page = 'even'"><page-number/></xsl:when>
							</xsl:choose>
						</block>
					</table-cell>
					<table-cell>
						<block text-align="center">
							<xsl:choose>
								<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
									<inline font-family="pompc" font-size="14pt">DORGON</inline>
								</xsl:when>
								<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Vithau'">
									<block><external-graphic height="1em" src="http://localhost:8888/stories/tibis/vithau.eps"/></block>
								</xsl:when>
								<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Shadow Warrior'">
									<block><external-graphic height="1em" src="http://localhost:8888/stories/tibis/sw.eps"/></block>
								</xsl:when>
								<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Thydery'">
									<block><external-graphic height="1em" src="http://localhost:8888/stories/tibis/thydery.eps"/></block>
								</xsl:when>
								<xsl:otherwise>
									<block><external-graphic height="1.1em" src="http://localhost:8888/stories/tibis/stories.jpg"/></block>
								</xsl:otherwise>
							</xsl:choose>
						</block>
					</table-cell>
					<table-cell>
						<block text-align="end">
							<xsl:choose>
								<xsl:when test="$page = 'odd'"><page-number/></xsl:when>
								<xsl:when test="$page = 'even'">
									<inline text-transform="uppercase" font-style="italic">
										<xsl:for-each select="/xtory:story/xtory:meta/xtory:author">
											<xsl:if test="not(position() = 1)"> / </xsl:if>
											<xsl:value-of select="."/>
										</xsl:for-each>
									</inline>
								</xsl:when>
							</xsl:choose>
						</block>
					</table-cell>
				</table-row>
			</table-body>
		</table>
	</static-content>
</xsl:template>


<xsl:template match="xtory:meta">
	<static-content flow-name="title" text-align="center" padding-after="5pt" border-bottom="0.25pt solid lightgray">
		<block space-after="1.5em" text-align="center">
			<xsl:choose>
				<xsl:when test="xtory:series/xtory:title = 'Dorgon'">
					<xsl:attribute name="font-family">pompc</xsl:attribute>
					<block font-size="68pt">D O R G O N</block>
					<block background-color="lightgray" font-size="11pt" letter-spacing="0.5em" space-before="-0.5em">
						<xsl:text>Fan-Serie des Perry Rhodan Online Clubs</xsl:text>
					</block>
				</xsl:when>
				<xsl:when test="xtory:series/xtory:title = 'Vithau'">
					<block><external-graphic src="http://localhost:8888/stories/tibis/vithau.eps"/></block>
					<block background-color="lightgray" font-size="11pt" letter-spacing="0.25em" space-before="-0.5em" font-family="sans-serif">
						<xsl:text>Interaktive Story des Perry Rhodan Online Clubs</xsl:text>
					</block>
				</xsl:when>
				<xsl:when test="xtory:series/xtory:title = 'Thydery'">
					<block><external-graphic src="http://localhost:8888/stories/tibis/thydery.eps"/></block>
					<block background-color="lightgray" font-size="11pt" letter-spacing="0.25em" space-before="-0.5em" font-family="sans-serif">
						<xsl:text>Die Internet SF-Serie der Perry Rhodan Online Community</xsl:text>
					</block>
				</xsl:when>
				<xsl:when test="xtory:series/xtory:title = 'Shadow Warrior'">
					<block><external-graphic src="http://localhost:8888/stories/tibis/sw.eps"/></block>
					<block background-color="lightgray" font-size="11pt" letter-spacing="0.25em" space-before="-0.5em" font-family="sans-serif">
						<xsl:text>Internet-Fanstory des Perry Rhodan Online Clubs</xsl:text>
					</block>
				</xsl:when>
				<xsl:otherwise>
					<block><external-graphic src="http://localhost:8888/stories/tibis/stories.jpg"/></block>
					<block background-color="lightgray" font-size="11pt" letter-spacing="0.25em" space-before="-0.5em" font-family="sans-serif">
						<xsl:text>Fanstories aus der Perry Rhodan Online Community</xsl:text>
					</block>
				</xsl:otherwise>
			</xsl:choose>
		</block>
		<xsl:for-each select="xtory:series">
			<xsl:for-each select="xtory:subtitle[lang($lang)]">
				<block><xsl:apply-templates/></block>
			</xsl:for-each>
			<block font-weight="bold">Band <xsl:value-of select="xtory:issue"/></block>
		</xsl:for-each>
		<block space-before.optimum="0.8em" space-after.optimum="0.8em">
			<block font-size="26pt" font-weight="bold">
				<xsl:value-of select="xtory:title[lang($lang)]"/>
			</block>
			<xsl:for-each select="xtory:subtitle[lang($lang)]">
				<block font-size="10pt"><xsl:apply-templates/></block>
			</xsl:for-each>
		</block>
		<block font-size="18pt" space-after="0.5em">
			<xsl:choose>
				<xsl:when test="$lang='de'">von </xsl:when>
			</xsl:choose>
			<xsl:for-each select="xtory:author">
				<xsl:choose>
					<xsl:when test="position() = 1"/>
					<xsl:when test="position() = last()"> und </xsl:when>
					<xsl:otherwise>, </xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</block>
		<xsl:if test="xtory:painter">
			<block font-size="14pt" space-after="1em">
				<xsl:text>Titelbild von </xsl:text>
				<xsl:for-each select="xtory:painter">
					<xsl:choose>
						<xsl:when test="position() = 1"/>
						<xsl:when test="position() = last()"> und </xsl:when>
						<xsl:otherwise>, </xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="."/>
				</xsl:for-each>
			</block>
		</xsl:if>
	</static-content>
</xsl:template>


<xsl:template match="xtory:preface">
	<static-content flow-name="preface" hyphenate="true">
		<block-container font-family="sans-serif" font-style="italic" text-align="justify">
			<block text-align="center" space-after="1em" font-weight="bold" font-size="14pt">
				<xsl:choose>
					<xsl:when test="lang('de')">Was bisher geschah</xsl:when>
					<xsl:when test="lang('en')">What happend before</xsl:when>
				</xsl:choose>
			</block>
			<xsl:apply-templates select="*"/>
		</block-container>
	</static-content>
</xsl:template>

<xsl:template match="xtory:characters">
	<static-content flow-name="characters" hyphenate="true">
		<block-container font-family="sans-serif" font-size="90%">
			<block font-size="12pt" font-weight="bold" text-align="center" space-after="1em">
				<xsl:choose>
					<xsl:when test="lang('de')">Hauptpersonen</xsl:when>
					<xsl:when test="lang('en')">Main characters</xsl:when>
				</xsl:choose>
			</block>
			<xsl:apply-templates select="xtory:role"/>
		</block-container>
	</static-content>
</xsl:template>
<xsl:template match="xtory:characters/xtory:role">
	<block space-after="0.5em" start-indent="1em" text-indent="-1em" text-align="justify">
		<inline font-weight="bold">
			<xsl:apply-templates select="xtory:name"/>
		</inline>
		<xsl:text> &#x2013; </xsl:text>
		<xsl:apply-templates select="xtory:action"/>
	</block>
</xsl:template>
<xsl:template match="xtory:role/xtory:name[position() > 1]">
	<xsl:text>, </xsl:text>
	<xsl:apply-templates/>
</xsl:template>
<xsl:template match="xtory:role/xtory:name[last()]">
	<xsl:text> und </xsl:text>
	<xsl:apply-templates/>
</xsl:template>
<xsl:template match="xtory:role/xtory:name[1]">
	<xsl:apply-templates/>
</xsl:template>


<xsl:template match="xtory:preview">
	<block font-style="italic" text-indent="0" font-size="12pt" text-align="justify" span="all">
		<xsl:apply-templates select="*"/>
	</block>
</xsl:template>
<xsl:template match="xtory:preview/xtory:title">
	<block space-before.optimum="0.5em" space-after.optimum="0.5em" font-size="16pt" text-align="center" font-style="normal">
		<xsl:choose>
			<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
				<xsl:attribute name="font-family">pompc</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="font-weight">bold</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates/>
	</block>
</xsl:template>

<xsl:template match="xtory:appendix">
	<xsl:apply-templates select="xtory:commentary|xtory:lks|xtory:glossary"/>
	<!--select="xtory:*[not(local-name() = 'preview') and lang($lang)]"/>-->
</xsl:template>

<!-- ******************
     Rubriken
		 ****************** -->

<xsl:template name="column-title">
	<xsl:param name="title"/>
	<xsl:param name="subtitle"/>
	<static-content flow-name="title">
		<block space-before.optimum="1em" space-after.optimum="1em" span="all"
				text-align="center"
				break-before="page" keep-together="always" keep-with-next="always">
			<xsl:choose>
				<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
					<xsl:attribute name="font-family">pompc</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="font-weight">bold</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<block font-size="24pt">
				<!--xsl:if test="/xtory:story/xtory:meta/xtory:series/xtory:title">
					<xsl:value-of select="/xtory:story/xtory:meta/xtory:series/xtory:title"/>
					<xsl:text>-</xsl:text>
				</xsl:if-->
				<xsl:value-of select="$title"/>
			</block>
			<xsl:if test="$subtitle">
				<block space-before.optimum="0.5em" font-size="18pt">
					<xsl:value-of select="$subtitle"/>
				</block>
			</xsl:if>
		</block>
	</static-content>
</xsl:template>

<xsl:template match="xtory:commentary">
	<page-sequence master-reference="appendix" hyphenate="true">
		<xsl:call-template name="column-title">
			<xsl:with-param name="title">
				<xsl:choose>
					<xsl:when test="lang('de')">Kommentar</xsl:when>
					<xsl:when test="lang('en')">Commentary</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="subtitle">
				<xsl:value-of select="xtory:title"/>
			</xsl:with-param>
		</xsl:call-template>
		<flow flow-name="main">
			<block font-family="sans-serif" font-size="10pt" keep-with-previous="always">
				<block text-align="justify">
					<xsl:apply-templates select="*[not(local-name()='title' or local-name()='author')]"/>
				</block>
				<xsl:for-each select="xtory:author">
					<block font-weight="bold" text-align="end">
						<xsl:value-of select="."/>
					</block>
				</xsl:for-each>
			</block>
			<!-- bündig abschließen -->
			<block span="all">&#160;</block>
		</flow>
	</page-sequence>
</xsl:template>

<!--<xsl:template match="xtory:lks">
	<xsl:call-template name="column-title">
		<xsl:with-param name="title">LKS</xsl:with-param>
	</xsl:call-template>
	<block font-family="sans-serif" font-size="10pt" text-align="justify" keep-with-previous="always">
		<xsl:apply-templates/>
	</block>
</xsl:template>

<xsl:template match="xtory:lks/xtory:title">
	<block background-color="lightgray" font-weight="bold" padding="0.25em"
			space-before.optimum="1em" space-before.mininum="0.5em"
			space-after.optimum="0.5em" space-after.minimum="0.25em">
		<xsl:apply-templates/>
	</block>
</xsl:template>

<xsl:template match="xtory:lks/xtory:quote/xtory:title">
	<block font-weight="bold" text-align="center"
			space-before.optimum="0.5em" space-before.mininum="0.25em"
			space-after.optimum="0.5em" space-after.minimum="0.25em">
		<xsl:apply-templates/>
	</block>
</xsl:template>-->

<xsl:template match="xtory:glossary">
	<page-sequence master-reference="appendix" hyphenate="true">
		<xsl:call-template name="column-title">
			<xsl:with-param name="title">
				<xsl:choose>
					<xsl:when test="lang('de')">Glossar</xsl:when>
					<xsl:when test="lang('en')">Glossary</xsl:when>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<flow flow-name="main">
			<block font-family="sans-serif" font-size="10pt" keep-with-previous="always">
				<xsl:apply-templates/>
			</block>
			<!-- bündig abschließen -->
			<block span="all">&#160;</block>
		</flow>
	</page-sequence>
</xsl:template>

<xsl:template match="xtory:column">
	<page-sequence master-reference="appendix" hyphenate="true">
		<xsl:call-template name="column-title">
			<xsl:with-param name="title"><xsl:value-of select="xtory:title"/></xsl:with-param>
		</xsl:call-template>
		<flow flow-name="main">
			<block font-family="sans-serif" font-size="10pt" keep-with-previous="always">
				<xsl:apply-templates select="xtory:section"/>
			</block>
			<!-- bündig abschließen -->
			<block span="all">&#160;</block>
		</flow>
	</page-sequence>
</xsl:template>


<!--*************
      TEXT
		*************-->

<xsl:template match="xtory:text">
	<!--xsl:apply-templates select="//xtory:characters"/-->
	<block break-after="page">&#160;</block>
	<xsl:choose>
		<xsl:when test="xtory:chapter">
			<xsl:apply-templates select="xtory:prologue"/>
			<xsl:apply-templates select="xtory:chapter"/>
			<xsl:apply-templates select="xtory:epilogue"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="xtory:section|xtory:quote"/>
		</xsl:otherwise>
	</xsl:choose>
	<block span="all" space-before.optimum="0.5em" space-after.optimum="1em" text-align="center" letter-spacing="0.5em" font-size="14pt">
		<xsl:choose>
			<xsl:when test="../xtory:meta/xtory:series/xtory:title = 'Dorgon'">
				<xsl:attribute name="font-family">pompc</xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="lang('de')">ENDE</xsl:when>
			<xsl:when test="lang('en')">THE END</xsl:when>
		</xsl:choose>
	</block>
	<xsl:apply-templates select="../xtory:appendix/xtory:preview"/>
</xsl:template>

<xsl:template match="xtory:prologue">
	<xsl:call-template name="chapter">
		<xsl:with-param name="id">prologue</xsl:with-param>
		<xsl:with-param name="number">
			<xsl:choose>
				<xsl:when test="lang('de')">Prolog</xsl:when>
				<xsl:when test="lang('en') or lang('fr')">Prologue</xsl:when>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="title"><xsl:value-of select="xtory:title"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="xtory:epilogue">
	<xsl:call-template name="chapter">
		<xsl:with-param name="id">epilogue</xsl:with-param>
		<xsl:with-param name="number">
			<xsl:choose>
				<xsl:when test="lang('de')">Epilog</xsl:when>
				<xsl:when test="lang('en') or lang('fr')">Epilogue</xsl:when>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="title"><xsl:value-of select="xtory:title"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="xtory:chapter">
	<xsl:call-template name="chapter">
		<xsl:with-param name="id">
			<xsl:text>chapter</xsl:text>
			<xsl:choose>
				<xsl:when test="not(../@xtory:first-chapter)"><xsl:value-of select="position()"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="position() + ../@xtory:first-chapter - 1"/></xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="number"><xsl:if test="../@xtory:first-chapter">
				<xsl:value-of select="position() + ../@xtory:first-chapter - 1"/>
				<xsl:text>.</xsl:text>
		</xsl:if></xsl:with-param>
		<xsl:with-param name="title"><xsl:value-of select="xtory:title"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="chapter">
	<xsl:param name="id">chapter</xsl:param>
	<xsl:param name="number"/>
	<xsl:param name="title"/>
  <block space-before.optimum="1em" space-before.minimum="0.5em" space-before.maximum="4em"
			 space-after="1em" start-indent="1em" end-indent="1em"
			text-align="center" keep-together="always" keep-with-next="always" keep-with-previous="always">
		<xsl:if test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'">
			<xsl:attribute name="font-family">pompc</xsl:attribute>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="string-length($number) != 0">
				<block font-size="14pt">
					<xsl:choose>
						<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'"/>
						<xsl:otherwise>
							<xsl:attribute name="font-weight">bold</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="$number"/>
				</block>
			</xsl:when>
			<xsl:otherwise>
				<!--<xsl:attribute name="font-weight">bold</xsl:attribute>-->
				<xsl:attribute name="font-size">14pt</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$title">
    	<block>
				<xsl:choose>
					<xsl:when test="/xtory:story/xtory:meta/xtory:series/xtory:title = 'Dorgon'"/>
					<xsl:otherwise>
						<xsl:attribute name="font-style">italic</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$title"/>
			</block>
		</xsl:if>
  </block>
  <xsl:apply-templates select="xtory:section|xtory:quote"/>
</xsl:template>

<xsl:template match="xtory:section|xtory:quote">
  <block keep-with-next="always" keep-with-previous="1" text-align="justify"
			space-after.optimum="2em" space-after.minimum="1em" space-after.maximum="3em">
		<xsl:if test="local-name()='quote'">
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:attribute name="start-indent">1em</xsl:attribute>
		</xsl:if>
   	<xsl:apply-templates select="*"/>
  </block>
</xsl:template>

<xsl:template match="xtory:section/xtory:title|xtory:quote/xtory:title">
	<block space-after.optimum="1em" text-align="center" font-weight="bold" keep-together="always" keep-with-next="always">
		<xsl:apply-templates/>
	</block>
</xsl:template>

<xsl:template match="html:p">
  <block space-after.minimum="1pt" space-after.optimum="0.25em" space-after.maximum="1.25em">
		<xsl:if test="not(position()=1)">
			<xsl:attribute name="text-indent">1em</xsl:attribute>
		</xsl:if>
    <xsl:apply-templates/>
  </block>
</xsl:template>

<!-- Nötig, um wirklich das erste Zeichen zu finden -->
<xsl:template match="xtory:section/html:p[1]/text()[position()=1 and not(preceding-sibling::html:*)]|xtory:section/html:p[1]/html:*[position()=1 and not(preceding-sibling::text())]/text()">
	<inline font-size="150%" font-weight="bold" float="start"><xsl:value-of select="substring(.,1,1)"/></inline>
	<xsl:value-of select="substring(.,2)"/>
</xsl:template>

<xsl:template match="html:img">
	<block width="8cm">
		<external-graphic width="8cm" content-width="8cm" src="{$url}/{@src}"/>
	</block>
</xsl:template>

<xsl:template match="html:em/html:em|xtory:quote//html:em">
	<inline font-style="normal">
		<xsl:apply-templates/>
	</inline>
</xsl:template>

<xsl:template match="html:em">
  <inline font-style="italic">
    <xsl:apply-templates/>
  </inline>
</xsl:template>

<xsl:template match="html:strong">
	<inline font-weight="bold">
		<xsl:apply-templates/>
	</inline>
</xsl:template>

<xsl:template match="html:small">
  <inline font-size="85%">
    <xsl:apply-templates/>
  </inline>
</xsl:template>

<xsl:template match="html:sup">
  <inline text-altitude="0.5em" font-size="50%">
    <xsl:apply-templates/>
  </inline>
</xsl:template>

<xsl:template match="html:q//html:q">
	<xsl:choose>
		<xsl:when test="$lang='de'">&#x203A;<xsl:apply-templates/>&#x2039;</xsl:when>
		<xsl:when test="$lang='fr'">&#x2039;<xsl:apply-templates/>&#x203A;</xsl:when>
		<xsl:when test="$lang='en'">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:q">
	<xsl:choose>
		<xsl:when test="$lang='de'">»<xsl:apply-templates/>«</xsl:when>
		<xsl:when test="$lang='fr'">«<xsl:apply-templates/>»</xsl:when>
		<xsl:when test="$lang='en'">&#x201C;<xsl:apply-templates/>&#x201D;</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="html:br">
	<block break-after='line'/>
</xsl:template>

<xsl:template match="html:ul">
	<list-block space-after.optimum="1em">
		<xsl:apply-templates select="html:li"/>
	</list-block>
</xsl:template>

<xsl:template match="html:ul/html:li">
	<list-item>
		<list-item-label start-indent="5mm" end-indent="label-end()">
			<block>&#8226;</block>
		</list-item-label>
		<list-item-body start-indent="body-start()">
			<block><xsl:apply-templates/></block>
		</list-item-body>
	</list-item>
</xsl:template>

<xsl:template match="text()"><xsl:value-of select="."/></xsl:template>

</xsl:stylesheet>
