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
      coursename={Ling 165B: Syntax II},
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
\ifthenelse{\boolean{ORGLING@nofloat}}{}{\RequirePackage{float}}
\ifthenelse{\boolean{ORGLING@nowrapfig}}{}{\RequirePackage{wrapfig}}
\ifthenelse{\boolean{ORGLING@nosoul}}{}{\RequirePackage{soul}}
\ifthenelse{\boolean{ORGLING@noxcolor}}{}{\RequirePackage[dvipsnames,x11names]{xcolor}}
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
  }
}


\ifpdf
  \ifthenelse{\boolean{ORGLING@nopdfrender}}{}{\RequirePackage{pdfrender}}
\fi

\RequirePackage{booktabs}
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
  \else
    \onehalfspacing
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
  \usetikzlibrary{positioning,shapes,fit,arrows.meta,calc}
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
 \newcommand*{\boldcheckmark}{\textbf{$✓$}}
\fi


\newcommand{\nl}{$\varnothing$}
\newcommand{\ml}[1]{\textsc{#1}}

\newcommand{\self}[1]{$[$\textbullet#1\textbullet$]$}
\newcommand{\sself}[1]{\self{#1} \boldcheckmark}
\newcommand{\ssself}[1]{\sout{\self{#1}}}

\newcommand{\plusfeat}[1]{$[$+#1+$[$}
\newcommand{\pplusfeat}[1]{$[$\sout{\plusfeat{#1}}$[$}
\newcommand{\ppplusfeat}[1]{\sout{\self{#1}}}

\newcommand{\pagree}[1]{$[\star\pi$: #1 $*]$}
\newcommand{\ppagree}[1]{$[\pi$: #1$]$}

\newcommand{\nagree}[1]{$[\star\#$: #1 $*]$}
\newcommand{\nnagree}[1]{$[\#$: #1$]$}

\newcommand{\tns}[1]{Tns$_{\text{#1}}$}
