\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uclaling}[2019/01/22 LaTeX Class for UCLA Linguistics]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{ifpdf}
\RequirePackage{remreset}
\RequirePackage{etoolbox}
\RequirePackage{xstring}
\RequirePackage{changepage}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage[patch,debugshow]{kvoptions}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Option Declarations

\SetupKeyvalOptions{
  family=LING,
  prefix=LING@
} % use shorter name for family name and prefix

% Document/Formatting Options
\DeclareStringOption{coursename}
\DeclareStringOption{coursenumber}
\DeclareStringOption{assignment}
\DeclareStringOption{dept}
\DeclareStringOption{profname}
\DeclareStringOption{profemail}
\DeclareStringOption{univ}

\let\LING@assignment\relax
\let\LING@style\relax
\let\LING@duedate\relax
\DeclareDefaultOption{%
  \ifx\CurrentOptionValue\relax
  % Expand \CurrentOption
  \expandafter\PassOptionsToClass
  \expandafter{\CurrentOption}{article}%
  \else
    \@unknownoptionerror
  \fi
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProcessKeyvalOptions*

\LoadClass{article}

\RequirePackage[dvipsnames,x11names, table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{longtable}
\RequirePackage{float}
\RequirePackage{wrapfig}
\RequirePackage{soul}
\RequirePackage[dvipsnames,x11names, table]{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{rotating}
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage{enumitem}

\RequirePackage{amsmath}
\RequirePackage{fontspec}
\RequirePackage{semantic}

\RequirePackage{unicode-math}

\RequirePackage{cabin}
\RequirePackage{xpatch}

\RequirePackage{minted}
\AtBeginEnvironment{minted}{%
  \renewcommand{\fcolorbox}[4][]{#4}
} % Remove red boxing around syntax errors


\setmainfont{STIX Two Text}
\setmathfont{STIX Two Math}[StylisticSet=02, StylisticSet=08]
\setmonofont[Scale=MatchUppercase]{DejaVu Sans Mono}

% \RequirePackage[scale=1.15,p,osf]{stickstootext}
\RequirePackage{amsthm}    % https://ctan.org/pkg/amsthm
% \RequirePackage[stix2,vvarbb]{newtxmath}
% \RequirePackage[no-math]{fontspec}

\RequirePackage{thmtools}  % https://ctan.org/pkg/thmtools

\definecolor{thmtextcolor}{RGB}{0, 175, 236}
\definecolor{thmbackgroundcolor}{RGB}{226, 244, 253}

\colorlet{LightGray}{White!90!Periwinkle}

\AtBeginEnvironment{mdframed}{%
  \def\mdf@footnoterule{}
} % Remove footnote rule in amsthm environment frames.

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

\declaretheoremstyle[%
    mdframed={
      skipabove=8pt,
      skipbelow=6pt,
      nobreak=true,
      hidealllines=false,
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
    headformat={\llap{\smash{\parbox[t]{0.8in}{\centering \NUMBER}}} \hspace{8pt}},%
  ]{probsty}

  % Theorems
\declaretheorem[
  style=thmsty,
  numberwithin=section
  ]{theorem}

 % Problem environment
\newcounter{prob}[section]
\newcounter{subprob}[prob]
\declaretheorem[style=probsty,numberwithin=prob]{problem}

  % Definitions
\declaretheorem[
    style=thmsty,
  ]{definition}


\RequirePackage{hyperref}
\colorlet{csurlcolor}{black}
\AtEndPreamble{
  \hypersetup{
    colorlinks=true,
    linkcolor=black,
    filecolor=black,
    citecolor=black,
    urlcolor=csurlcolor
  }
  \urlstyle{rm}
}

\RequirePackage{nameref}
\RequirePackage{varioref}

\PassOptionsToPackage{linguistics}{forest}
\RequirePackage{forest}

% bib stuff
\RequirePackage[longnamesfirst]{natbib}
  \setcitestyle{authoryear,round,semicolon,%
  aysep={}, yysep={,}, notesep={:}}
\RequirePackage[version=3]{mhchem}

\RequirePackage{framed}
\RequirePackage{marginnote}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package Loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\lingassignment{}
\unless\ifx\LING@assignment\relax\@empty
   \renewcommand{\lingassignment}{\LING@assignment}
   \fi

\def\lingcoursename{}
\unless\ifx\LING@coursename\@empty
  \renewcommand{\lingcoursename}{\LING@coursename}
\fi
\def\lingprofname{}
\unless\ifx\LING@profname\@empty
  \renewcommand{\lingprofname}{\LING@profname}
\fi
\def\lingcoursenumber{}
\unless\ifx\LING@coursenumber\@empty
 \renewcommand{\lingcoursenumber}{\LING@coursenumber}
\fi


\newcommand*\titlehrule[1][0.4pt]{%
  \leavevmode\leaders\hrule height#1\hfill\kern0pt
}


\RequirePackage{pifont}
\RequirePackage[top=1in, bottom=1.25in, left=1.25in, right=1.25in]{geometry}

\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0mm}%
\fancyhf{} % Clear header
\rfoot{\itshape Page {\thepage} of \pageref{LastPage}} % Page X of Y



\renewcommand{\maketitle}{%
  \setlength{\parindent}{0pt}
  \begin{flushright}
    \@author \\
    \@date
  \end{flushright}\medskip
  \noindent\titlehrule[0.4mm] \\
  % Left Header
  {\scshape \lingcoursenumber} : \@title \\
  \lingprofname\\\smallskip
  \noindent\titlehrule[0.4mm]\\
  \vspace{0.7cm}
}
