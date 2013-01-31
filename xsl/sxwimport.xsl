<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:func="http://stories.proc.org/functions"
	xmlns:office="http://openoffice.org/2000/office"
	xmlns:str="http://exslt.org/strings"
	xmlns:style="http://openoffice.org/2000/style"
	xmlns:text="http://openoffice.org/2000/text"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	exclude-result-prefixes="xsl office style text fo str">

<!--
<xalan:component prefix="func" functions="strpos strccount">
	<xalan:script lang="JavaScript">
		// Erstes Vorkommen eines Zeichens im String zurück geben
		function strpos(str, needle) {
			return str.indexOf(needle);
		}
		// Letztes Vorkommen eines Zeichens im String zurück geben
		function strlpos(str, needle) {
			return str.lastIndexOf(needle);
		}
	</xalan:script>
</xalan:component>
-->

<xsl:strip-space elements="text:p text:span text:h p em small"/>

<xsl:output
   method="xml" version="1.0"
   indent="yes" encoding="UTF-8"
   media-type="text/xml"/>
	 
<xsl:param name="id">**TODO**</xsl:param>

<xsl:template match="/">
  <xsl:apply-templates select="/office:document-content/office:body"/>
</xsl:template>

<xsl:template match="/office:document-content/office:body">
	<xtory:story xml:lang="de" xtory:id="{$id}">
		<xsl:apply-templates select="descendant::text:h[@text:level='1' and position() = 1]" mode="meta"/>
		<xsl:apply-templates select="descendant::text:h[@text:level='1' and position() &gt; 1]"/>
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

<xsl:template match="text:h" mode="meta">
	<xtory:meta>
		<xtory:title><xsl:apply-templates/></xtory:title>
		<xsl:variable name="id"><xsl:value-of select="generate-id()"/></xsl:variable>
		<xsl:apply-templates select="following::text:p[generate-id(preceding::text:h[1])=$id]" mode="meta"/>
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
	<xsl:variable name="series" select="str:tokenize(substring-after($tmp_series, 'series: '), ' ')"/>
	<xtory:series>
		<xtory:title>
			<xsl:value-of select="$series/token[1]"/>
		</xtory:title>
		<xsl:if test="count($series/token) &gt; 2">
			<xtory:subtitle>
				<xsl:value-of select="str:concat($series/token[position() &gt; 1 and position() &lt; last()])"/>
			</xtory:subtitle>
		</xsl:if>
		<xtory:issue>
			<xsl:value-of select="$series/token[position() = last()]"/>
		</xtory:issue>
	</xtory:series>
</xsl:template>

<!-- Autor, Zeichner oder Korrekturleser mit E-Mail-Adresse -->
<xsl:template match="text:p[starts-with(descendant-or-self::text(), 'author: ') or starts-with(descendant-or-self::text(), 'painter: ') or starts-with(descendant-or-self::text(), 'proofreader: ') or starts-with(descendant-or-self::text(), 'illustrations: ')]" mode="meta">
	<xsl:variable name="tmp_text"><xsl:apply-templates mode="concat"/></xsl:variable>
	<xsl:variable name="text" select="substring-after($tmp_text, ': ')"/>
	<xsl:element name="xtory:{substring-before(descendant-or-self::text(), ': ')}">
		<xsl:choose>
			<xsl:when test="substring-after($text, '@')">
				<xsl:variable name="name" select="str:tokenize($text, ' ')"/>
				<xsl:attribute name="xtory:email">
					<xsl:value-of select="$name/token[last()]"/>
				</xsl:attribute>
				<xsl:for-each select="$name/token[position() != last()]">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
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

<xsl:template match="text:h[@text:level='1' and starts-with(descendant-or-self::text(), 'prefix')]">
	<xsl:variable name="id" select="generate-id()"/>
	<xtory:prefix>
		<xsl:apply-templates select="following::text:h[@text:level='2' and
				generate-id(preceding::text:h[@text:level='1'][1])=$id]" mode="columns"/>
	</xtory:prefix>
</xsl:template>

<!-- Was bisher geschah -->
<xsl:template match="text:h[@text:level='2' and starts-with(descendant-or-self::text(), 'preface')]" mode="columns">
	<xtory:preface>
    <xsl:apply-templates select="following::text:p[generate-id(preceding::text:h[@text:level = '2'][1]) = generate-id(current())]"/>
	</xtory:preface>
</xsl:template>

<!-- Hauptpersonen -->
<xsl:template match="text:h[@text:level='2' and starts-with(text(), 'characters')]" mode="columns">
  <xtory:characters>
		<xsl:for-each select="following::text:h[@text:level = '3' and
					generate-id(preceding::text:h[@text:level='2'][1]) = generate-id(current()) and
					(position() = 1 or name(preceding::text:*[1]) != 'text:h')]">
			<xsl:variable name="id" select="generate-id(preceding::text:p[1])"/>
			<xtory:role>
				<xtory:name><xsl:apply-templates/></xtory:name>
				<xsl:for-each select="following::text:h[generate-id(preceding::text:p[1])=$id and @text:level='3']">
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

<xsl:template match="text:h[@text:level='1' and starts-with(text(), 'text')]">
	<xtory:text xtory:first-chapter="1">
		<xsl:apply-templates mode="text"
			select="following::text:h[@text:level = '2' and
				generate-id(preceding::text:h[@text:level = '1'][1]) = generate-id(current())]"/>
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
		select="following::text:h[@text:level='3' and generate-id(preceding::text:h[@text:level='2'][1]) = generate-id(current())]"/>
