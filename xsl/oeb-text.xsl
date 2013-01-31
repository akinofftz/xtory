<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 2.0
  OeB Ausgabe

  (c) 2000-2002 Aki Alexandra Nofftz
-->
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xtory="http://stories.proc.org/xtory"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://icl.com/saxon"
    xmlns:xalan="http://xml.apache.org/xslt"
    extension-element-prefixes="saxon xalan"
    exclude-result-prefixes="xtory html">

  <xsl:import href="oeb.xsl"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="ebookhead">
        <xsl:with-param name="titel"><xsl:call-template name="Titel"/></xsl:with-param>
      </xsl:call-template>
      <body>
        <div id="titel" style="text-indent:0">
          <h2 align="center">
            <xsl:choose>
              <xsl:when test="/xtory:Dorgon">D O R G O N</xsl:when>
              <xsl:when test="/xtory:Vithau">V I T H A U</xsl:when>
			  <xsl:when test="/xtory:Thydery">T H Y D E R Y</xsl:when>
              <xsl:when test="/xtory:ShadowWarrior">SHADOW WARRIOR</xsl:when>
              <xsl:when test="/xtory:Story">PROC STORIES</xsl:when>
            </xsl:choose>
          </h2>
          <p align="center" style="text-indent:0;text-align:center">
            <small>
              <xsl:choose>
                <xsl:when test="/xtory:Dorgon/@xml:lang='de'">DIE FAN-SERIE DES</xsl:when>
                <xsl:when test="/xtory:Dorgon/@xml:lang='en'">THE FAN SERIES OF THE</xsl:when>
                <xsl:when test="/xtory:Dorgon/@xml:lang='fr'">LE CYCLE FANIQUE DU</xsl:when>
                <xsl:when test="/xtory:Vithau/@xml:lang='de'">DIE INTERAKTIVE STORY DES</xsl:when>
				<xsl:when test="/xtory:Thydery/@xml:lang='de'">DIE INTERNET SF-SERIE DES</xsl:when>
                <xsl:when test="/xtory:ShadowWarrior/@xml:lang='de'">DIE INTERNET SF-SERIE DES</xsl:when>
                <xsl:when test="/xtory:Story/@xml:lang='de'">FAN-STORIES AUS DEM</xsl:when>
                <xsl:when test="/xtory:Story/@xml:lang='en'">FAN STORIES FROM THE</xsl:when>
              </xsl:choose>
            </small>
            <br />
            <xsl:text>PERRY RHODAN ONLINE CLUB</xsl:text>
          </p>
          <br />
          <hr align="center" width="50%" size="1" />
          <br />
          <p align="center" style="text-align:center">
            <small>
              <xsl:choose>
                <xsl:when test="/xtory:Dorgon|/xtory:Vithau|/xtory:Thydery|/xtory:ShadowWarrior">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">H E F T</xsl:when>
                    <xsl:when test="/*/@xml:lang='en'">E P I S O D E</xsl:when>
                  </xsl:choose>
                  <xsl:text> &#160; </xsl:text>
                  <xsl:value-of select="/*/@xtory:heft"/>
                </xsl:when>
                <xsl:when test="/xtory:Story">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Erschienen am: </xsl:when>
                  </xsl:choose>
                  <xsl:value-of select="$Erschienen"/>
                </xsl:when>
              </xsl:choose>
            </small>
          </p>
          <h1 align="center"><xsl:value-of select="/*/xtory:Global/xtory:Titel"/></h1>
          <p align="center" style="text-align:center"><em><xsl:value-of select="/*/xtory:Global/xtory:Untertitel"/></em></p>
          <br />
          <hr align="center" width="50%" size="1"/>
          <br />
          <h4 align="center">
            <xsl:choose>
              <xsl:when test="/*/@xml:lang='de'">von </xsl:when>
              <xsl:when test="/*/@xml:lang='en'">by </xsl:when>
            </xsl:choose>
            <xsl:value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>
          </h4>
          <xsl:for-each select="/*/xtory:Global/xtory:Übersetzung/xtory:Name">
            <br />
            <p style="text-align:center">
              <xsl:choose>
                <xsl:when test="/*/@xml:lang='en'">English translation by </xsl:when>
              </xsl:choose>
              <xsl:value-of select="."/>
            </p>
          </xsl:for-each>
        </div>
        <xsl:apply-templates select="/*/xtory:Rubriken/xtory:WasBisherGeschah"/>
        <xsl:apply-templates select="/*/xtory:Rubriken/xtory:Hauptpersonen"/>
        <xsl:apply-templates select="/*/xtory:Text"/>
        <div id="vorschau" align="center">
          <p style="text-align:center;text-indent:0;margin-bottom:1em">
            <strong>
              <xsl:choose>
                <xsl:when test="/*/@xml:lang='de'">E N D E</xsl:when>
                <xsl:when test="/*/@xml:lang='en'">T H E &#160; E N D</xsl:when>
                <xsl:when test="/*/@xml:lang='fr'">F I N</xsl:when>
              </xsl:choose>
            </strong>
            <br />
          </p>
          <xsl:apply-templates select="/*/xtory:Rubriken/xtory:Vorschau/*"/>
        </div>
        <xsl:apply-templates select="/*/xtory:Rubriken/xtory:Kommentar"/>
        <xsl:apply-templates select="/*/xtory:Rubriken/xtory:Glossar"/>
        <hr size="1" />
        <p id="impressum" style="font:x-small sans-serif;text-indent:0">
          <small>
            <xsl:call-template name="Text_Impressum"/>
          </small>
        </p>
        <hr size="1" />
      </body>
    </html>
  </xsl:template>

