<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xtory xsl html">

<xsl:template match="xtory:meta">
	<xsl:apply-templates select="child::xtory:title[lang($lang)]"/>
	<xsl:apply-templates select="xtory:subtitle[lang($lang)]"/>
	<xsl:apply-templates select="xtory:author"/>
</xsl:template>

<xsl:template name="chapterlist">
	<dl id="navigation">
		<dt>
			<xsl:choose>
				<xsl:when test="$lang='de'">Rubriken</xsl:when>
				<xsl:when test="$lang='en'">Columns</xsl:when>
				<xsl:when test="$lang='en'">Rubriques</xsl:when>
			</xsl:choose>
		</dt>
		<xsl:for-each select="//xtory:preface[lang($lang)]">
			<dd><a href="#preface" class="rubrik">
				<xsl:choose>
					<xsl:when test="$lang='de'">Einleitung</xsl:when>
					<xsl:when test="$lang='en'">Preface</xsl:when>
				</xsl:choose>
			</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:characters[lang($lang)]">
			<dd><a href="#characters" class="rubrik">
				<xsl:choose>
					<xsl:when test="$lang='de'">Hauptpersonen</xsl:when>
					<xsl:when test="$lang='en'">Leading Characters</xsl:when>
				</xsl:choose>
			</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:commentary[lang($lang)]">
			<dd><a href="#commentary" class="rubrik">
				<xsl:choose>
					<xsl:when test="$lang='de'">Kommentar</xsl:when>
					<xsl:when test="$lang='en'">Commentary</xsl:when>
				</xsl:choose>
			</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:lks[lang($lang)]">
			<dd><a href="#lks" class="rubrik">LKS</a></dd>
		</xsl:for-each>
		<xsl:for-each select="//xtory:glossary[lang($lang)]">
			<dd><a href="#glossary" class="rubrik">
				<xsl:choose>
					<xsl:when test="$lang='de'">Glossar</xsl:when>
					<xsl:when test="$lang='en'">Glossary</xsl:when>
				</xsl:choose>
			</a></dd>
		</xsl:for-each>
		<dd><a href="#imprint" class="rubrik">
			<xsl:choose>
				<xsl:when test="$lang='de'">Impressum</xsl:when>
				<xsl:when test="$lang='en'">Imprint</xsl:when>
			</xsl:choose>
		</a></dd>

		<xsl:choose>
			<xsl:when test="/xtory:story/xtory:text/xtory:chapter">
				<dt>
					<xsl:choose>
						<xsl:when test="$lang='de'">Kapitelübersicht</xsl:when>
						<xsl:when test="$lang='en'">Chapter Overview</xsl:when>
					</xsl:choose>
				</dt>
				<xsl:apply-templates mode="chapterlist" select="/xtory:story/xtory:text[lang($lang)]/xtory:prologue"/>
				<xsl:apply-templates mode="chapterlist" select="/xtory:story/xtory:text[lang($lang)]/xtory:chapter"/>
				<xsl:apply-templates mode="chapterlist" select="/xtory:story/xtory:text[lang($lang)]/xtory:epilogue"/>
			</xsl:when>
			<xsl:otherwise>
				<dt>Romantext</dt>
				<dd><a href="#roman">Textanfang</a></dd>
			</xsl:otherwise>
		</xsl:choose>

		<dt>
			<xsl:choose>
				<xsl:when test="$lang='de'">Einstellungen</xsl:when>
				<xsl:when test="$lang='en'">Settings</xsl:when>
			</xsl:choose>
		</dt>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='150%';">
			<xsl:choose>
				<xsl:when test="$lang='de'">Große Schrift</xsl:when>
				<xsl:when test="$lang='en'">Large Font</xsl:when>
			</xsl:choose>
		</a></dd>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='100%';">
			<xsl:choose>
				<xsl:when test="$lang='de'">Normale Schrift</xsl:when>
				<xsl:when test="$lang='en'">Standard Font</xsl:when>
			</xsl:choose>
		</a></dd>
		<dd><a href="#" onclick="document.getElementById('text').style.fontSize='75%';">
			<xsl:choose>
				<xsl:when test="$lang='de'">Kleine Schrift</xsl:when>
				<xsl:when test="$lang='en'">Small Font</xsl:when>
			</xsl:choose>
		</a></dd>
	</dl>
