%!TEX TS-program = XeLaTeX
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{orgling}[2018/10/17  LaTeX Class for Linguistics documents]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{ifpdf}
\RequirePackage{remreset}
\RequirePackage{etoolbox}
\RequirePackage{xstring}
\RequirePackage{ifthen}
\RequirePackage[patch,debugshow]{kvoptions}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Option Declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\SetupKeyvalOptions{
  family=ORGLING,
  prefix=ORGLING@
} % use shorter name for family name and prefix

% Org-mode Default Package Options
\DeclareBoolOption{nographicx}
\DeclareBoolOption{nolongtable}
\DeclareBoolOption{nobooktabs}
\DeclareBoolOption{nofloat}
\DeclareBoolOption{nowrapfig}
\DeclareBoolOption{nosoul}
\DeclareBoolOption{nomarvosym}
\DeclareBoolOption{nowasysym}
\DeclareBoolOption{nointegrals}
\DeclareBoolOption{nolatexsym}
\DeclareBoolOption{noams}
\DeclareBoolOption{nohyperref}
% Other Default Package Options
\DeclareBoolOption{noulem}
\DeclareBoolOption{norotating}
\DeclareBoolOption{nosubcaption}
\DeclareBoolOption{nosubfigure}
\DeclareBoolOption{nomulticol}
\DeclareBoolOption{noenumitem}
\DeclareBoolOption{noxcolor}
\DeclareBoolOption{nocolorthms}
\DeclareBoolOption{nominted}
\DeclareBoolOption{nonameref}
\DeclareBoolOption{nocleveref}
\DeclareBoolOption{novarioref}
\DeclareBoolOption{nopdfrender}
\DeclareBoolOption{nonatbib}
% Optional Package Options
\DeclareBoolOption{paralist}
\DeclareBoolOption{doublespace}
\DeclareBoolOption{onehalfspace}
% Linguistics Package Options
\DeclareBoolOption{nogloss} % Alias to elide gb4e and expex
\DeclareBoolOption{nogb4e}
\DeclareBoolOption{automath}
\DeclareBoolOption{noforest}
\DeclareBoolOption{nodatetime2}
%% Font options pass to 'uclaling.sty'
% Setup font options
% See pg. 9 Section 3 Example of kvoptions package
% https://ctan.org/pkg/kvoptions
\DeclareStringOption[sans]{font}
\newcommand*{\SetupFont}{%
  \expandafter\@SetupFont\expandafter{\CurrentOption}%
}
\DeclareVoidOption{roman}{\SetupFont}
\DeclareVoidOption{sans}{\SetupFont}
\DeclareVoidOption{libertine}{\SetupFont}
\DeclareVoidOption{times}{\SetupFont}
\DeclareVoidOption{stix}{\SetupFont}

