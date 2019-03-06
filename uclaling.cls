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
\RequirePackage{calc}
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
\DeclareStringOption{profname} % professor name
\DeclareStringOption{profemail} % professor email
\DeclareStringOption{quarter}
\DeclareStringOption[all]{subject} % One of 'all', 'phonetic', 'semantics', 'syntax
\DeclareStringOption[none]{style} % current options 'bumford', 'poole', or 'none'
\DeclareDefaultOption{%
  \ifx\CurrentOptionValue\relax
  % Expand \CurrentOption
  \expandafter\PassOptionsToClass
  \expandafter{\CurrentOption}{memoir}%
  \else
    \@unknownoptionerror
  \fi
}
\PassOptionsToClass{article,oneside,oldfontcommands,a4paper,11pt}{memoir}
\ProcessKeyvalOptions* % Process Options
\LoadClass{memoir} % Load Class
\let\LING@duedate\relax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figures, Markup, Lists, and Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage[usenames,dvipsnames,x11names,table]{xcolor}
\RequirePackage{iitem} % Multiple level lists
\RequirePackage{paralist} % enumerated items in paragraphs
\RequirePackage{ulem}
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
% \SetMathAlphabet{\mathit}{normal}{OML}{\rmdefault}{m}{n}

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
\RequirePackage{stmaryrd} % growing delimiters and additiona math symbols
\RequirePackage{bussproofs} % derivational proofs
\AtBeginEnvironment{prooftree}{\def\extraVskip{8pt}}
\alwaysRootAtTop
\newcommand{\ife}[4]{\ifthenelse{\equal{#1}{#2}}{#3}{#4}}
\newenvironment{tree}{\begin{prooftree}}{\end{prooftree}}
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
  {\gdef\scalefactor{#1}\begin{center}\proofSkipAmount \leavevmode}%
  {\scalebox{\scalefactor}{\DisplayProof}\proofSkipAmount \end{center} }


\RequirePackage{minted} % Syntax highlighting
\AtBeginEnvironment{minted}{% Remove red boxing around syntax errors
  \renewcommand{\fcolorbox}[4][]{#4}
}

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
\declaretheorem[style=thmsty,]{definition} % definitions
%% Problem
\RequirePackage{framed}
\RequirePackage{marginnote}
\newcounter{prob}[section]
\newcounter{subprob}[prob]
\newenvironment{problem}[1][]
{\refstepcounter{subprob}\raggedleftmarginnote{\textbf{\theprob.\thesubprob}\hspace{2mm}} \begin{minipage}[c]{0.9\textwidth}\FrameSep10pt\begin{framed} #1}
    {\end{framed}\end{minipage}\medskip}

%% Bibliography
\RequirePackage[longnamesfirst]{natbib}
\setcitestyle{authoryear,round,semicolon,aysep={}, yysep={,}, notesep={:}}
\RequirePackage[version=3]{mhchem}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Counters, Cross References, and Hyperlinks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}
\colorlet{lingurlcolor}{MidnightBlue}
\AtEndPreamble{
  \hypersetup{
    colorlinks=true,linkcolor=black,
    filecolor=black,citecolor=black
    urlcolor=MidnightBlue
  }
  \RequirePackage{url}
  \renewcommand\UrlFont{\color{red}\rmfamily\itshape}
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
\RequirePackage{tikz}
% ctable must be loaded after tikz
\RequirePackage{ctable} % Extended caption and footnote
\RequirePackage{adjustbox}
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
\ifthenelse{\equal{\LING@subject}{all}}{\semanticstrue\syntaxtrue\phoneticstrue}{%
  \ifthenelse{\equal{\LING@subject}{semantics}}{\semanticstrue}{\semanticsfalse}
  \ifthenelse{\equal{\LING@subject}{syntax}}{\syntaxtrue}{\syntaxfalse}
  \ifthenelse{\equal{\LING@subject}{phonetics}}{\phoneticstrue
    \onlyphoneticstrue}{\phoneticsfalse \onlyphoneticsfalse}
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
\newcommand{\vb}[0]{\text{\,|\, }}
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
\newcommand{\spec}[1]{\mbox{[Spec, #1]}}
\newcommand{\comp}[1]{\mbox{[Comp, #1]}}
\newcommand{\xbar}[1]{$\overline{\textrm{#1}}$}
\newcommand{\Agree}[0]{\textsc{Agree}\xspace}
\newcommand{\abar}[0]{\xbar{A}}
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document Structure and Formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\thesection}{\arabic{section}}


\RequirePackage[margin=1in]{geometry}
% \settypeblocksize{7.75in}{32pc}{*}
% \setlrmarginsandblock{3.5cm}{2.5cm}{*}
% \setulmarginsandblock{2.5cm}{*}{1}


\RequirePackage{cabin}

\newcommand*\titlehrule[1][0.4pt]{%
  \leavevmode\leaders\hrule height#1\hfill\kern0pt
}

\RequirePackage{changepage}
\RequirePackage{lastpage}
\let\footruleskip\undefined % https://tex.stackexchange.com/a/37880
\RequirePackage[explicit]{titlesec}
\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0mm}%
\fancyhf{} % Clear header

\ifonlyphonetics
\rfoot{\thepage}
\else
\rfoot{\itshape Page {\thepage} of \pageref{LastPage}} % 'Page X of Y' footer
\fi
\PassOptionsToPackage{bottom,hang,multiple}{footmisc}
\RequirePackage[calc,en-US, showdow]{datetime2}
\DTMlangsetup[en-US]{showdayofmonth=true}
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
\definestyle{poole}
\definestyle{bumford}
\ifthenelse{\equal{\LING@style}{bumford}}{\bumfordtrue}{}
\newcommand{\lingtitle}[0]{}
\ifbumford % use bumford style
\let\bumfordtitle\lingtitle
\unless\ifx\LING@coursenumber\@empty
\g@addto@macro\bumfordtitle{\textbf{\scshape {\MakeLowercase{\LING@coursenumber}}}: \@title\newline}
\fi
\unless\ifx\LING@profname\@empty
\g@addto@macro\bumfordtitle{\LING@profname\newline}
\fi
\renewcommand{\lingtitle}{
  \bgroup\setlength{\parindent}{0pt}%
  \bumfordtitle{}\\
  \smallskip\noindent\titlehrule[0.4mm]
  \begin{flushright}\@author\\\@date\\\end{flushright}\medskip
}
\else\ifpoole % use poole style
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
\let\pooletitle\lingtitle
\ifthenelse{\equal{squib}{\LING@type}}{% squib
  \unless\ifx\LING@assignmentnumber\@empty
  \g@addto@macro\pooletitle{Squib \LING@assignmentnumber\newline}
  \fi
  \unless\ifx\LING@coursenumber\@empty
  \g@addto@macro\pooletitle{\textsc{\LING@coursenumber}}
  \fi
  \unless\ifx\LING@coursename\@empty
  \g@addto@macro\pooletitle{ : \LING@coursename\\}
  \fi
}{\ifthenelse{\equal{homework}{\LING@type}}{% homework
    \unless\ifx\LING@profname\@empty
    \g@addto@macro\pooletitle{\LING@profname\newline}}
    \fi
    \unless\ifx\LING@coursename\@empty
    \g@addto@macro\pooletitle{\LING@coursename\\}
    \fi
    \g@addto@macro\pooletitle{\textbf{Due: \duedate}}
  }{% generic
    \unless\ifx\LING@profname\@empty
    \g@addto@macro\pooletitle{\LING@profname\\}
    \fi
    \unless\ifx\LING@coursenumber\@empty
    \g@addto@macro\pooletitle{\textsc{\LING@coursenumber}}
    \fi
    \unless\ifx\LING@coursename\@empty
    \g@addto@macro\pooletitle{ : \LING@coursename\\}
    \fi
    \g@addto@macro\pooletitle{\@date}
  }
}
\renewcommand{\lingtitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  {\LARGE \bfseries\@title}\hfill\@author \\
  \smallskip\noindent\titlehrule[0.4mm]
  \begin{flushright} \pooletitle \end{flushright}\egroup
}
\fi\fi
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
\RequirePackage{footmisc}
\renewcommand{\footnotemargin}[0]{1.25em}
\let\maketitle\lingtitle
\endinput %%% uclaling.cls ends here.
