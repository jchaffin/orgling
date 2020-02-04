%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% uclaling - a package for linguistic typesetting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uclaling}[2019/01/22 LaTeX class for linguistic typesetting]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\RequirePackage{efbox,calc}
\RequirePackage{etoolbox}
\RequirePackage{xpatch}
\RequirePackage{xstring}
\RequirePackage{xargs}
\RequirePackage{xifthen}
\RequirePackage[patch,debugshow]{kvoptions}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\SetupKeyvalOptions{family=LING,prefix=LING@}

\DeclareStringOption[generic]{type} % One of 'homework', 'notes', or 'squib'
\newcommand*{\SetupType}{%
  \expandafter\@SetupType\expandafter{\CurrentOption}%
}
\DeclareVoidOption{generic}{\SetupType}
\DeclareVoidOption{squib}{\SetupType}
\DeclareVoidOption{homework}{\SetupType}
\DeclareVoidOption{notes}{\SetupType}
\newcommand*{\@SetupType}[1]{\setkeys{LING}{type={#1}}}
\DeclareStringOption{coursename} % e.g 'Semantics II'
\DeclareStringOption{coursenumber} % e.g 'LING 165c'
\DeclareStringOption{assignmentnumber} % e.g 'Squib 3'
\DeclareStringOption{assignment}
\DeclareStringOption[none]{profname} % professor name
\DeclareStringOption{profemail} % professor email
\DeclareStringOption{quarter}
\DeclareStringOption[all]{subject} % One of 'all', 'phonetic', 'semantics', 'syntax
\DeclareDefaultOption{%
  \ifx\CurrentOptionValue\relax
  % Expand \CurrentOption
  \expandafter\PassOptionsToClass
  \expandafter{\CurrentOption}{memoir}%
  \else
    \@unknownoptionerror
  \fi
}
\PassOptionsToClass{article,oneside,oldfontcommands,a4paper,10pt}{memoir}
\ProcessKeyvalOptions* % Process Options
\LoadClass{memoir} % Load Class
\let\LING@duedate\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figures, Markup, Lists, and Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage[usenames,dvipsnames,x11names,table]{xcolor}
\RequirePackage{iitem} % Multiple level lists
\RequirePackage{eqlist}
\RequirePackage{paralist} % enumerated items in paragraphs
\RequirePackage[inline]{enumitem}
\RequirePackage{ulem}
\RequirePackage{changepage}
\RequirePackage{float} % Float environments
\RequirePackage{wrapfig} % Wrap text around float
\RequirePackage{rotating} % Rotate environment
\RequirePackage{subcaption} % subfigures
\RequirePackage{longtable} % Page breaking tables
\RequirePackage{supertabular} % For comparison to longtable
\RequirePackage{lscape} % Landscape tables
\RequirePackage{booktabs} % The nicest tables
\RequirePackage{tabularx} %  Adjust by column width instead of column spaces
\RequirePackage{tabulary} % Adjust by row height instead of row space
\RequirePackage{dcolumn} % Dynamic columns
\RequirePackage{rccol} % Right cented table column 'R' option
\RequirePackage{multicol} % Multiple columns
\RequirePackage{adjmulticol} % adjust multiple columns
\RequirePackage{multirow} % Multiple rows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonts, Symbols, and Maths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifxetex
\RequirePackage[fleqn,tbtags]{mathtools}
\RequirePackage{fontspec} % Open type fonts
\RequirePackage[math-style=literal]{unicode-math} % Support unicode input
\setmainfont{STIX Two Text} % Default Font
\setmathfont{STIX Two Math}[StylisticSet=02,StylisticSet=08] % Math font
\RequirePackage{fixmath}
\AtBeginDocument{\renewcommand{\epsilon}{\ensuremath{𝜖}}}
% \SetMathAlphabet{\mathit}{normal}{OML}{\rmdefault}{m}{n}
%running fraction with slash - requires math mode.
\setmonofont[Scale=MatchUppercase]{DejaVu Sans Mono} % Monospace Font
\fi

\ifxetex
\RequirePackage{stoneipa}
\newcommand\ipa[1]{{\sipafont #1}}
\fi

\RequirePackage{soul} % strike through and underline
\RequirePackage{marvosym}
\RequirePackage{arcs} % overarc
% https://tex.stackexchange.com/a/409041
\providecommand\@gobblethree[3]{}
\patchcmd{\over@under@arc}
 {\@gobbletwo}
 {\@gobblethree}
 {}{}
\RequirePackage{stmaryrd} % growing delimiters and additional math symbols
\RequirePackage{bussproofs} % derivational proofs
\AtBeginEnvironment{prooftree}{\def\extraVskip{8pt}}
\alwaysRootAtTop
\newcommand{\ife}[4]{\ifthenelse{\equal{#1}{#2}}{#3}{#4}}
\newcommand{\ax}[1]{\AxiomC{\EMX{#1}}}
\renewcommandx{\inf}[2][1=1, usedefault]{
\ife{#1}{1}
  {\UnaryInfC{\EMX{#2}}}
  {\ife{#1}{2}
    {\BinaryInfC{\EMX{#2}}}
    {\ife{#1}{3}
      {\TrinaryInfC{\EMX{#2}}}
      {\ife{#1}{4}
        {\QuaternaryInfC{\EMX{#2}}}
        {\ife{#1}{5}
          {\QuinaryInfC{\EMX{#2}}}{}
        }
      }
    }
  }
}
\newcommand{\LL}[1]{\LeftLabel{#1}}
\newcommand{\RL}[1]{\RightLabel{#1}}
\newcommand{\binf}[1]{\inf[2]{#1}}
\newcommand{\Rule}[1]{\RightLabel{$\mathbf{#1}$}}
% Scaled prooftree
\newenvironment{sprooftree}[1]% https://tex.stackexchange.com/a/105748
{\gdef\scalefactor{#1}\begin{center}\proofSkipAmount\leavevmode}%
  {\scalebox{\scalefactor}{\DisplayProof}\proofSkipAmount\end{center} }
\newcommand{\HSPC}[1]{\insertBetweenHyps{\hskip#1}}
\newcommand{\LSPC}[1]{\def\LabelSpacing{#1}}
\newcommand{\VSKP}[1]{\def\extraVskip{#1}}
\newcommand{\SOH}[1]{\def\ScoreOverhang{#1}}
\RequirePackage{minted} % Syntax highlighting
\AtBeginEnvironment{minted}{% Remove red boxing around syntax errors
  \renewcommand{\fcolorbox}[4][]{#4}
}
\RequirePackage{array}
\RequirePackage{collcell}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Theorems, Bibliography, and Appendixes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsthm}    % https://ctan.org/pkg/amsthm
\RequirePackage{thmtools}  % https://ctan.org/pkg/thmtools
\definecolor{thmtextcolor}{RGB}{0,175,236}
\definecolor{thmbackgroundcolor}{RGB}{226,244,253}
\colorlet{LightGray}{White!90!Periwinkle}
 % Remove footnote rule in amsthm environment frames.
\AtBeginEnvironment{mdframed}{\def\mdf@footnoterule{}}
\declaretheoremstyle[%
  mdframed={
    skipabove=8pt,
    skipbelow=6pt,
    nobreak=true,
    hidealllines=true,
    backgroundcolor={LightGray},
    innerleftmargin=-3pt,
    innerrightmargin=5pt,
    align=center
  },
  spaceabove=3pt,spacebelow=3pt,%
  headfont=\normalfont\bfseries,%
  notefont=\normalfont\bfseries,%
  notebraces={}{. },%
  headpunct={},%
  postheadspace=0pt,%
  postheadhook={\hangindent16pt},
  headindent=0pt,%
  bodyfont=\normalfont,%
  headformat={\llap{\smash{\parbox[t]{0.8in}{\centering \NOTE}}} \hspace{8pt}},%
]{thmsty}
\declaretheorem[style=thmsty,numberwithin=section]{theorem} % theorems
\declaretheorem[]{definition} % definitions
%% Problem
\RequirePackage{framed}
\RequirePackage{marginnote}
\newenvironment{teqn}[1]{\begin{equation}\tag{#1}}{\end{equation}}
\newcounter{prob}[section]
\newcounter{subprob}[prob]
\newenvironment{problem}[1][]
{\refstepcounter{subprob}\raggedleftmarginnote{\textbf{\theprob.\thesubprob}\hspace{2mm}} \begin{minipage}[c]{0.9\textwidth}\FrameSep10pt\begin{framed} #1}
    {\end{framed}\end{minipage}\medskip}

\RequirePackage{listings} % http://ctan.org/pkg/listings
\lstset{
  mathescape=true,
  literate=
  {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
  {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
  {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
  {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
  {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
  {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
  {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
  {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
  {Ã}{{\~A}}1 {ã}{{\~a}}1 {Õ}{{\~O}}1 {õ}{{\~o}}1
  {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
  {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1
  {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
  {€}{{\euro}}1 {£}{{\pounds}}1 {«}{{\guillemotleft}}1
  {»}{{\guillemotright}}1 {ñ}{{\~n}}1 {Ñ}{{\~N}}1 {¿}{{?`}}1,
  basicstyle=\ttfamily\footnotesize,
}%

\lstdefinelanguage{Lambda}{%
  morekeywords={%
    if,then,else,fix % keywords go here
  },%
  morekeywords={[2]int},   % types go here
  otherkeywords={:}, % operators go here
  literate={% replace strings with symbols
    {->}{{$\to$}}{2}
    {lambda}{{$\lambda$}}{1}
  },
  basicstyle={\sffamily},
  keywordstyle={\bfseries},
  keywordstyle={[2]\itshape}, % style for types
  keepspaces,
  mathescape % optional
}[keywords,comments,strings]



%% Bibliography
\RequirePackage[longnamesfirst]{natbib}
\RequirePackage[version=3]{mhchem}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Counters, Cross References, and Hyperlinks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[unicode]{hyperref}
\colorlet{lingurlcolor}{MidnightBlue}
\AtEndPreamble{
  \hypersetup{
    colorlinks=true,linkcolor=black,
    filecolor=black,citecolor=black,
    urlcolor=lingurlcolor
  }
  \RequirePackage{url}
  \renewcommand\UrlFont{\rmfamily\itshape}
  \urlstyle{rm}
  \let\UrlSpecialsOld\UrlSpecials
  \def\UrlSpecials{\UrlSpecialsOld\do\/{\Url@slash}\do\_{\Url@underscore}}%
  \def\Url@slash{\@ifnextchar/{\kern-.11em\mathchar47\kern-.2em}%
    {\kern-.0em\mathchar47\kern-.08em\penalty\UrlBigBreakPenalty}}
  \def\Url@underscore{\nfss@text{\leavevmode \kern.06em\vbox{\hrule\@width.3em}}}

}
\RequirePackage{nameref} % label references
\RequirePackage{smartref} % extended references
\RequirePackage{varioref} % page references
\RequirePackage{prettyref} % verbose cross-refs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Typesetting for Linguistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtEndPreamble{
  \RequirePackage{gb4e} % linguistic glosses and examples
  \noautomath
}
\RequirePackage{makeidx}
\makeindex
\renewenvironment{theindex}
{\section*{\indexname}%
  \@mkboth{\MakeUppercase\indexname}%
  {\MakeUppercase\indexname}%
  \thispagestyle{plain}\parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \columnseprule \z@
  \columnsep 35\p@
  \let\item\@idxitem}
{}
\AtEndPreamble{\renewcommand{\indexname}{}}
\RequirePackage[acronym]{glossaries}
\makeglossaries

\RequirePackage{tikz}
\usetikzlibrary{%
  arrows,%
  automata,%
  calc,%
  decorations,%
  decorations.pathreplacing,%
  decorations.text,%
  fit,%
  positioning,%
  quotes,%
  shapes,%
  topaths
}

% ctable must be loaded after tikz
\RequirePackage{ctable} % Extended caption and footnote
\RequirePackage{adjustbox}
\tikzset{
  every state/.style={draw,circle},%
  exarrows/.style={%
    semithick,
    arrows={%
      -Stealth[
        scale=1,
        scale length=1,
        scale width=1
      ]
    }
  },
  dc/.style = {rounded corners=1pt, semithick},
  case/.style = {o, semithick, rounded corners=1pt},
  mvt/.style = {rounded corners=1pt, semithick},
  agree/.style = {rounded corners=1pt, semithick, o},
  icon/.style = {pos=0.25, yshift=-0.7ex},
  arrow-label/.style = {font=\scshape\itshape},
  o/.style = {
      shorten >=#1,
      shorten <=#1,
      decoration={
          markings,
          mark= at position 0 with
              { \fill circle [xshift=#1,radius=#1]; } ,
          mark= at position 1 with
              { \fill circle [xshift=-#1,radius=#1]; } ,
      },
      postaction=decorate
  },
  o/.default=1.75pt
}
% In-line Tikz nodes.
\newcommand{\tkn}[2]{%
  ~\tikz[na]{\node[yshift=-0.2ex](#1){\hspace*{-0.5ex}#2};~}}
\tikzstyle{na} = [remember picture,
                  baseline=-0.2ex,
                  inner xsep=0pt,
                  inner ysep=4pt,
                  outer xsep=0ex]

% Bracket diagrams.
\newenvironment{tikzbracket}{\begin{tikzpicture}[overlay, remember
    picture]}{\end{tikzpicture}}
% Movement arrows.
\tikzset{
    pics/mvt/.style n args={2}{code={
        \draw [->, mvt] (#1.south) -- ++(0, -\ArrowHeight) -| (#2.south);
    }},
    pics/mvt-above/.style n args={2}{code={
        \draw [->, mvt] (#1.north) -- ++(0, \ArrowHeight) -| (#2.north);
    }},
    pics/mvt-label/.style n args={3}{code={
        \draw [->, mvt] (#1.south) -- ++(0, -\ArrowHeight) -| (#2.south)
            node [arrow-label] {#3};
    }},
    pics/mvt-above-label/.style n args={3}{code={
        \draw [->, mvt] (#1.north) -- ++(0, \ArrowHeight) -| (#2.north)
            node [arrow-label-below] {#3};
    }},
}

% Case lines.
\tikzset{
    pics/case/.style n args={2}{code={
        \draw [case] (#1.south) -- ++(0, -\ArrowHeight) -| (#2.south);
    }},
    pics/case-above/.style n args={2}{code={
        \draw [case] (#1.north) -- ++(0, \ArrowHeight) -| (#2.north);
    }},
    pics/case-label/.style n args={3}{code={
        \draw [case] (#1.south) -- ++(0, -\ArrowHeight) -| (#2.south)
            node [arrow-label] {#3};
    }},
    pics/case-nej/.style n args={2}{code={
        \draw [case] (#1.south) -- ++(0, -\ArrowHeight) -| (#2.south)
            node[icon]{\nej};
    }}
}
\tikzstyle{label} = [draw, thin, rounded corners=1pt, fill=white, inner
sep=4pt, yshift =-3pt, font=\small\itshape, text height=.7em]
\tikzstyle{arrow-label} = [font=\small\itshape, pos=0.25, yshift=0.9ex]
\newlength{\ArrowHeight}
\setlength{\ArrowHeight}{3ex}
\newlength{\BelowArrowSkip}
\setlength{\BelowArrowSkip}{3ex}

\DeclareDocumentCommand \tikzexsetup {} {%
  \tikzstyle{every picture}+=[
    remember picture, inner sep=0pt,
    baseline, anchor=base
  ]
}
% arg 1: optional strut; arg 2: node name; arg 3: node content
\DeclareDocumentCommand \ND {s m m} {%
  \tikzifinpicture{}{\tikz}\node(#2){\IfBooleanTF{#1}{\strut}{}#3};}
\RequirePackage[linguistics,edges]{forest} % linguistic trees
\forestset{ % tree styles
  nice nodes/.style={% 1. nice nodes
    for tree={
      inner sep=1 pt,
      s sep=12pt,
      fit=band
    }
  },
  fairly nice empty nodes/.style={% 2. fairly nice empty nodes
    delay={
      where content={}{
        shape=coordinate,
        for parent={
          for children={anchor=north}
        }
      }
    }
  },
  pretty nice empty nodes/.style={% 3. pretty nice empty nodes
    for tree={
      calign=fixed edge angles,
      parent anchor=children,
      delay={
        if content={}{
          inner sep=0pt,
          edge path={
            \noexpand\path [\forestoption{edge}] (!u.parent anchor) --
            (.children)\forestoption{edge label} ;
          }
        }{}
      }
    }
  },
  perfectly nice empty nodes/.style={% 4. perfectly nice empty nodes
    for tree={
      calign=fixed edge angles,
      parent anchor=south
    },
    before typesetting nodes={
      where content={}{
        text width=.001pt,
        inner sep=0pt,
        before drawing tree={
          shape=coordinate,
          typeset node
        },
        for parent={
          for children={
            anchor=north
          }
        }
      }{}
    }
  },
  default preamble={
    for tree={
      text height=1em, inner ysep=0.5ex, s sep=1em, edge={semithick},
      text depth={}, l sep=1em
    }
  }
} % end forestset

\newif\ifsemantics
\newif\ifsyntax
\newif\ifphonetics
\newif\ifonlyphonetics
\newif\ifsquib
\newif\ifhomework
\newif\ifnotes

\ifthenelse{\equal{\LING@type}{squib}}{\squibtrue}{\squibfalse}
\ifthenelse{\equal{\LING@type}{homework}}{\homeworktrue}{\homeworkfalse}
\ifthenelse{\equal{\LING@type}{notes}}{\notestrue}{\notesfalse}

\ifthenelse{\equal{\LING@subject}{all}}{%
  \semanticstrue\syntaxtrue\phoneticstrue
}{%
  \ifthenelse{\equal{\LING@subject}{semantics}}{\semanticstrue}{\semanticsfalse}
  \ifthenelse{\equal{\LING@subject}{syntax}}{\syntaxtrue}{\syntaxfalse}
  \ifthenelse{\equal{\LING@subject}{phonetics}}{\phoneticstrue \onlyphoneticstrue}{\phoneticsfalse \onlyphoneticsfalse}
}



\ifphonetics % Phonetics packages
\RequirePackage{phonetic} % Phonetics macros
\RequirePackage{vowel}
\RequirePackage{phonrule}
\RequirePackage{phonenumbers}
\RequirePackage{ipaex-type1}
\fi
\ifsemantics % Semantics packages
\newcommand{\denotation}[1]{\denotationbase{\text{#1}}}
\newcommand{\denotationbase}[1]{\ensuremath{\left\lsem#1\right\rsem}}
\newcommand{\startfn}[0]{\ensuremath{\ .\ }}
\newcommand{\Langle}[0]{\Big\langle}
\newcommand{\Rangle}[0]{\Big\rangle}
\newcommand{\sem}[2][M\!,g]{\mbox{ $[\![ #2 ]\!]^{#1}$}}
\newcommand{\cat}[1]{\ensuremath{\mathop{\mathslash{}}\limits_{\tiny #1}}}
\newcommand{\vb}[0]{\text{\,|\,}}
\newcommand{\arc}[2]{\overarc{$#1$$#2$}}
\fi
\ifsyntax % Syntax Packages
\ifpdf
\newcommand*{\boldcheckmark}{%
  \textpdfrender{
    TextRenderingMode=FillStroke,
    LineWidth=.5pt, % half of the line width is outside the normal glyph
  }{\checkmark}%
}
\else
\newcommand*{\boldcheckmark}{\textbf{$🗸$}}
\fi
% Data macros.
\newcommand{\objlang}[2][]{\textit{#2}\ifx&#1&\else\ `#1'\fi}
\newcommand{\ja}[0]{\ding{51}}
\newcommand{\gap}[0]{\rule[-1.25pt]{1.5em}{0.75pt}\,}
\newcommand{\ind}[1]{\ensuremath{_{#1}}}
% Features.
\newcommand{\feature}[1]{{\scshape [#1]}}
\newcommand{\mf}[1]{\feature{$\bullet$#1$\bullet$}}
\newcommand{\hf}[1]{\feature{$+$#1$+$}}
\newcommand{\agrf}[1]{\feature{$\star$#1$\star$}}
\newcommand{\self}[1]{\feature{$\bullet$#1$\bullet$}}
\newcommand{\selfs}[1]{\sout{\self{#1}}}
\newcommand{\selfc}[1]{\self{#1} $🗸$}
\newcommand{\plusf}[1]{\feature{$+$#1$+$}}
\newcommand{\plusfc}[1]{\sout{\plusf{#1}}}
\newcommand{\plusfs}[1]{$[$\sout{\plusfeat{#1}}$[$}
% Agreement features
\newcommand{\pagree}[1]{$[\star\pi$: #1 $*]$}
\newcommand{\ppagree}[1]{$[\pi$: #1$]$}
\newcommand{\nagree}[1]{$[\star\#$: #1 $*]$}
\newcommand{\nnagree}[1]{$[\#$: #1$]$}
% Satisfied features.
\newcommand{\shf}[1]{\hf{#1}{\scriptsize\,\ja}}
\newcommand{\smf}[1]{\mf{#1}{\scriptsize\,\ja}}
\newcommand{\sagrf}[1]{\agrf{#1}{\scriptsize\,\ja}}
% Phrase structure.
\newcommand{\tns}[1]{Tns$_{\text{#1}}$}
\newcommand{\vP}[0]{\textit{v}P\xspace}
\newcommand{\littlev}[0]{\textit{v}\xspace}
\newcommand{\head}[1]{#1$^0$}
\newcommand{\comp}[1]{\mbox{[Comp, #1]}}
\newcommand{\xbar}[1]{$\overline{\textrm{#1}}$}
\newcommand{\Agree}[0]{\textsc{Agree}\xspace}
\newcommand{\abar}[0]{\xbar{A}}
\fi
\newcommand*\rfrac[2]{{}^{#1}\!/_{#2}}
\newcommand{\highlight}[1]{\colorbox{LightGray}{$\displaystyle #1$}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document Structure and Formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\thesection}{\arabic{section}}

\RequirePackage[margin=1in]{geometry}
% \settypeblocksize{7.75in}{32pc}{*}
% \setlrmarginsandblock{3.5cm}{2.5cm}{*}
% \setulmarginsandblock{2.5cm}{*}{1}


\RequirePackage{cabin}
\RequirePackage{fancyvrb}
\DefineVerbatimEnvironment{verbatim}{Verbatim}{fontsize=\small,frame=single}

\newcommand*\titlehrule[1][0.4pt]{%
  \leavevmode\leaders\hrule height#1\hfill\kern0pt
}

\newlength{\offsetpage}
\setlength{\offsetpage}{1.0cm}
\newenvironment{widepage}{\begin{adjustwidth}{-\offsetpage}{-\offsetpage}%
    \addtolength{\textwidth}{2\offsetpage}}%
{\end{adjustwidth}}

\newenvironment{widecols}[1]% https://tex.stackexchange.com/a/105748
  {\begin{multicols}{#1}\begin{widepage}}%
  {\end{widepage}\end{multicols}}

\RequirePackage{lastpage}
\let\footruleskip\undefined % https://tex.stackexchange.com/a/37880
\RequirePackage[explicit]{titlesec}
\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0mm}%
\fancyhf{} % Clear header

\PassOptionsToPackage{bottom,hang,multiple}{footmisc}
\RequirePackage[calc,en-US, showdow]{datetime2}
\DTMlangsetup[en-US]{showdayofmonth=true}

\newcommand*{\email}[1]{\def\emailaddr{#1}}
\newcommand{\emaillink}[0]{\href{mailto:\emailaddr}{\emailaddr}}
\email{jchaffin@ucla.edu}

\newcommand{\definestyle}[1]{
 \lowercase{\def\tmpA{#1}}%
 \newboolean{\tmpA}
 \newif\ifsplit
 \IfSubStr{\LING@profname}{ }{\splittrue}{\splitfalse}
 \ifsplit
 \StrBehind{\LING@profname}{ }[\csB]%
 \else
 \let\csB\LING@profname
 \fi
 \StrGobbleLeft{\csB}{1}[\tmpB]
 \IfEndWith{#1}{\tmpB}{\setboolean{\tmpA}{true}}{\setboolean{\tmpA}{false}}
}



\newcommand\lingtitle[0]{\bgroup\setlength{\parindent}{0pt}\@title\egroup\\[12pt]}

\definestyle{poole}
\definestyle{hunter}
\definestyle{bumford}
\ifhunter
\def\huntertitle{}
\unless\ifx\LING@coursenumber\@empty
\g@addto@macro\huntertitle{\textbf{\scshape {\MakeLowercase{\LING@coursenumber}}} :
  \@title}
\else \g@addto@macro\huntertitle{\@title} \fi
\renewcommand{\lingtitle}{
  \bgroup\setlength{\parindent}{0pt}%
  \huntertitle{}\\
  \smallskip\noindent\titlehrule[0.4mm]
  \begin{flushright}\@author\\\@date\\\end{flushright}\medskip
}
\fi
\ifbumford
\def\bumfordtitle{}
\ifsquib
\unless\ifx\LING@coursenumber\@empty
\g@addto@macro\bumfordtitle{\textbf{\scshape {\MakeLowercase{\LING@coursenumber}}}}
\fi
\unless\ifx\LING@coursename\@empty
\g@addto@macro\bumfordtitle{\LING@coursename}
\fi
\def\assignment{}
\unless\ifx\LING@assignment\@empty
\let\assignment\LING@assignment
\fi
\renewcommand{\lingtitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  {\Large \@title}\vskip{2em}
  \begin{tabularx}{\textwidth}{X r}
    \@author & \bumfordtitle{} \\
    \ifx\emailaddr\@empty \else {\small \emaillink} \fi & \assignment
    \ifx\LING@profname\@empty \else \\ & \profname\fi
  \end{tabularx}
\else
\unless\ifx\LING@coursenumber\@empty
\g@addto@macro\bumfordtitle{\textbf{\scshape {\MakeLowercase{\LING@coursenumber}}} :
  \@title}
\else \g@addto@macro\bumfordtitle{\@title} \fi
\ifx\LING@profname\@empty \else \g@addto@macro\bumfordtitle{\\ \LING@profname} \fi
\renewcommand{\lingtitle}{
  \bgroup\setlength{\parindent}{0pt}%
  \bumfordtitle{}\\
  \smallskip\noindent\titlehrule[0.4mm]
  \begin{flushright}\@author\\\@date\\\end{flushright}\medskip
}
\fi
\fi
\ifpoole
\PassOptionsToPackage{norule}{footmisc}
\RequirePackage[p]{libertine}
% See  Manual for Linux Libertine with XeTeX
% http://linuxlibertine.sourceforge.net/Libertine-XeTex-EN.pdf
\ifxetex
% Loads fontspec, metalogo, and realscripts packages
% Might be unnecessary with a modern XeTeX so
% commenting out for now.
\RequirePackage{xltxtra}
% Convert accent-glyph sequences to single Unicode characters
\RequirePackage{xunicode}
% Recommended configuration for compatible mathematics
% XeLaTeX. From Section 6 - Concluding Remarks (p. 5) of the
% the libertine package manual.
\setmathfont[Scale=MatchUppercase]{libertinusmath-regular.otf}
  % set the main font to Linux Libertine
\setmainfont[Ligatures={Common,TeX}]{Linux Libertine}
% Set the monospace font to Latin Modern
\setmonofont{Latin Modern Mono Light}[SmallCapsFont={Latin Modern Mono Caps}]
\RequirePackage[supstfm=libertinesups,supscaled=1.125,raised=0em]{superiors}
\renewcommand{\baselinestretch}{1.15}
\else
\RequirePackage[libertine]{newxtmath}
\RequirePackage{microtype}
\fi
\def\pooletitle{}
\ifsquib
\ifx\LING@assignmentnumber\@empty \else \g@addto@macro\pooletitle{Squib
  \LING@assignmentnumber} \fi
\ifx\LING@coursenumber\@empty \else \\
\g@addto@macro\pooletitle{\textsc{\LING@coursenumber}} \fi
\if\LING@coursename\@empty \else \g@addto@macro\pooletitle{ : \LING@coursename} \fi
\else\ifhomework
\ifx\LING@profname\@empty \else \g@addto@macro\pooletitle{\\ \LING@profname} \fi
\ifx\LING@coursename\@empty \else \g@addto@macro\pooletitle{\\ \LING@coursename}
\fi
\g@addto@macro\pooletitle{\\ \textbf{Due: \duedate}}
\else
\ifx\LING@profname\@empty \else \g@addto@macro\pooletitle{\LING@profname} \fi
\ifx\LING@coursenumber\@empty \else \g@addto@macro\pooletitle{\textsc{\LING@coursenumber}} \fi
\ifx\LING@coursename\@empty \else \g@addto@macro\pooletitle{ : \LING@coursename}
\fi
\g@addto@macro\pooletitle{\\ \@date}
\fi % end ifsquib
\fi % end ifhomework
\renewcommand{\lingtitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  {\LARGE \bfseries\@title}\hfill\@author \\
  \smallskip\noindent\titlehrule[0.4mm]
  \begin{flushright} \pooletitle \end{flushright}\egroup
}
\fi

\ifonlyphonetics
\titleformat{\section}{\scshape}{\thesection}{0.6em}{#1:}
\titlespacing{\section}{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\renewcommand{\lingtitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  Name \underline{\hspace{4mm}\@author\hspace{2cm}}\hfill
  {\begin{flushright}
    \LING@coursename, \LING@quarter \\
    \LING@profname
  \end{flushright}}
  \begin{center}
    {\Large \MakeUppercase \@title} \\\medskip
    {\textbf{This homework is due in class on \DTMDate{\@date}}}
  \end{center}\egroup
}
\fi

\let\maketitle\lingtitle
\endinput %%% uclaling.cls ends here.