</xsl:template>
<xsl:template match="xtory:chapter" mode="chapterlist">
	<dd>
		<a>
			<xsl:attribute name="href">
				<xsl:text>#chapter</xsl:text>
				<xsl:choose>
					<xsl:when test="not(../@xtory:first-chapter)"><xsl:value-of select="position()"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="position() + ../@xtory:first-chapter - 1"/></xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="../@xtory:first-chapter">
				<xsl:value-of select="position() + ../@xtory:first-chapter - 1"/>
				<xsl:text>. </xsl:text>
			</xsl:if>
			<xsl:if test="xtory:title">
				<xsl:value-of select="xtory:title"/>
			</xsl:if>
		</a>
	</dd>
</xsl:template>


<xsl:template match="xtory:title">
	<title><xsl:call-template name="title"/></title>
</xsl:template>

<xsl:template match="xtory:title" mode="text">
	<h1><xsl:value-of select="."/></h1>
</xsl:template>

<xsl:template match="xtory:subtitle">
	<meta name="DC.Subject" content="{.}"/>
</xsl:template>

<xsl:template match="xtory:subtitle" mode="text">
	<p><em><xsl:value-of select="."/></em></p>
</xsl:template>

<xsl:template match="xtory:author[@email]|xtory:painter[@email]|xtory:proofreader[@email]">
	<meta name="{local-name()}" content="{.} ({@email})"/>
</xsl:template>

<xsl:template match="xtory:author|xtory:painter|xtory:proofreader">
	<meta name="{local-name()}" content="{.}"/>
</xsl:template>

<!-- Fürs Impressum -->
<xsl:template name="imprint-name">
	<xsl:param name="name"/>
	<xsl:param name="email"/>
	<xsl:choose>
		<xsl:when test="$email"><a href="mailto:{$email}"><xsl:value-of select="$name"/></a></xsl:when>
		<xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>



<!--
  Rubriken
-->

<!-- Einleitung -->
<xsl:template match="xtory:preface">
	<div id="preface" class="column">
		<h3>
			<xsl:choose>
				<xsl:when test="lang('de')">Was bisher geschah</xsl:when>
				<xsl:when test="lang('en')">Preface</xsl:when>
			</xsl:choose>
		</h3>
		<xsl:apply-templates select="*"/>
	</div>
</xsl:template>


<!-- Hauptpersonen -->
<xsl:template match="xtory:characters">
	<div id="characters" class="column">
		<h3>
			<xsl:choose>
				<xsl:when test="lang('de')">Hauptpersonen</xsl:when>
				<xsl:when test="lang('en')">Main characters</xsl:when>
			</xsl:choose>
		</h3>
		<dl>
			<xsl:apply-templates select="xtory:role"/>
		</dl>
	</div>
</xsl:template>
<xsl:template match="xtory:role">
	<dt><xsl:apply-templates select="xtory:name"/>: </dt>
	<dd><xsl:apply-templates select="xtory:action"/></dd>
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

<!-- Vorschau -->
<xsl:template match="xtory:preview">
	<div id="preview">
		<xsl:apply-templates/>
	</div>
</xsl:template>
<xsl:template match="xtory:preview/xtory:title">
	<p id="next"><xsl:apply-templates/></p>
</xsl:template>

<!-- Kommentar -->
<xsl:template match="xtory:commentary">
	<div id="commentary" class="column">
		<h3>
			<xsl:choose>
				<xsl:when test="lang('de')">Kommentar</xsl:when>
				<xsl:when test="lang('en')">Commentary</xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="xtory:title"/>
		</h3>
		<xsl:apply-templates select="*[not(name()='xtory:title')]"/>
	</div>
</xsl:template>
<xsl:template match="xtory:commentary/xtory:title">
	<br/>
	<small><xsl:value-of select="."/></small>
</xsl:template>
<xsl:template match="xtory:commentary/xtory:author">
  <p style="text-align:right"><strong><xsl:value-of select="."/></strong></p>
</xsl:template>

<!-- LKS -->
<xsl:template match="xtory:lks">
	<div id="lks" class="column">
		<h3>LKS</h3>
		<xsl:apply-templates select="*"/>
	</div>
</xsl:template>
<xsl:template match="xtory:lks/xtory:title">
	<h4><xsl:apply-templates/></h4>
</xsl:template>
<xsl:template match="xtory:lks/xtory:quote/xtory:title" priority="3">
	<h5><xsl:apply-templates/></h5>
</xsl:template>

