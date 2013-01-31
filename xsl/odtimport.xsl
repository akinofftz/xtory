<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
	xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:str="http://exslt.org/strings"
	xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	extension-element-prefixes="date str"
	exclude-result-prefixes="xsl office style text fo str">

<xsl:strip-space elements="text:p text:span text:h p em small"/>

<xsl:output
   method="xml" version="1.0"
   indent="yes" encoding="UTF-8"
   media-type="text/xml"/>

<xsl:param name="id">TODO</xsl:param>

<!-- Index über automatische Styles -->
<xsl:key name="styles"
	match="/office:document-content/office:automatic-styles/style:style"
	use="@style:name"
/>

<xsl:template match="/">
	<xsl:if test="$id = ''">
		<xsl:message terminate="yes">keine ID angegeben!</xsl:message>
	</xsl:if>
  <xsl:apply-templates select="/office:document-content/office:body"/>
</xsl:template>

<xsl:template match="/office:document-content/office:body">
	<xtory:story xml:lang="de" xtory:id="{$id}">
		<xsl:apply-templates select="descendant::text:h[@text:outline-level='1' and position() = 1]" mode="meta"/>
		<xsl:apply-templates select="descendant::text:h[@text:outline-level='1' and position() &gt; 1]"/>
	</xtory:story>
</xsl:template>

<!-- Meta-Daten =============================================================-->

<!-- Hilfstemplate, hängt alle Strings in einem Teilbaum zusammen -->
<xsl:template match="*" mode="concat">
	<xsl:apply-templates mode="concat"/>
</xsl:template>
<xsl:template match="text()" mode="concat">
	<xsl:value-of select="."/>
</xsl:template>

<!-- Hilfstemplate, wie concat, aber mit Leerzeichen dazwischen -->
<xsl:template match="*" mode="concat_space">
	<xsl:if test="position() &gt; 1">
		<xsl:text> </xsl:text>
	</xsl:if>
	<xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="text:h" mode="meta">
	<xtory:meta>
		<xtory:title><xsl:apply-templates/></xtory:title>
		<xsl:variable name="id"><xsl:value-of select="generate-id()"/></xsl:variable>
		<xsl:apply-templates select="following::text:p[generate-id(preceding::text:h[1])=$id]" mode="meta"/>
		<!-- Datum der letzten Änderung automatisch einfügen, falls noch nicht vorhanden -->
		<xsl:if test="not(following::text:p[generate-id(preceding::text:h[1])=$id and starts-with(., 'lastmod: ')])">
			<xtory:lastmod>
				<xsl:value-of select="date:year()"/>
				<xsl:text>-</xsl:text>
				<xsl:if test="date:month-in-year() &lt; 10">0</xsl:if>
				<xsl:value-of select="date:month-in-year()"/>
				<xsl:text>-</xsl:text>
				<xsl:if test="date:day-in-month() &lt; 10">0</xsl:if>
				<xsl:value-of select="date:day-in-month()"/>
			</xtory:lastmod>
		</xsl:if>
	</xtory:meta>
</xsl:template>

<!-- Untertitel -->
<xsl:template match="text:p[position()=1 and not(contains(descendant-or-self::text(), ': '))]" mode="meta">
	<xtory:subtitle><xsl:apply-templates mode="concat"/></xtory:subtitle>
</xsl:template>

<!-- Serie -->
<xsl:template match="text:p[starts-with(descendant-or-self::text(), 'series: ')]" mode="meta">
	<xsl:variable name="tmp_series">
		<xsl:apply-templates mode="concat"/>
	</xsl:variable>
	<xsl:variable name="series" select="str:tokenize(substring-after($tmp_series, 'series: '))"/>
	<xtory:series>
		<xtory:title>
			<xsl:apply-templates select="$series[1]"/>
		</xtory:title>
		<xsl:if test="count($series) &gt; 2">
			<xtory:subtitle>
				<xsl:apply-templates select="$series[position() &gt; 1 and position() &lt; last()]" mode="concat_space"/>
			</xtory:subtitle>
		</xsl:if>
		<xtory:issue>
			<xsl:value-of select="$series[last()]"/>
		</xtory:issue>
	</xtory:series>
</xsl:template>

<!-- Autor, Zeichner oder Korrekturleser mit E-Mail-Adresse -->
<xsl:template match="text:p[starts-with(descendant-or-self::text(), 'author: ') or starts-with(descendant-or-self::text(), 'painter: ') or starts-with(descendant-or-self::text(), 'proofreader: ') or starts-with(descendant-or-self::text(), 'illustrations: ')]" mode="meta">
	<xsl:variable name="tmp_val"><xsl:apply-templates mode="concat"/></xsl:variable>
	<xsl:variable name="val" select="substring-after($tmp_val, ': ')"/>
	<xsl:element name="xtory:{substring-before(descendant-or-self::text(), ': ')}">
		<xsl:choose>
			<xsl:when test="substring-after($val, '@')">
				<xsl:variable name="name" select="str:tokenize($val)"/>
				<xsl:attribute name="xtory:email">
					<xsl:value-of select="$name[last()]"/>
				</xsl:attribute>
				<xsl:apply-templates select="$name[position() &lt; last()]" mode="concat_space"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$val"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>
