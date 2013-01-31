<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 3.0
  eReader/PML-Ausgabe

  (c) 2000-2005 Aki Alexandra Nofftz
-->
<stylesheet	version="1.0"
	xmlns="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory/3.0">

<import href="global.xsl"/>
<param name="lang">de</param>
<output method="text" encoding="UTF-8"/>

<template match="/xtory:story">
<text>\c</text>
<choose>
  <when test="xtory:meta/xtory:series/xtory:title = 'Dorgon'">D O R G O N</when>
  <when test="xtory:meta/xtory:series/xtory:title = 'Vithau'">V I T H A U</when>
  <when test="xtory:meta/xtory:series/xtory:title = 'Shadow Warrior'">SHADOW WARRIOR</when>
  <otherwise>PROC STORIES</otherwise>
</choose>
<text>
</text>
<choose>
  <when test="$lang='de'">DIE FAN-SERIE DES</when>
  <when test="$lang='en'">THE FAN SERIES OF THE</when>
  <when test="$lang='fr'">LE CYCLE FANIQUE DU</when>
<!--
  <when test="/xtory:Vithau/@xml:lang='de'">DIE INTERAKTIVE STORY DES</when>
  <when test="/xtory:ShadowWarrior/@xml:lang='de'">DIE INTERNET SF-SERIE DES</when>
  <when test="/xtory:Story/@xml:lang='de'">FAN-STORIES AUS DEM</when>
  <when test="/xtory:Story/@xml:lang='en'">FAN STORIES FROM THE</when>
-->
</choose>
<text> PERRY RHODAN ONLINE CLUB

</text>
<if test="xtory:meta/xtory:series">
	<choose>
		<when test="$lang='de'">Heft </when>
		<when test="$lang='en'">Episode </when>
		<when test="$lang='fr'">Volume </when>
	</choose>
	<value-of select="xtory:meta/xtory:series/xtory:issue"/>
</if>
<!--
  <otherwise>
    <text>Erschienen: </text>
    <value-of select="$Erschienen"/>
  </otherwise>
</choose>
-->
<text>
</text>
<apply-templates select="xtory:meta/xtory:title[lang($lang)]" />
<text>
</text>
<apply-templates select="xtory:meta/xtory:subtitle[lang($lang)]" />
<text>

</text>
<choose>
  <when test="$lang='de'">von </when>
  <when test="$lang='en'">by </when>
</choose>
<apply-templates select="xtory:meta/xtory:author"/>
<text>

</text>
<!--
<for-each select="/*/xtory:Global/xtory:Übersetzung/xtory:Name">
  <choose>
    <when test="/*/@xml:lang='en'">English translation by </when>
  </choose>
  <value-of select="."/>
  <text>

</text>
</for-each>
-->
<text>
\c
\w="100%"
</text>
<apply-templates select="xtory:prefix/xtory:preface"/>
<apply-templates select="xtory:prefix/xtory:characters"/>
<apply-templates select="xtory:text"/>
<text>\c</text>
<choose>
  <when test="$lang='de'">E N D E</when>
  <when test="$lang='en'">T H E   E N D</when>
  <when test="$lang='fr'">F I N</when>
</choose>
<text>
\c

</text>

<apply-templates select="xtory:appendix/xtory:preview/*"/>
<apply-templates select="xtory:appendix/xtory:*[not(local-name() = 'preview')]"/>
\w="100%"
<call-template name="imprint"/>

</template>

<template name="imprint-name">
	<param name="name"/>
	<param name="email"/>
	<choose>
		<when test="$email"><value-of select="$name"/> (<value-of select="$email"/>)</when>
		<otherwise><value-of select="$name"/></otherwise>
	</choose>
</template>

<template match="xtory:preface">
  <choose>
    <when test="lang('de')">

\xWas bisher geschah\x

</when>
    <when test="lang('en')">

\xPreface\x

</when>
  </choose>
  <apply-templates select="html:p"/>
</template>

<template match="xtory:characters">
  <choose>
    <when test="lang('de')">

\xHauptpersonen des Romans\x

</when>
    <when test="lang('en')">

\xMain characters\x

</when>
  </choose>
  <for-each select="xtory:role">
    <for-each select="xtory:name">
      <choose>
        <when test="not(position()=1) and (position()=last())">
          <choose>
            <when test="lang('de')"> und </when>
            <when test="lang('en')"> and </when>
          </choose>
        </when>
        <when test="not(position()=1)">, </when>
      </choose>
      <apply-templates select="."/>
    </for-each>
    <text>
</text>
    <apply-templates select="xtory:action"/>
    <text>

</text>
  </for-each>
</template>

<template match="xtory:commentary">

<apply-templates select="xtory:title"/>
	<text>

</text>
  <choose>
    <when test="lang('de')">