<!-- Glossar -->
<xsl:template match="xtory:glossary">
	<div id="glossary" class="column">
		<h3>
			<xsl:choose>
				<xsl:when test="lang('de')">Glossar</xsl:when>
				<xsl:when test="lang('en')">Glossary</xsl:when>
			</xsl:choose>
		</h3>
		<xsl:apply-templates select="*"/>
	</div>
</xsl:template>

<!-- sonstige Rubrik -->
<xsl:template match="xtory:column">
	<div id="column{position()}" class="column">
		<h3><xsl:apply-templates select="xtory:title/node()"/></h3>
		<xsl:apply-templates select="xtory:section"/>
	</div>
</xsl:template>



<!--
  Romantext
-->

<xsl:template match="xtory:text">
	<div id="roman">
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
		<p id="theend">
			<xsl:choose>
				<xsl:when test="lang('de')">Ende</xsl:when>
				<xsl:when test="lang('en')">The End</xsl:when>
				<xsl:when test="lang('fr')">Fin</xsl:when>
			</xsl:choose>
		</p>
	</div>
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

<xsl:template match="xtory:prologue" mode="chapterlist">
	<dd>
		<a href="#prologue">
			<xsl:choose>
				<xsl:when test="lang('de')">Prolog</xsl:when>
				<xsl:when test="lang('en') or lang('fr')">Prologue</xsl:when>
			</xsl:choose>
			<xsl:if test="xtory:title">
				<xsl:text>. </xsl:text>
				<xsl:value-of select="xtory:title"/>
			</xsl:if>
		</a>
	</dd>
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

<xsl:template match="xtory:epilogue" mode="chapterlist">
	<dd>
		<a href="#epilogue">
			<xsl:choose>
				<xsl:when test="lang('de')">Epilog</xsl:when>
				<xsl:when test="lang('en') or lang('fr')">Epilogue</xsl:when>
			</xsl:choose>
			<xsl:if test="xtory:title">
				<xsl:text>. </xsl:text>
				<xsl:value-of select="xtory:title"/>
			</xsl:if>
		</a>
	</dd>
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
		<xsl:with-param name="number">
			<xsl:if test="../@xtory:first-chapter">
				<xsl:choose>
					<xsl:when test="lang('de')">Kapitel</xsl:when>
					<xsl:when test="lang('en') or lang('fr')">Chapter</xsl:when>
				</xsl:choose>
				<xsl:text> </xsl:text>
				<xsl:value-of select="position() + ../@xtory:first-chapter - 1"/>
			</xsl:if>
		</xsl:with-param>
		<xsl:with-param name="title"><xsl:value-of select="xtory:title"/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="chapter">
	<xsl:param name="id">chapter</xsl:param>
	<xsl:param name="number"/>
	<xsl:param name="title"/>
	<div>
		<h2 id="{$id}">
			<xsl:if test="not(string-length($number) = 0)">
				<xsl:choose>
					<xsl:when test="not($title)"><xsl:value-of select="$number"/></xsl:when>
					<xsl:otherwise><small><xsl:value-of select="$number"/></small><br/></xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:value-of select="$title"/>
		</h2>
		<xsl:apply-templates select="xtory:section|xtory:quote"/>
	</div>
</xsl:template>





<xsl:template match="xtory:section">
	<div>
		<xsl:apply-templates select="*"/>
	</div>
</xsl:template>

<xsl:template match="xtory:quote">
	<blockquote>
		<xsl:apply-templates select="*"/>
	</blockquote>
</xsl:template>

<xsl:template match="xtory:section/xtory:title|xtory:quote/xtory:title">
	<h4><xsl:apply-templates/></h4>
</xsl:template>

<!-- Nötig, um wirklich das erste Zeichen zu finden -->
<xsl:template match="xtory:section/html:p[1]/text()[position()=1 and not(preceding-sibling::html:*)]|xtory:section/html:p[1]/html:*[position()=1 and not(preceding-sibling::text())]/text()">
	<big><xsl:value-of select="substring(.,1,1)"/></big>
	<xsl:value-of select="substring(.,2)"/>
</xsl:template>


<!-- Rest kopieren und zu HTML machen ;-) -->
<!--
<xsl:template match="xtory:*[not(@xml:lang=$lang)]|*[not(@xml:lang=$lang)]//text()" priority="-1"/>
<xsl:template match="xtory:*[not(@xml:lang=$lang)]|*[not(@xml:lang=$lang)]//text()" priority="-1" mode="text"/>
-->
<xsl:template match="html:*" priority="-2">
	<xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
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
