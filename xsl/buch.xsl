<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 2.0
  LaTeX Ausgabe für die Dorgon-Bücher

  (c) 2000-2002 Aki Alexandra Nofftz
-->
<stylesheet 
	version="1.0"
	xmlns="http://www.w3.org/1999/XSL/Transform"
   xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xtory="http://stories.proc.org/xtory"
	xmlns:saxon="http://icl.com/saxon"
	xmlns:xalan="http://xml.apache.org/xalan"
	extension-element-prefixes="saxon xalan">

<import href="global.xsl"/>
<output method="text" encoding="UTF-16" omit-xml-declaration="yes"/>

<!--
  Globale Struktur
-->

<template match="/">

\cleardoublepage
\pagestyle{empty}
\pdfdest name{heft<value-of select="/xtory:Dorgon/@xtory:heft"/>} fith
\pdfoutline goto name{heft<value-of select="/xtory:Dorgon/@xtory:heft"/>}{<value-of select="/*/@xtory:heft"/>. <value-of select="/xtory:Dorgon/xtory:Global/xtory:Titel"/>}

\begin{center}\usefont{T1}{handgot}{m}{n}
  \includegraphics[width=16cm]{tibis/dorgon<value-of select="/xtory:Dorgon/@xtory:heft"/>.jpg}
  \vskip 2cm
  {\Large Heft <value-of select="/xtory:Dorgon/@xtory:heft"/>}
  \vskip 5mm
  {\fontsize{42pt}{42pt}\selectfont <value-of select="/xtory:Dorgon/xtory:Global/xtory:Titel"/>}
  \vskip 2mm
  \textsf{\large <value-of select="/xtory:Dorgon/xtory:Global/xtory:Untertitel"/>}
  \vskip 1cm
  {\LARGE von <value-of select="/xtory:Dorgon/xtory:Global/xtory:Autor/xtory:Name"/>}
  \vskip 1mm
  {\Large Titelbild von <value-of select="/xtory:Dorgon/xtory:Global/xtory:Titelbild/xtory:Name"/>}
\end{center}

\cleardoublepage
\renewcommand\headheight{23pt}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[RE]{\large\textit{<value-of select="/xtory:Dorgon/xtory:Global/xtory:Autor/xtory:Name"/>}}
\fancyhead[LO]{\large\textit{<value-of select="/xtory:Dorgon/xtory:Global/xtory:Titel"/>}}
\fancyhead[RO,LE]{\large\thepage}
\fancyhead[CO,CE]{\usefont{T1}{pompc}{m}{n}\Large D~O~R~G~O~N}
\fancyfoot{}

<apply-templates select="/*/xtory:Text"/>

</template>


<!--
  Romantext
-->


<template match="xtory:Text">
\newpage
\begin{multicols}{2}
\normalfont\fontsize{12}{15}\selectfont\setlength\parindent{5mm}
<apply-templates select="xtory:Kapitel"/>
\end{multicols}
</template>

<template match="xtory:Kapitel">
<text>
</text>
\KapitelNT{<choose>
    <when test="@xtory:num=0">
      <choose>
        <when test="/*/@xml:lang='de'">Prolog</when>
        <when test="/*/@xml:lang='en'">Prologue</when>
      </choose>
    </when>
    <when test="@xtory:num=99">
      <choose>
        <when test="/*/@xml:lang='de'">Epilog</when>
        <when test="/*/@xml:lang='en'">Epilogue</when>
      </choose>
    </when>
    <otherwise><value-of select="@xtory:num"/></otherwise>
	</choose>}{<value-of select="xtory:Titel"/>}
<text>
</text>
<apply-templates select="xtory:Abschnitt|xtory:Zitat"/>
</template>

<template match="/xtory:Dorgon/xtory:Rubriken/xtory:Vorschau/xtory:Titel">
\begin{center}
  \upshape\usefont{T1}{pompc}{m}{n}
  <value-of select="."/>
\end{center}

</template>

<template match="/xtory:Story/xtory:Rubriken/xtory:Vorschau/xtory:Titel">
\begin{center}
  \upshape\usefont{T1}{erasdust}{m}{n}
  <value-of select="."/>
\end{center}

</template>

<template match="/xtory:Vithau/xtory:Rubriken/xtory:Vorschau/xtory:Titel">
\begin{center}
  \upshape\usefont{T1}{bauer}{m}{n}
  <value-of select="."/>
\end{center}

</template>

<template match="xtory:Abschnitt">
<apply-templates select="html:p"/>
<if test="not(position()=last())"><text>

\stern

</text></if>
</template>

<template match="xtory:Zitat">
\begin{em}
<apply-templates select="html:p"/>
\end{em}
<if test="not(position()=last())"><text>

\stern

</text></if>
</template>

<template match="html:p">
<apply-templates select="html:small|html:em|html:sup|text()"/><text>

</text>
</template>

<template match="html:ul">

\begin{itemize}
<apply-templates select="html:li"/>
\end{itemize}

</template>

<template match="html:ol">

\begin{enumerate}
<apply-templates select="html:li"/>
\end{enumerate}

</template>

<template match="html:li">

\item <apply-templates/>
</template>

<template match="html:small|text()"><value-of select="."/></template>
<template match="html:em">\emph{<value-of select="."/>}</template>
<template match="html:br">\\
</template>
<template match="html:sup">$^\mathrm{<value-of select="."/>}$</template>

</stylesheet>