</xsl:template>

<!-- Sonstige Meta-Daten -->
<xsl:template match="text:p" mode="meta">
	<xsl:variable name="text"><xsl:apply-templates mode="concat"/></xsl:variable>
	<xsl:element name="xtory:{substring-before($text, ': ')}">
		<xsl:value-of select="substring-after($text, ': ')"/>
	</xsl:element>
</xsl:template>

<!-- Prefix =================================================================-->

<xsl:template match="text:h[@text:outline-level='1' and starts-with(descendant-or-self::text(), 'prefix')]">
	<xsl:variable name="id" select="generate-id()"/>
	<xtory:prefix>
		<xsl:apply-templates select="following::text:h[@text:outline-level='2' and
				generate-id(preceding::text:h[@text:outline-level='1'][1])=$id]" mode="columns"/>
	</xtory:prefix>
</xsl:template>

<!-- Was bisher geschah -->
<xsl:template match="text:h[@text:outline-level='2' and starts-with(descendant-or-self::text(), 'preface')]" mode="columns">
	<xtory:preface>
    <xsl:apply-templates select="following::text:p[generate-id(preceding::text:h[@text:outline-level = '2'][1]) = generate-id(current())]"/>
	</xtory:preface>
</xsl:template>

<!-- Hauptpersonen -->
<xsl:template match="text:h[@text:outline-level='2' and starts-with(text(), 'characters')]" mode="columns">
  <xtory:characters>
		<xsl:for-each select="following::text:h[@text:outline-level = '3' and
					generate-id(preceding::text:h[@text:outline-level='2'][1]) = generate-id(current()) and
					(position() = 1 or name(preceding::text:*[1]) != 'text:h')]">
			<xsl:variable name="id" select="generate-id(preceding::text:p[1])"/>
			<xtory:role>
				<xtory:name><xsl:apply-templates/></xtory:name>
				<xsl:for-each select="following::text:h[generate-id(preceding::text:p[1])=$id and @text:outline-level='3']">
					<xtory:name><xsl:apply-templates/></xtory:name>
				</xsl:for-each>
				<xtory:action>
					<xsl:apply-templates select="following::text:p[1]/node()"/>
				</xtory:action>
			</xtory:role>
		</xsl:for-each>
	</xtory:characters>
</xsl:template>

<!-- Text ===================================================================-->

<xsl:template match="text:h[@text:outline-level='1' and starts-with(text(), 'text')]">
	<xtory:text xtory:first-chapter="1">
		<xsl:apply-templates mode="text"
			select="following::text:h[@text:outline-level = '2' and
				generate-id(preceding::text:h[@text:outline-level = '1'][1]) = generate-id(current())]"/>
	</xtory:text>
</xsl:template>

<!-- Kapitelinhalt -->
<xsl:template name="chapter">
	<xsl:if test="following::text:p[generate-id(preceding::text:h[1]) = generate-id(current())]">
		<xtory:section>
			<xsl:apply-templates
				select="following::text:p[generate-id(preceding::text:h[1]) = generate-id(current())]"/>
		</xtory:section>
	</xsl:if>
	<xsl:apply-templates mode="text"
		select="following::text:h[@text:outline-level='3' and generate-id(preceding::text:h[@text:outline-level='2'][1]) = generate-id(current())]"/>
</xsl:template>

<!-- Kapitel -->
<xsl:template mode="text" match="text:h[@text:outline-level='2']">
	<xtory:chapter>
		<xtory:title><xsl:apply-templates/></xtory:title>
		<xsl:call-template name="chapter"/>
	</xtory:chapter>
</xsl:template>

<!-- Prolog -->
<xsl:template mode="text" match="text:h[@text:outline-level='2' and starts-with(text(), 'prologue')]">
	<xtory:prologue>
		<xsl:call-template name="chapter"/>
	</xtory:prologue>
</xsl:template>

<!-- Epilog -->
<xsl:template mode="text" match="text:h[@text:outline-level='2' and starts-with(text(), 'epilogue')]">
	<xtory:epilogue>
		<xsl:call-template name="chapter"/>
	</xtory:epilogue>
</xsl:template>

<!-- Abschnitte -->
<xsl:template mode="text" match="text:h[@text:outline-level='3']">
	<xsl:variable name="id" select="generate-id(preceding::text:h[@text:outline-level='2'][1])"/>
	<xsl:variable name="id2" select="generate-id()"/>
	<xsl:variable name="secname">
		<xsl:choose>
			<xsl:when test="text() = 'Q' or starts-with(text(), 'Q: ')">quote</xsl:when>
			<xsl:otherwise>section</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:element name="xtory:{$secname}">
		<xsl:if test="text() != '*' and text() != 'Q'">
			<xtory:title><xsl:apply-templates/></xtory:title>
		</xsl:if>
		<xsl:apply-templates select="following::text:*[(local-name() = 'p' or (local-name()='list' and not(@text:continue-numbering))) and
				generate-id(preceding::text:h[@text:outline-level='2'][1]) = $id and
				generate-id(preceding::text:h[@text:outline-level='3'][1]) = $id2]"/>
	</xsl:element>