\newcommand*{\@SetupFont}[1]{%
  \setkeys{ORGLING}{font={#1}}%
}

\DeclareStringOption{style}

\newcommand*{\SetupStyle}{%
  \expandafter\@SetupStyle\expandafter{\CurrentOption}%
}
\DeclareVoidOption{epoole}{\SetupStyle}
\DeclareVoidOption{phonetics}{\SetupStyle}

\newcommand*{\@SetupStyle}[1]{%
  \setkeys{ORGLING}{style={#1}} %
}

% Document/Formatting Options
\DeclareStringOption[]{type}
\DeclareStringOption{coursename}
\DeclareStringOption{coursenumber}
\DeclareStringOption{assignment}
\DeclareStringOption{dept}
\DeclareStringOption{profname}
\DeclareStringOption{profemail}
\DeclareStringOption{univ}
\DeclareStringOption{duedate}

% Wait until options are processed to verify
% if values are set.
% https://tex.stackexchange.com/a/353852/156736
\let\ORGLING@assignment\relax
\let\ORGLING@style\relax
\let\ORGLING@duedate\relax
%% Fallback
\DeclareDefaultOption{%
  \ifx\CurrentOptionValue\relax
  % Expand \CurrentOption
  \expandafter\PassOptionsToClass
  \expandafter{\CurrentOption}{memoir}%
  \else
    \@unknownoptionerror
  \fi
}
\PassOptionsToClass{article,oneside,oldfontcommands,11pt}{memoir}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProcessKeyvalOptions*

% Load 'article' Class
\LoadClass{memoir}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package Loading

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\unless\ifx\ORGLING@assignment\relax\@empty
  \PassOptionsToPackage{assignment={\ORGLING@assignment}}{uclacs}
\fi

\def\orglingfont{\ORGLING@font}

\RequirePackage[calc,en-US]{datetime2}
\DTMlangsetup[en-US]{showdayofmonth=true}

\def\duedate{\today}
\unless\ifx\ORGLING@duedate\relax
  \def\duedate{\DTMDate{\ORGLING@duedate}}
\fi

\PassOptionsToPackage{duedate={\duedate}}{uclaling}

\unless\ifx\ORGLING@style\relax\@empty
  \def\orglingstyle{\ORGLING@style}
  \ifthenelse{\equal{\orglingstyle}{epoole}}{%
    \renewcommand{\orglingfont}{libertine}
    \PassOptionsToPackage{
      style=epoole,
      coursename={Syntax II},
      coursenumber={Ling 165B},
      profname={Ethan Poole},
      \ORGLING@type
    }{uclaling}
  }{%
    \PassOptionsToPackage{style={\orglingstyle}}{uclaling}
  }
\fi
\PassOptionsToPackage{\orglingfont}{uclaling}

\RequirePackage{uclaling}

\ifthenelse{\boolean{ORGLING@nographicx}}{}{\RequirePackage{graphicx}}
\ifthenelse{\boolean{ORGLING@nolongtable}}{}{\RequirePackage{longtable}}
\ifthenelse{\boolean{ORGLING@nobooktabs}}{}{\RequirePackage{booktabs}}
\ifthenelse{\boolean{ORGLING@nofloat}}{}{\RequirePackage{float}}
\ifthenelse{\boolean{ORGLING@nowrapfig}}{}{\RequirePackage{wrapfig}}
\ifthenelse{\boolean{ORGLING@nosoul}}{}{\RequirePackage{soul}}
\ifthenelse{\boolean{ORGLING@noxcolor}}{}{\RequirePackage[dvipsnames,x11names, table]{xcolor}}
\ifthenelse{\boolean{ORGLING@noulem}}{}{\RequirePackage[normalem]{ulem}}
\ifthenelse{\boolean{ORGLING@norotating}}{}{\RequirePackage{rotating}}
\ifthenelse{\boolean{ORGLING@nosubcaption}}{}{\RequirePackage{subcaption}}
% \ifthenelse{\boolean{ORGLING@nosubfigure}}{}{\RequirePackage{subfigure}}
\ifthenelse{\boolean{ORGLING@nomulticol}}{}{\RequirePackage{multicol}}
\ifthenelse{\boolean{ORGLING@noenumitem}}{}{\RequirePackage{enumitem}}

\ifthenelse{\boolean{ORGLING@nominted}}{}{%
  \RequirePackage{minted}
  \AtBeginEnvironment{minted}{%
    \renewcommand{\fcolorbox}[4][]{#4}
  } % Remove red boxing around syntax errors
}

\ifthenelse{\boolean{ORGLING@nonameref}}{}{\RequirePackage{nameref}}
\ifthenelse{\boolean{ORGLING@novarioref}}{}{\RequirePackage{varioref}}

\ifthenelse{\boolean{ORGLING@nohyperref}}{}{%
  \RequirePackage{hyperref}
  \ifORGLING@noxcolor
    \colorlet{csurlcolor}{Aquamarine!85!black}
  \else
    \colorlet{csurlcolor}{black}
  \fi
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
}


\ifpdf
  \ifthenelse{\boolean{ORGLING@nopdfrender}}{}{\RequirePackage{pdfrender}}
\fi


\ifthenelse{\boolean{ORGLING@nonatbib}}{}{%
  \RequirePackage[longnamesfirst]{natbib}
  \setcitestyle{authoryear,round,semicolon,%
  aysep={}, yysep={,}, notesep={:}}
  \RequirePackage[version=3]{mhchem}
}

%%%%%%%%%%%%%%%%%%%%%%%%%
% Optional Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@paralist}}{\RequirePackage{paralist}}{}
\ifthenelse{\boolean{ORGLING@doublespace}\or\boolean{ORGLING@onehalfspace}}{%
  \RequirePackage{setspace}
  \ifORGLING@doublespace
    \doublespacing
  \fi
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%
% Linguistics Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@nogb4e}}{%
  \RequirePackage{expex}
  \definelingstyle{exarrbelow}{belowexskip=1em plus 0.375em minus 0.25em}
}{
  \AtEndPreamble{
  \RequirePackage{gb4e}
    \unless\ifx\ORGLING@automath
    \noautomath
    \fi
  }
}


\ifthenelse{\boolean{ORGLING@noforest}}{}{%
  \RequirePackage{tikz}
  \usetikzlibrary{decorations,decorations.pathreplacing,calc,fit,positioning,shapes,arrows.meta}
  \tikzset{
    exarrows/.style={%
      semithick,
      arrows={%
        -Stealth[
          scale=1,
          scale length=1,
          scale width=1
        ]
      }
    }
  }
  \tikzset{
    text height=0.65em,
    >=stealth
  }
  \tikzstyle{every picture}+=[>=stealth, anchor=base, text depth=0ex]
  \tikzset{
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
  \RequirePackage[linguistics,edges]{forest}
  \forestset{
    % Begin nice nodes
    nice nodes/.style={
      for tree={
        inner sep=1 pt,
        s sep=12pt,
        fit=band
      }
    },
    % Begin fairly nice empty nodes
    fairly nice empty nodes/.style={
      delay={
        where content={}{
          shape=coordinate,
          for parent={
            for children={anchor=north}
          }
        }
      }
    },
    % Begin pretty nice empty nodes
    pretty nice empty nodes/.style={
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
    % Begin perfectly nice empty nodes
    perfectly nice empty nodes/.style={
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
    default preamble = {
      for tree={
        text height=1em, inner ysep=0.5ex, s sep=1em, edge={semithick},
        text depth={}, l sep=1em
      }
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://tex.stackexchange.com/questions/132783/how-to-write-checkmark-in-latex
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


\newcommand{\nl}{$\varnothing$}
\newcommand{\ml}[1]{\textsc{#1}}
% Features
\newcommand{\self}[1]{\feature{$\bullet$#1$\bullet$}}
\newcommand{\plusf}[1]{\feature{$+$#1$+$}}
\newcommand{\selfc}[1]{\self{#1} $🗸$}
\newcommand{\plusfc}[1]{\sout{\plusf{#1}}}
\newcommand{\selfs}[1]{\sout{\self{#1}}}
\newcommand{\plusfs}[1]{$[$\sout{\plusfeat{#1}}$[$}

\newcommand{\pagree}[1]{$[\star\pi$: #1 $*]$}
\newcommand{\ppagree}[1]{$[\pi$: #1$]$}
\newcommand{\nagree}[1]{$[\star\#$: #1 $*]$}
\newcommand{\nnagree}[1]{$[\#$: #1$]$}
\newcommand{\tns}[1]{Tns$_{\text{#1}}$}
\newcommand{\vP}[0]{\textit{v}P\xspace}
\newcommand{\littlev}[0]{\textit{v}\xspace}

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

% Satisfied features.
\newcommand{\shf}[1]{\hf{#1}{\scriptsize\,\ja}}
\newcommand{\smf}[1]{\mf{#1}{\scriptsize\,\ja}}
\newcommand{\sagrf}[1]{\agrf{#1}{\scriptsize\,\ja}}

% Phrase structure.
\newcommand{\head}[1]{#1$^0$}
\newcommand{\spec}[1]{\mbox{[Spec, #1]}}
\newcommand{\comp}[1]{\mbox{[Comp, #1]}}
\newcommand{\xbar}[1]{$\overline{\textrm{#1}}$}

% Semantics.
\newcommand{\denotation}[1]{\denotationbase{\text{#1}}}
\newcommand{\denotationbase}[1]{\ensuremath{\left\lsem#1\right\rsem}}
\newcommand{\startfn}[0]{\ensuremath{\ .\ }}

\newcommand{\Agree}[0]{\textsc{Agree}\xspace}
\newcommand{\abar}[0]{\xbar{A}}
