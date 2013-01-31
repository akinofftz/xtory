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
    <xsl:comment> Xtory 2.0 - XML/XSLT-Konvertierungssystem - (c) 2000-2002 AlexNofftz@email.com </xsl:comment>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="ebookhead">
        <xsl:with-param name="titel">
          <xsl:call-template name="Titel"/>
          <xsl:text> (</xsl:text>
          <xsl:choose>
            <xsl:when test="/*/@xml:lang='de'">Inhalt</xsl:when>
            <xsl:when test="/*/@xml:lang='en'">Contents</xsl:when>
          </xsl:choose>
          <xsl:text>)</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      <body>
        <p><strong><xsl:call-template name="Titel"/></strong></p>
        <ul>
          <li>
            <xsl:choose>
              <xsl:when test="/*/@xml:lang='de'">Rubriken</xsl:when>
              <xsl:when test="/*/@xml:lang='en'">Columns</xsl:when>
            </xsl:choose>
            <br />
            <small>
              <a href="{$dateiname}.html#titel">
                <xsl:choose>
                  <xsl:when test="/*/@xml:lang='de'">Titel</xsl:when>
                  <xsl:when test="/*/@xml:lang='en'">Title</xsl:when>
                </xsl:choose>
              </a>
              <xsl:if test="//xtory:WasBisherGeschah">
                <xsl:text>, </xsl:text>
                <a href="{$dateiname}.html#wasbisher">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Was bisher geschah</xsl:when>
                    <xsl:when test="/xtory:Dorgon/@xml:lang='en'">Previously in <em>Dorgon</em></xsl:when>
                  </xsl:choose>
                </a>
              </xsl:if>
              <xsl:if test="//xtory:Hauptpersonen">
                <xsl:text>, </xsl:text>
                <a href="{$dateiname}.html#hauptper">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Hauptpersonen</xsl:when>
                    <xsl:when test="/*/@xml:lang='en'">Main characters</xsl:when>
                  </xsl:choose>
                </a>
              </xsl:if>
              <xsl:if test="//xtory:Kommentar">
                <xsl:text>, </xsl:text>
                <a href="{$dateiname}.html#kommentar">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Kommentar</xsl:when>
                    <xsl:when test="/*/@xml:lang='en'">Commentary</xsl:when>
                  </xsl:choose>
                </a>
              </xsl:if>
              <xsl:if test="//xtory:Vorschau">
                <xsl:text>, </xsl:text>
                <a href="{$dateiname}.html#vorschau">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Vorschau</xsl:when>
                    <xsl:when test="/*/@xml:lang='en'">Preview</xsl:when>
                  </xsl:choose>
                </a>
              </xsl:if>
              <xsl:if test="//xtory:Glossar">
                <xsl:text>, </xsl:text>
                <a href="{$dateiname}.html#glossar">
                  <xsl:choose>
                    <xsl:when test="/*/@xml:lang='de'">Glossar</xsl:when>
                    <xsl:when test="/*/@xml:lang='en'">Glossary</xsl:when>
                  </xsl:choose>
                </a>
              </xsl:if>
              <xsl:text>, </xsl:text>
              <a href="{$dateiname}.html#impressum">Impressum</a>
            </small>
          </li>
          <xsl:for-each select="//xtory:Text/xtory:Kapitel">
            <li>
              <a href="{$dateiname}.html#kap{@xtory:num}">
                <xsl:choose>
                  <xsl:when test="@xtory:num=0">
                    <xsl:choose>
                      <xsl:when test="/*/@xml:lang='de'">Prolog</xsl:when>
                      <xsl:when test="/*/@xml:lang='en'">Prologue</xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test="@xtory:num=99">
                    <xsl:choose>
                      <xsl:when test="/*/@xml:lang='de'">Epilog</xsl:when>
                      <xsl:when test="/*/@xml:lang='en'">Epilogue</xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="@xtory:num"/></xsl:otherwise>
                </xsl:choose>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="xtory:Titel"/>
              </a>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>