</xsl:template>

<!-- Appendix ===============================================================-->

<xsl:template match="text:h[@text:outline-level='1' and starts-with(text(), 'appendix')]">
	<xsl:variable name="id" select="generate-id()"/>
	<xtory:appendix>
		<xsl:apply-templates mode="columns"
			select="following::text:h[@text:outline-level='2' and
				generate-id(preceding::text:h[@text:outline-level='1'][1])=$id]"/>
	</xtory:appendix>
</xsl:template>

<!-- Vorschau -->
<xsl:template mode="columns" match="text:h[@text:outline-level='2' and starts-with(text(), 'preview')]">
  <xtory:preview>
    <xsl:apply-templates select="following::text:*[(local-name() = 'p' or (local-name() = 'h' and @text:outline-level='3')) and
				generate-id(preceding::text:h[@text:outline-level='2'][1]) = generate-id(current())]"/>
  </xtory:preview>
</xsl:template>

<!-- Kommentar -->
<xsl:template mode="columns" match="text:h[@text:outline-level='2' and starts-with(text(), 'commentary')]">
	<xtory:commentary>
		<xsl:for-each select="following-sibling::text:*[(local-name() = 'p' or local-name() = 'list' or (local-name() = 'h' and @text:outline-level='3')) and
				generate-id(preceding::text:h[@text:outline-level='2'][1]) = generate-id(current())]">
			<xsl:choose>
				<!-- Autorennamen in der letzten Zeile ausfiltern -->
				<xsl:when test="local-name() = 'p' and position() = last() and starts-with(., 'author: ')">
					<xsl:apply-templates select="." mode="meta"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
  </xtory:commentary>
</xsl:template>

<!-- Glossar -->
<xsl:template mode="columns" match="text:h[@text:outline-level='2' and starts-with(text(), 'glossary')]">
  <xtory:glossary>
    <xsl:apply-templates mode="text"
			select="following::text:h[@text:outline-level='3' and
				generate-id(preceding::text:h[@text:outline-level='2'][1]) = generate-id(current())]"/>
  </xtory:glossary>
</xsl:template>


<!-- Alles andere ignorieren -->
<xsl:template mode="columns" match="text:h[@text:outline-level='2']" priority="-1"/>

<!-- Textumwandlung =========================================================-->

<!-- Absatz -->
<xsl:template match="text:p[not(parent::text:list-item)]">
	<xsl:variable name="style" select="key('styles', @text:style-name)/child::style:text-properties[1]"/>
	<p>
		<xsl:choose>
			<xsl:when test="$style[@fo:font-style='italic']">
				<em><xsl:apply-templates/></em>
			</xsl:when>
			<xsl:when test="$style[@fo:font-weight = 'bold']">
				<strong><xsl:apply-templates/></strong>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</p>
</xsl:template>

<!-- Listen -->
<xsl:template match="text:list">
	<ul>
		<xsl:apply-templates select="text:list-item"/>
	</ul>
</xsl:template>
<xsl:template match="text:list-item">
	<li>
		<xsl:apply-templates select="text:p/*|text:p/text()"/>
	</li>
</xsl:template>

<!-- Überschriften -->
<xsl:template match="text:h" priority="-2">
	<xtory:title>
		<xsl:apply-templates/>
	</xtory:title>
</xsl:template>

<!-- Inline-Formatierung -->
<xsl:template match="text:span">
	<xsl:variable name="style" select="key('styles', @text:style-name)/child::style:text-properties[1]"/>
	<xsl:choose>
		<!-- unterstrichener Text in einem kursiven Kontext -->
		<xsl:when test="$style[@fo:font-style = 'italic' and @style:text-underline-style = 'solid']
				and key('styles', ../@text:style-name)/child::style:text-properties[@fo:font-style = 'italic']">
			<small><xsl:apply-templates/></small>
		</xsl:when>
		<xsl:when test="$style[@fo:font-style = 'italic']">
			<em><xsl:apply-templates/></em>
		</xsl:when>
		<xsl:when test="$style[@fo:font-weight = 'bold']">
			<strong><xsl:apply-templates/></strong>
		</xsl:when>
		<xsl:when test="$style[@style:text-position = 'super']">
			<sup><xsl:apply-templates/></sup>
		</xsl:when>
		<xsl:when test="$style[@style:text-underline-style = 'solid']">
			<small><xsl:apply-templates/></small>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="text:line-break">
  <br/>
</xsl:template>

<!-- Text (~ durch &thinsp; ersetzen) -->
<xsl:template match="text()">
	<xsl:value-of select="translate(., '~', '&#x2009;')"/>
</xsl:template>

</xsl:stylesheet>
