<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 2.0
  OeB Ausgabe

  (c) 2000-2002 Aki Alexandra Nofftz
-->
<xsl:stylesheet 
  version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xtory="http://stories.proc.org/xtory"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon"
  extension-element-prefixes="saxon"
  exclude-result-prefixes="xtory html">

<xsl:import href="global.xsl"/>
<xsl:output method="xml" encoding="ISO-8859-1" indent="no"/>

<!--
  <head>-Block der eBook-Dateien
-->
<xsl:template name="ebookhead">
  <xsl:param name="titel"/>
  <head>
    <title><xsl:value-of select="$titel"/></title>
    <meta name="Author" content="{/*/xtory:Global/xtory:Autor/xtory:Name}" />
    <meta name="Creator" content="Aki Alexandra Nofftz (stories@proc.org)" />
    <meta name="Generator" content="Xtory 2.0" />
    <style type="text/x-oeb1-css">
      <xsl:text>big{font-size:200%}</xsl:text>
      <xsl:text>div{margin-bottom:2em}</xsl:text>
      <xsl:text>h2{margin-top:0;margin-bottom:1em}</xsl:text>
      <xsl:text>h3{margin-bottom:0}</xsl:text>
      <xsl:text>p{text-align:justify;margin-bottom:0.1em}</xsl:text>
      <xsl:text>small{font-size:75%}</xsl:text>
      <xsl:text>em{font-style:italic}</xsl:text>
      <xsl:text>#hauptper li{font-family:sans-serif}</xsl:text>
      <xsl:text>dl,dd,dt{margin:0;padding:0}</xsl:text>
      <xsl:text>dt{font-weight:bold;margin:1em 0 1em 0}</xsl:text>
    </style>
  </head>
</xsl:template>

</xsl:stylesheet>