\xKommentar</when>
    <when test="lang('en')">
\xCommentary</when>
  </choose>
	
	<if test="xtory:title">
		<text>: </text>
		<value-of select="xtory:title"/>
	</if>
	
	<text>\x

</text>

	<apply-templates select="descendant::html:p"/>
</template>

<template match="xtory:preview/xtory:title">
  <value-of select="."/>
  <text>

</text>
</template>

<template match="xtory:glossary">
  <text>

\x</text>
  <choose>
    <when test="lang('de')">Glossar</when>
    <when test="lang('en')">Glossary</when>
  </choose>
  <if test="xtory:title">
    <text>: </text>
    <value-of select="xtory:title"/>
  </if>
  <text>\x

</text>
  <for-each select="xtory:section">
    <text>\X2</text>
		<value-of select="xtory:title"/>
    <text>\X2

</text>
    <apply-templates select="html:p"/>
    <text>

</text>
  </for-each>
</template>

<template match="xtory:lks">
	<text>

\xLKS\x

</text>
	<apply-templates/>
</template>


<!-- Romantext -->
<template match="xtory:text">
	<choose>
		<when test="xtory:chapter">
			<apply-templates select="xtory:prologue"/>
			<apply-templates select="xtory:chapter"/>
			<apply-templates select="xtory:epilogie"/>
		</when>
		<otherwise>
			<text>

\x\x
</text>
			<apply-templates select="xtory:section|xtory:quote"/>
		</otherwise>
	</choose>
</template>

<template match="xtory:prologue">
	<call-template name="chapter">
		<with-param name="id">prologue</with-param>
		<with-param name="number">
			<choose>
				<when test="lang('de')">Prolog</when>
				<when test="lang('en') or lang('fr')">Prologue</when>
			</choose>
		</with-param>
		<with-param name="title"><value-of select="xtory:title"/></with-param>
	</call-template>
</template>

<template match="xtory:epilogue">
	<call-template name="chapter">
		<with-param name="id">epilogue</with-param>
		<with-param name="number">
			<choose>
				<when test="lang('de')">Epilog</when>
				<when test="lang('en') or lang('fr')">Epilogue</when>
			</choose>
		</with-param>
		<with-param name="title"><value-of select="xtory:title"/></with-param>
	</call-template>
</template>

<template match="xtory:chapter">
	<call-template name="chapter">
		<with-param name="id">
			<text>chapter</text>
			<choose>
				<when test="not(../@xtory:first-chapter)"><value-of select="position()"/></when>
				<otherwise><value-of select="position() + ../@xtory:first-chapter - 1"/></otherwise>
			</choose>
		</with-param>
		<with-param name="number">
			<if test="../@xtory:first-chapter">
				<choose>
					<when test="lang('de')">Kapitel</when>
					<when test="lang('en') or lang('fr')">Chapter</when>
				</choose>
				<text> </text>
				<value-of select="position() + ../@xtory:first-chapter - 1"/>
			</if>
		</with-param>
		<with-param name="title"><value-of select="xtory:title"/></with-param>
	</call-template>
</template>

<template name="chapter">
	<param name="id"/>
	<param name="number"/>
	<param name="title"/>
  <text>
\x</text>
	<if test="$number">
		<choose>
			<when test="not($title)"><value-of select="$number"/></when>
			<otherwise><value-of select="$number"/><text>
    </text></otherwise>
		</choose>
	</if>
	<value-of select="$title"/>
	<text>\x

</text>
	<apply-templates select="xtory:section|xtory:quote"/>
</template>

<template match="xtory:section|xtory:quote">
	<if test="xtory:title">
		<text>
\X2</text>
		<apply-templates select="xtory:title"/>
		<text>\X2

</text>
	</if>

<apply-templates select="html:p"/>

<if test="position()!=last()">\c* * *
\c
</if>
</template>

<template match="html:p">
<apply-templates/>
<text>

</text>
</template>

<template match="html:ul|html:ol"><text>

</text>
<apply-templates select="html:li"/>
<text>

</text>
</template>

<template match="html:ul/html:li">
<text>
 - </text>
<apply-templates/>
</template>

<template match="html:ol/html:li">
<text>
 </text>
<number format="1. "/>
<apply-templates/>
</template>

<template match="text()"><value-of select='translate(.,"&#x2013;&#x2026;&#x2019;","-_&apos;")'/></template>
<template match="html:em">\i<apply-templates/>\i</template>
<template match="html:q//html:q">&apos;<apply-templates/>&apos;</template>
<template match="html:q">»<apply-templates/>«</template>
<template match="html:small">\k<apply-templates/>\k</template>
<template match="html:br"><text>
</text></template>
<template match="html:sup">\Sp<apply-templates/>\Sp</template>
<template match="html:strong">\b<apply-templates/>\b</template>

</stylesheet>