<!--
   Was bisher geschah
-->
<xsl:template match="xtory:WasBisherGeschah">
  <hr size="0" style="width:0;page-break-before:always" />
  <h2 align="center" id="wasbisher">
    <xsl:choose>
      <xsl:when test="/*/@xml:lang='de'">Was bisher geschah</xsl:when>
      <xsl:when test="/xtory:Dorgon/@xml:lang='en'">Previously in <em>Dorgon</em></xsl:when>
    </xsl:choose>
  </h2>
  <br />
  <div>
    <xsl:apply-templates select="html:p"/>
  </div>
</xsl:template>

<!--
  Hauptpersonen
-->
<xsl:template match="xtory:Hauptpersonen">
  <hr size="0" style="width:0;page-break-before:always" />
  <h2 align="center" id="hauptper">
    <xsl:choose>
      <xsl:when test="/*/@xml:lang='de'">Hauptpersonen</xsl:when>
      <xsl:when test="/*/@xml:lang='en'">Main characters</xsl:when>
    </xsl:choose>
  </h2>
  <br />
  <div>
    <ul>
      <xsl:for-each select="xtory:Person">
        <li>
          <xsl:for-each select="xtory:Name">
            <xsl:choose>
              <xsl:when test="(position()!=1)and(position()=last())">
                <xsl:choose>
                  <xsl:when test="/*/@xml:lang='de'"> und </xsl:when>
                  <xsl:when test="/*/@xml:lang='en'"> and </xsl:when>
                  <xsl:when test="/*/@xml:lang='fr'"> et </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="(position()&gt;1)">, </xsl:when>
            </xsl:choose>
            <strong><xsl:value-of select="."/></strong>
          </xsl:for-each>
          <xsl:text> &#x2013; </xsl:text>
          <xsl:value-of select="xtory:Was"/>
        </li>
      </xsl:for-each>
    </ul>
  </div>
</xsl:template>

<!--
  Kommentar
-->
<xsl:template match="xtory:Kommentar">
  <hr size="0" style="width:0;page-break-before:always" />
  <h3 align="center" id="kommentar">
    <xsl:choose>
      <xsl:when test="/xtory:Dorgon/@xml:lang='de'"><small>DORGON</small> - Kommentar</xsl:when>
      <xsl:when test="/xtory:Dorgon/@xml:lang='en'"><em>Dorgon</em> Commentary</xsl:when>
      <xsl:when test="/*/@xml:lang='de'">Der Kommentar</xsl:when>
      <xsl:when test="/*/@xml:lang='en'">Commentary</xsl:when>
    </xsl:choose>
  </h3>
  <h2 align="center"><xsl:value-of select="xtory:Titel"/></h2>
  <br />
  <div>
    <xsl:apply-templates select="html:p|html:ul|html:ol"/>
    <xsl:for-each select="xtory:Autor/xtory:Name">
      <p align="right" style="text-align:right">
        <strong><xsl:value-of select="xtory:Autor/xtory:Name"/></strong>
      </p>
    </xsl:for-each>
  </div>
</xsl:template>

<!--
  Vorschau
-->
<xsl:template match="xtory:Vorschau/p">
  <p><em><xsl:value-of select="."/></em></p>
</xsl:template>
<xsl:template match="xtory:Vorschau/xtory:Titel">
  <p style="text-align:center;text-indent:0"><strong><em><xsl:value-of select="."/></em></strong></p>
</xsl:template>

<!--
  Glossar
