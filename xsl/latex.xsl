<?xml version='1.0' encoding='ISO-8859-1'?>
<!--
  Xtory 2.0
  LaTeX Ausgabe

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
\documentclass[a4paper,twoside]{article}
\usepackage[T1]{fontenc}
\usepackage[latin1]{inputenc}
<choose>
  <when test="/*/@xml:lang='de'">\usepackage{ngerman}
</when>
</choose>
\usepackage{multicol}
\usepackage[a4paper,nofoot,twosideshift=1cm,top=1cm,bottom=1.5cm,left=2cm,right=2cm]{geometry}
\usepackage{fancyhdr}
\usepackage{graphicx}

\renewcommand\rmdefault{ptm}
\renewcommand\sfdefault{phv}
\renewcommand\ttdefault{pcr}

\setlength\columnsep{1cm}

\newcommand\stern{
  \nopagebreak[4]
  \vskip 1.5em
  \nopagebreak[4]
  \noindent\hfill * \hfill
  \nopagebreak[4]
  \vskip 1.5em
  \pagebreak[2]
}

\newcounter{kapitel}
\newcommand\KapitelNT[2]{
  \pagebreak[2]
  \stepcounter{kapitel}
  \pdfdest num \value{kapitel} fith
  \pdfoutline goto num \value{kapitel} {#1. #2}
  \noindent\begin{center}
    \vskip 1.5em \nopagebreak[4]
    #1. \nopagebreak[4] \\
    \parbox[t]{5cm}{\centering\emph{#2}} \nopagebreak[4]
    \vskip 1.5em
  \end{center}
  \nopagebreak[4]
}

\author{<value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>}
\title{<call-template name="Titel"/>}
\pdfinfo{
  /Title    (<call-template name="Titel"/>)
  /Creator  (LaTeX 2.09e (pdfTeX 0.14d))
  /Producer (Xtory 2.0 (SAXON))
  /Subject  (von <value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>)
  /Author   (Aki Alexandra Nofftz <text disable-output-escaping="yes">&lt;stories@proc.org&gt;</text>)
  /Keywords (<choose>
  <when test="/xtory:Dorgon">DORGON</when>
  <when test="/xtory:Vithau">Vithau</when>
  <when test="/xtory:ShadowWarrior">Shadow Warrior</when>
  <when test="/xtory:Story">TERRACOM, PROC-Stories</when>
</choose>, PROC, Perry Rhodan)
} \pdfcatalog{
  /PageMode /UseOutlines
} openaction goto name{tibi}

\begin{document}
\setlength\parindent{0mm}

\pagestyle{empty}
\pdfdest name{tibi} fit \pdfoutline goto name{tibi} {<choose>
    <when test="/*/@xml:lang='de'">Titelbild</when>
    <when test="/*/@xml:lang='en'">Cover</when>
  </choose>}

\begin{center}
  \parbox[top][3cm][c]{55mm}{\centering\usefont{T1}{handgot}{m}{n}\LARGE <value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>}
  \parbox[top][3cm][c]{40mm}{\includegraphics[width=4cm]{proc.jpg}}
  \parbox[top][3cm][c]{55mm}{\centering
    {\usefont{T1}{handgot}{m}{n}\LARGE <choose>
    <when test="/xtory:Dorgon|/xtory:Vithau|/xtory:ShadowWarrior">
      <choose>
        <when test="/*/@xml:lang='de'">Heft </when>
        <when test="/*/@xml:lang='en'">Episode </when>
      </choose>
      <value-of select="/*/@xtory:heft"/>
    </when>
    <when test="/xtory:Story">
      <choose>
        <when test="/*/@xml:lang='de'">{\large Erschienen am:}\\\vskip 2mm <value-of select="$Erschienen"/></when>
      </choose>
    </when>
  </choose> }
  <if test="$Zyklus!=''">
    \vskip 2mm\textsf{\large <value-of select="$Zyklus"/>}
  </if>}
  \vskip 5mm
  <choose>
    <when test="/xtory:Dorgon">
  {\usefont{T1}{pompc}{m}{n}\fontsize{68pt}{68pt}\selectfont D O R G O N}
  \vskip 5mm
  {\usefont{T1}{borg9}{m}{n}\Large <choose>
        <when test="/*/@xml:lang='de'">Die Fanserie des Perry Rhodan Online Club</when>
        <when test="/*/@xml:lang='en'">fan cycle of the Perry Rhodan Online Club</when>
      </choose>}
    </when>
    <when test="/xtory:Vithau">
  {\usefont{T1}{bauer}{m}{n}\fontsize{68pt}{68pt}\selectfont VITHAU}
  \vskip 5mm
  {\usefont{T1}{borg9}{m}{n}\fontsize{12pt}{12pt}\selectfont Eine interaktive Story des Perry Rhodan Online Club}
    </when>
    <when test="/xtory:ShadowWarrior">
  {\sffamily\fontsize{56pt}{56pt}\selectfont Shadow Warrior}
  \vskip 5mm
  {\usefont{T1}{handgot}{m}{n}\fontsize{16pt}{16pt}\selectfont Die Internet SF-Serie des Perry Rhodan Online Club}
    </when>
    <otherwise>
  {\usefont{T1}{erasdust}{m}{n}\fontsize{60pt}{60pt}\selectfont PROC STORIES}
  \vskip 5mm
  {\usefont{T1}{handgot}{m}{n}\fontsize{16pt}{16pt}\selectfont Fan-Stories aus dem PERRY RHODAN ONLINE CLUB}
    </otherwise>
  </choose>
  \vskip 5mm
  \includegraphics[width=16cm]{tibis/<value-of select="$dateiname"/>.jpg}
  \vskip 5mm
  {\usefont{T1}{handgot}{m}{n}\fontsize{42pt}{42pt}\selectfont <value-of select="/*/xtory:Global/xtory:Titel"/>}
  \vskip 2mm
  \textsf{\large <value-of select="/*/xtory:Global/xtory:Untertitel"/>}
\end{center}

\newpage
\pdfdest name{Rubriken} fit
\pdfoutline goto name{Rubriken} count <value-of select="count(/*/xtory:Rubriken/*)+2"/> {<choose>
    <when test="/*/@xml:lang='de'">Rubriken</when>
    <when test="/*/@xml:lang='en'">Columns</when>
  </choose>}


\pdfdest name{Titel} fitbh \pdfoutline goto name{Titel} {<choose>
    <when test="/*/@xml:lang='de'">Titel</when>
    <when test="/*/@xml:lang='en'">Title</when>
  </choose>}
<apply-templates select="/*/xtory:Global"/>

\vfill

<apply-templates select="/*/xtory:Rubriken/xtory:WasBisherGeschah"/>
<apply-templates select="/*/xtory:Rubriken/xtory:Hauptpersonen"/>

\vfill

\pdfoutline goto name{Vorschau} {<choose>
    <when test="/*/@xml:lang='de'">Vorschau</when>
    <when test="/*/@xml:lang='en'">Preview</when>
  </choose>}
<for-each select="/*/xtory:Rubriken/xtory:Kommentar">
\pdfoutline goto name{Kommentar} {<choose>
    <when test="/*/@xml:lang='de'">Kommentar</when>
    <when test="/*/@xml:lang='en'">commentary</when>
  </choose>}
</for-each>

<for-each select="/*/xtory:Rubriken/xtory:Glossar">
\pdfoutline goto name{Glossar} {<choose>
    <when test="/*/@xml:lang='de'">Glossar</when>
    <when test="/*/@xml:lang='en'">glossary</when>
  </choose>}
</for-each>

\pdfdest name{Impressum} fitbh \pdfoutline goto name{Impressum} {Impressum}
\begin{minipage}{162mm}
\hrule \vskip 1mm
\hskip 1mm
\parbox{160mm}{\scriptsize\sffamily
<call-template name="Text_Impressum"/> }
\end{minipage}

\newpage
\renewcommand\headheight{23pt}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[RE]{\large\textit{<value-of select="/*/xtory:Global/xtory:Autor/xtory:Name"/>}}
\fancyhead[LO]{\large\textit{<value-of select="/*/xtory:Global/xtory:Titel"/>}}
\fancyhead[RO,LE]{\large\thepage}
\fancyhead[CO,CE]{<choose>
  <when test="/xtory:Dorgon">\usefont{T1}{pompc}{m}{n}\Large D~O~R~G~O~N</when>
  <when test="/xtory:Vithau">\usefont{T1}{bauer}{m}{n}\Large VITHAU</when>
  <when test="/xtory:ShadowWarrior">\sffamily\Large Shadow Warrior</when>
  <when test="/xtory:Story">\usefont{T1}{erasdust}{m}{n}\large PROC STORIES</when>
</choose>}
\fancyfoot{}

<apply-templates select="/*/xtory:Text"/>

\pdfdest name{Vorschau} fith
\begin{center}
  \Large\usefont{T1}{pompc}{m}{n}<choose>
    <when test="/*/@xml:lang='de'">E~N~D~E</when>
    <when test="/*/@xml:lang='en'">T~H~E~~~E~N~D</when>
    <when test="/*/@xml:lang='fr'">F~I~N</when>
  </choose>
\end{center}

<apply-templates select="/*/xtory:Rubriken/xtory:Vorschau"/>
<apply-templates select="/*/xtory:Rubriken/xtory:Kommentar"/>
<apply-templates select="/*/xtory:Rubriken/xtory:Glossar"/>
\end{document}
</template>

<!--
  Titel (Seite 2)
-->
<template match="/xtory:Dorgon/xtory:Global">
\includegraphics[width=162mm]{dorgontitel.pdf}

\addvspace{-115mm}

\begin{minipage}{162mm}

{\usefont{T1}{pompc}{m}{n}\fontsize{54pt}{54pt}\selectfont\vskip 20mm D~O~R~G~O~N\hfill}\\
\hskip 5mm
\parbox[top][65mm][c]{10cm}{\flushleft
  \usefont{T1}{handgot}{m}{n}

  \textbf{\LARGE <choose>
     <when test="/*/@xml:lang='de'">Heft </when>
     <when test="/*/@xml:lang='en'">Episode </when>
   </choose>
   <value-of select="/*/@xtory:heft"/> }

<if test="$Zyklus!=''">
  \vskip 2mm
  \textsf{\Large <value-of select="$Zyklus"/>}
</if>

  \vskip 8mm

  {\fontsize{36}{48}\selectfont <value-of select="xtory:Titel"/>}
  \vskip 3mm
  {\huge <choose>
    <when test="/*/@xml:lang='de'">von </when>
    <when test="/*/@xml:lang='en'">by </when>
  </choose><value-of select="xtory:Autor/xtory:Name"/>}
  <apply-templates select="xtory:Übersetzung"/>
}

\vskip 1.5mm

<choose>
  <when test="/*/@xml:lang='de'">\hskip 2mm {\usefont{T1}{borg9}{m}{n}\Large DIE FANSERIE DES PERRY RHODAN ONLINE CLUB}</when>
  <when test="/*/@xml:lang='en'">\hskip .5mm {\usefont{T1}{borg9}{m}{n}\Large FAN SERIES OF THE PERRY RHODAN ONLINE CLUB}</when>
</choose>
\end{minipage}
</template>

<template match="/xtory:Vithau/xtory:Global">
\includegraphics[width=162mm]{vithautitel.pdf}

\addvspace{-115mm}
\begin{minipage}{162mm}

{\usefont{T1}{bauer}{m}{n}\fontsize{54}{54}\selectfont\vskip 20mm VITHAU\hfill}\\

\hskip 5mm
\parbox[top][62mm][c]{8cm}{\flushleft
  \usefont{T1}{handgot}{m}{n}

  \textbf{\LARGE <choose>
     <when test="/*/@xml:lang='de'">Heft </when>
     <when test="/*/@xml:lang='en'">Episode </when>
   </choose>
   <value-of select="/*/@xtory:heft"/>}

  \vskip 8mm

  {\fontsize{36}{48}\selectfont <value-of select="xtory:Titel"/>}
  \vskip 3mm
  {\huge von <value-of select="xtory:Autor/xtory:Name"/>}
}

\vskip 2mm

\hskip 2mm {\usefont{T1}{borg9}{m}{n}\fontsize{13pt}{13pt}\selectfont INTERAKTIVE STORY DES PERRY RHODAN ONLINE CLUB}
\end{minipage}

</template>

<template match="/xtory:ShadowWarrior/xtory:Global">
\includegraphics[width=162mm]{procstoriestitel.pdf}

\addvspace{-115mm}

\begin{minipage}{162mm}
\hskip 5mm {\sffamily\fontsize{54}{54}\selectfont\vskip 20mm Shadow Warrior\hfill}\\
\hskip 5mm
\parbox[top][65mm][c]{10cm}{\flushleft
  \usefont{T1}{handgot}{m}{n}
  \textbf{\LARGE <choose>
     <when test="/*/@xml:lang='de'">Heft </when>
     <when test="/*/@xml:lang='en'">Episode </when>
   </choose>
   <value-of select="/*/@xtory:heft"/>}

  \vskip 8mm

  {\fontsize{36}{48}\selectfont <value-of select="xtory:Titel"/>}
  \vskip 3mm
  {\huge von <value-of select="xtory:Autor/xtory:Name"/>}
}
\vskip 4.0mm
\hskip 2mm {\usefont{T1}{borg9}{m}{n}\fontsize{13pt}{13pt}\selectfont INTERNET SF-SERIE DES PERRY RHODAN ONLINE CLUB}
\end{minipage}
</template>

<template match="/xtory:Story/xtory:Global">
\includegraphics[width=162mm]{procstoriestitel.pdf}

\addvspace{-115mm}

\begin{minipage}{162mm}
\hskip 5mm {\usefont{T1}{erasdust}{m}{n}\fontsize{54}{54}\selectfont\vskip 20mm PROC STORIES\hfill}\\
\hskip 5mm
\parbox[top][65mm][c]{10cm}{\flushleft
  \usefont{T1}{handgot}{m}{n}

  {\fontsize{36}{48}\selectfont <value-of select="xtory:Titel"/>}
  \vskip 3mm
  {\huge von <value-of select="xtory:Autor/xtory:Name"/>}

  \vskip 10mm
  {\large Erschienen am:}\\
  {\large \textbf{<value-of select="$Erschienen"/>}}
}
\vskip 4.5mm
\hskip 2mm {\usefont{T1}{borg9}{m}{n}\fontsize{13pt}{13pt}\selectfont FAN-STORIES AUS DEM PERRY RHODAN ONLINE CLUB}
\end{minipage}
</template>

<template match="/*/xtory:Global/xtory:Übersetzung">
  \vskip 3mm
  {\large <choose>
    <when test="/*/@xml:lang='en'">English translation by </when>
  </choose><value-of select="xtory:Name"/>}
</template>


<!--
  Name mit eMail (Autor, Titelbild etc.)
-->
<template match="xtory:Autor|xtory:Titelbild|xtory:Übersetzung">
  <value-of select="xtory:Name"/>
</template>


<!--
   Rubriken
-->


<!-- Was bisher Geschah und Hauptpersonen -->

<template match="xtory:WasBisherGeschah">
\pdfdest name{WasBisher} fitbh
\pdfoutline goto name{WasBisher} {<choose>
    <when test="/*/@xml:lang='de'">Was bisher geschah</when>
    <when test="/xtory:Dorgon/@xml:lang='en'">Previously in Dorgon</when>
  </choose>}
\hskip 5mm
\begin{minipage}{93mm}
  \usefont{T1}{handgot}{m}{n}\fontsize{11}{13}\selectfont

<apply-templates select="html:p"/>
\end{minipage}</template>

<template match="xtory:Hauptpersonen">
\pdfdest name{Hauptper} fitbh
\pdfoutline goto name{Hauptper} {<choose>
    <when test="/*/@xml:lang='de'">Hauptpersonen</when>
    <when test="/*/@xml:lang='en'">Main characters</when>
  </choose>}
\begin{minipage}{6cm}
  \sffamily
  \begin{center}
   \large\textbf{<choose>
    <when test="/*/@xml:lang='de'">Hauptpersonen\\ des Romans</when>
    <when test="/*/@xml:lang='en'">Main characters</when>
  </choose>}
  \end{center}

  \vskip 5mm

  \begin{description}\small
  <for-each select="xtory:Person">
    <text>
    \item[]</text>
		<for-each select="xtory:Name">
			<choose>
			   <when test="(position()=last()) and (position()!=1)"> und </when>
				<when test="position()&gt;1">, </when>
			</choose>
			<text>\textbf{</text>
			<value-of select="."/>
			<text>}</text>
		</for-each>
	   <text> -- </text>
		<value-of select="xtory:Was"/>
  </for-each>
  \end{description}
\end{minipage}

</template>

<!--
  Kommentar
-->
<template match="xtory:Kommentar">
% \vfill\hrule\vskip 5mm
\newpage
\upshape

\pdfdest name{Kommentar} fith
<apply-templates select="xtory:Titel"/>

\vskip 5mm

\setlength\columnseprule{0.2pt}
\begin{multicols}{2}\usefont{T1}{handgot}{m}{n}\fontsize{11}{14}\selectfont\setlength\parindent{0mm}
<apply-templates select="html:p"/>

\vskip 0.5em
\hfill\textbf{<value-of select="xtory:Autor/xtory:Name"/>}
\end{multicols}

</template>

<template match="/xtory:Dorgon/*/xtory:Kommentar/xtory:Titel">
\begin{center}\sffamily
{\Huge\usefont{T1}{pompc}{m}{n}<choose>
    <when test="/*/@xml:lang='de'">D~O~R~G~O~N - Kommentar</when>
    <when test="/*/@xml:lang='en'">D~O~R~G~O~N commentary</when>
  </choose>}
\vskip 5mm
{\huge\usefont{T1}{handgot}{m}{n}<value-of select="."/>}
\end{center}
</template>

<template match="/xtory:Xtory/*/xtory:Kommentar/xtory:Titel">
\begin{center}\sffamily
{\Huge\usefont{T1}{erasdust}{m}{n}Der Kommentar}
\vskip 5mm
{\huge\usefont{T1}{handgot}{m}{n}<value-of select="."/>}
\end{center}
</template>


<!--
  Glossar
-->
<template match="xtory:Glossar">
\vfill\hrule\vskip 5mm

\pdfdest name{Glossar} fith
\begin{center}\sffamily
{\Huge\usefont{T1}{bauer}{m}{n}Glossar}
<for-each select="xtory:Titel">
\vskip 5mm
{\huge\usefont{T1}{handgot}{m}{n}<value-of select="."/>}
</for-each>
\end{center}

\vskip 5mm

\setlength\columnseprule{0.2pt}
\begin{multicols}{2}\setlength\parindent{0mm}\sffamily\normalsize
<apply-templates select="xtory:Erklärung/*"/>

<for-each select="xtory:Autor">
\vskip 0.5em
\hfill\textbf{<value-of select="xtory:Name"/>}
</for-each>
\end{multicols}
</template>

<template match="xtory:Glossar/xtory:Erklärung/xtory:Titel">
  \vskip 1em
  {\usefont{T1}{handgot}{m}{n}\Large\selectfont <value-of select="."/>}
  \vskip .75em

</template>


<!--
  Vorschau
-->
<template match="xtory:Vorschau">

\fontsize{12}{15}\selectfont
\itshape\setlength\parindent{0mm}
<apply-templates/>
\upshape

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

<template match="/xtory:ShadowWarrior/xtory:Rubriken/xtory:Vorschau/xtory:Titel">
\begin{center}
  \upshape\sffamily
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
<apply-templates select="html:small|html:em|html:sup|html:br|text()"/><text>

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

<template match="text()"><value-of select="."/></template>
<template match="html:small">{\fontsize{10}{15}\selectfont <apply-templates select="text()|html:small|html:em|html:sup"/>}</template>
<template match="html:em">\emph{<apply-templates select="text()|html:small|html:em|html:sup"/>}</template>
<template match="html:br">\\
</template>
<template match="html:sup">$^\mathrm{<apply-templates select="text()|html:small|html:em|html:sup"/>}$</template>

</stylesheet>