</xsl:template>

<!-- Kapitel -->
<xsl:template mode="text" match="text:h[@text:level='2']">
	<xtory:chapter>
		<xtory:title><xsl:apply-templates/></xtory:title>
		<xsl:call-template name="chapter"/>
	</xtory:chapter>
</xsl:template>

<!-- Prolog -->
<xsl:template mode="text" match="text:h[@text:level='2' and starts-with(text(), 'prologue')]">
	<xtory:prologue>
		<xsl:call-template name="chapter"/>
	</xtory:prologue>
</xsl:template>

<!-- Epilog -->
<xsl:template mode="text" match="text:h[@text:level='2' and starts-with(text(), 'epilogue')]">
	<xtory:epilogue>
		<xsl:call-template name="chapter"/>
	</xtory:epilogue>
</xsl:template>

<!-- Abschnitte -->
<xsl:template mode="text" match="text:h[@text:level='3']">
	<xsl:variable name="id" select="generate-id(preceding::text:h[@text:level='2'][1])"/>
	<xsl:variable name="id2" select="generate-id()"/>
	<xtory:section>
		<xsl:if test="text() != '*'">
			<xtory:title><xsl:apply-templates/></xtory:title>
		</xsl:if>
		<xsl:apply-templates select="following::text:*[(local-name() = 'p' or local-name()='unordered-list') and
				generate-id(preceding::text:h[@text:level='2'][1]) = $id and
				generate-id(preceding::text:h[@text:level='3'][1]) = $id2]"/>
	</xtory:section>
</xsl:template>

<!-- Appendix ===============================================================-->

<xsl:template match="text:h[@text:level='1' and starts-with(text(), 'appendix')]">
	<xsl:variable name="id" select="generate-id()"/>
	<xtory:appendix>
		<xsl:apply-templates mode="columns"
			select="following::text:h[@text:level='2' and
				generate-id(preceding::text:h[@text:level='1'][1])=$id]"/>
	</xtory:appendix>
</xsl:template>

<!-- Vorschau -->
<xsl:template mode="columns" match="text:h[@text:level='2' and starts-with(text(), 'preview')]">
  <xtory:preview>
    <xsl:apply-templates select="following::text:*[(local-name() = 'p' or (local-name() = 'h' and @text:level='3')) and
				generate-id(preceding::text:h[@text:level='2'][1]) = generate-id(current())]"/>
  </xtory:preview>
</xsl:template>

<!-- Kommentar -->
<xsl:template mode="columns" match="text:h[@text:level='2' and starts-with(text(), 'commentary')]">
  <xtory:commentary>
    <xsl:apply-templates select="following::text:*[(local-name() = 'p' or local-name() = 'unordered-list' or (local-name() = 'h' and @text:level='3')) and
				generate-id(preceding::text:h[@text:level='2'][1]) = generate-id(current())]"/>
  </xtory:commentary>
</xsl:template>

<!-- Glossar -->
<xsl:template mode="columns" match="text:h[@text:level='2' and starts-with(text(), 'glossary')]">
  <xtory:glossary>
    <xsl:apply-templates mode="text"
			select="following::text:h[@text:level='3' and
				generate-id(preceding::text:h[@text:level='2'][1]) = generate-id(current())]"/>
  </xtory:glossary>
</xsl:template>


<!-- Alles andere ignorieren -->
<xsl:template mode="columns" match="text:h[@text:level='2']" priority="-1"/>

<!-- Textumwandlung =========================================================-->

<!-- Absatz -->
<xsl:template match="text:p[not(parent::text:list-item)]">
	<xsl:variable name="stylename"><xsl:value-of select="@text:style-name"/></xsl:variable>
	<p>
		<xsl:choose>
			<xsl:when test="//style:style[@style:name=$stylename]/style:properties/@fo:font-style='italic'">
				<em><xsl:apply-templates/></em>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</p>
</xsl:template>

<!-- Listen -->
<xsl:template match="text:unordered-list">
	<ul>
		<xsl:apply-templates select="text:list-item"/>
	</ul>
</xsl:template>
<xsl:template match="text:list-item">
	<li><xsl:apply-templates select="text:p/*|text:p/text()"/></li>
</xsl:template>

<!-- Überschriften -->
<xsl:template match="text:h" priority="-2">
	<xtory:title>
		<xsl:apply-templates/>
	</xtory:title>
</xsl:template>

<!-- Inline-Formatierung -->
<xsl:template match="text:span">
	<xsl:variable name="stylename"><xsl:value-of select="@text:style-name"/></xsl:variable>
	<xsl:choose>
		<xsl:when test="//style:style[@style:name=$stylename]/style:properties/@fo:font-style='italic'">
			<em><xsl:apply-templates/></em>
		</xsl:when>
		<xsl:when test="//style:style[@style:name=$stylename]/style:properties/@fo:font-weight='bold'">
			<strong><xsl:apply-templates/></strong>
		</xsl:when>
		<xsl:when test="starts-with(//style:style[@style:name=$stylename]/style:properties/@style:text-position, 'super')">
			<sup><xsl:apply-templates/></sup>
		</xsl:when>
		<xsl:when test="//style:style[@style:name=$stylename]/style:properties/@style:text-underline='single'">
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

</xsl:stylesheet>