-->
<xsl:template match="xtory:Glossar">
  <hr size="0" style="width:0;page-break-before:always" />
  <h3 align="center" id="glossar">
    <xsl:choose>
      <xsl:when test="/*/@xml:lang='de'">Glossar</xsl:when>
      <xsl:when test="/*/@xml:lang='en'">Glossary</xsl:when>
    </xsl:choose>
  </h3>
  <xsl:for-each select="xtory:Titel">
    <h2 align="center"><xsl:value-of select="xtory:Titel"/></h2>
  </xsl:for-each>
  <br />
  <dl>
    <xsl:for-each select="xtory:Erklärung">
      <dt><xsl:value-of select="xtory:Titel"/></dt>
      <dd>
        <xsl:apply-templates select="p"/>
      </dd>
    </xsl:for-each>
  </dl>
</xsl:template>

<!--
  Romantext
-->
<xsl:template match="xtory:Text">
  <xsl:apply-templates select="xtory:Kapitel"/>
</xsl:template>

<xsl:template match="xtory:Kapitel">
  <hr size="0" style="width:0;page-break-before:always" />
  <h3 align="center" id="kap{@xtory:num}">
    <small style="font-size:50%">
      <xsl:choose>
        <xsl:when test="@xtory:num=0">
          <xsl:choose>
            <xsl:when test="/*/@xml:lang='de'">P R O L O G</xsl:when>
            <xsl:when test="/*/@xml:lang='en'">P R O L O G U E</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="@xtory:num=99">
          <xsl:choose> 
            <xsl:when test="/*/@xml:lang='de'">E P I L O G</xsl:when>
            <xsl:when test="/*/@xml:lang='en'">E P I L O G U E</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="/*/@xml:lang='de'">K A P I T E L</xsl:when>
            <xsl:when test="/*/@xml:lang='en'">C H A P T E R</xsl:when>
          </xsl:choose>
          <xsl:text> &#160; </xsl:text>
          <xsl:value-of select="@xtory:num"/>
        </xsl:otherwise>
      </xsl:choose>
    </small>
  </h3>
  <h2 align="center"><xsl:value-of select="xtory:Titel"/></h2>
  <xsl:apply-templates select="xtory:Abschnitt|xtory:Zitat"/>
</xsl:template>

<xsl:template match="xtory:Abschnitt">
  <div>
    <xsl:apply-templates select="html:p"/>
  </div>
  <xsl:if test="position()!=last()">
    <hr size="0" style="text-align:center;width:25%;height:1px" />
  </xsl:if>
</xsl:template>

<xsl:template match="xtory:Zitat">
  <blockquote>
    <xsl:apply-templates select="html:p"/>
  </blockquote>
  <xsl:if test="position()!=last()">
    <hr size="0" style="text-align:center;width:25%;height:1px" />
  </xsl:if>
</xsl:template>

<xsl:template match="xtory:Abschnitt/html:p[1]/text()[1]">
  <xsl:choose>
    <xsl:when test="substring(self::text(),1,1)='»'">
      <xsl:text>»</xsl:text>
      <big><xsl:value-of select="substring(self::text(),2,1)"/></big>
      <xsl:value-of select="substring(self::text(),3)"/>
    </xsl:when>
    <xsl:when test="substring(self::text(),1,1)='&#8220;'">
      <xsl:text>&#8220;</xsl:text>
      <big><xsl:value-of select="substring(self::text(),2,1)"/></big>
      <xsl:value-of select="substring(self::text(),3)"/>
    </xsl:when>
    <xsl:otherwise>
      <big><xsl:value-of select="substring(self::text(),1,1)"/></big>
       <xsl:value-of select="substring(self::text(),2)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="em/em">
  <xsl:text disable-output-escaping="yes">&lt;/em&gt;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text disable-output-escaping="yes">&lt;em&gt;</xsl:text>
</xsl:template>

<!-- kopierter Driss ;-) -->

<xsl:template match="html:ol|html:ul"><xsl:copy><xsl:apply-templates select="html:li"/></xsl:copy></xsl:template>
<xsl:template match="html:p"><p><xsl:apply-templates/></p></xsl:template>
<xsl:template match="html:small"><small><xsl:apply-templates/></small></xsl:template>
<xsl:template match="html:em"><em><xsl:apply-templates/></em></xsl:template>
<xsl:template match="html:sup|html:li|text()"><xsl:copy><xsl:apply-templates/></xsl:copy></xsl:template>
<xsl:template match="html:br"><br /></xsl:template>

</xsl:stylesheet> 