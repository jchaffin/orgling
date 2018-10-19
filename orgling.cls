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

%% Font options pass to 'uclaling.sty'
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

% Optional Package Options
\DeclareBoolOption{paralist}
\DeclareBoolOption{doublespace}
\DeclareBoolOption{onehalfspace}
% Linguistics Package Options
\DeclareBoolOption{notipa}
\DeclareBoolOption{nogb4e}
\DeclareBoolOption{nogloss} % Alias to elide gb4e
\DeclareBoolOption{automath}
\DeclareBoolOption{noforest}
\DeclareBoolOption{nodatetime2}

% Document/Formatting Options
% Document/Formatting Options

\DeclareBoolOption{epoole}
\DeclareStringOption[]{type}

\DeclareStringOption{coursename}
\DeclareStringOption{coursenumber}
\DeclareStringOption{assignment}
\DeclareStringOption{dept}
\DeclareStringOption{profname}
\DeclareStringOption{profemail}
\DeclareStringOption{univ}
\DeclareStringOption{duedate}
\DeclareStringOption[]{style}

% Wait until options are processed to verify
% if values are set.
% https://tex.stackexchange.com/a/353852/156736
\let\ORGLING@duedate\relax
\let\ORGLIJNG@assignment\relax

%% Fallback
\DeclareDefaultOption{%
  \ifx\CurrentOptionValue\relax
  % Expand \CurrentOption
  \expandafter\PassOptionsToClass
  \expandafter{\CurrentOption}{article}%
  \else
    \@unknownoptionerror
  \fi
}
\PassOptionsToClass{a4paper}{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProcessKeyvalOptions*

% Load 'article' Class
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Package Loading

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifx\ORGLING@duedate\relax
  \def\duedate{\today}
\else
  \RequirePackage[calc,en-US,showdow]{datetime2}
  \DTMlangsetup[en-US]
  \def\duedate{\DTMDate{\ORGLING@duedate}}
\fi

\unless\ifx\ORGLING@assignment\relax\@empty
  \PassOptionsToPackage{assignment={\ORGLING@assignment}}{uclacs}
\fi


\ifthenelse{\boolean{ORGLING@epoole}}{%
  \PassOptionsToPackage{
    style=epoole,
    coursename={Ling 165B: Syntax II},
    profname={Ethan Poole},
    duedate={\duedate},
    \ORGLING@type,
    libertine}{uclaling}
}{\PassOptionsToPackage{\ORGLING@font}{uclaling}}

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

\ifthenelse{\boolean{ORGLING@nopdfrender}}{}{\RequirePackage{pdfrender}}

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
\ifthenelse{\boolean{ORGLING@notipa}}{}{%
  \RequirePackage{linguex}
  % Use 'safe' option to inhibit loading of possibly
  % 'dangerous' commands.
  \RequirePackage[safe]{tipa}
}

\ifthenelse{\boolean{ORGLING@nogb4e}\or\boolean{ORGLING@nogloss}}{}{%
  \AtEndOfClass{%
    \RequirePackage{gb4e}
    \noautomath
  }
}

\ifthenelse{\boolean{ORGLING@noforest}}{}{%
  \RequirePackage{adjustbox}
  \RequirePackage{tikz}
  \RequirePackage{tikz-qtree}
  \RequirePackage{tikz-qtree-compat}

  \RequirePackage{syntrace}

  \usetikzlibrary{positioning,shapes,fit,arrows.meta, calc}
   \tikzset{exarrows/.style={semithick,
 arrows={-Stealth[scale=1, scale length=1,
 scale width=1]}}}
  \DeclareDocumentCommand \tikzexsetup {} {%
  \tikzstyle{every picture}+=[remember picture, inner sep=0pt,
  baseline, anchor=base]}
  % arg 1: optional strut; arg 2: node name; arg 3: node content
  \DeclareDocumentCommand \ND {s m m} {%
  \tikzifinpicture{}{\tikz}\node(#2){\IfBooleanTF{#1}{\strut}{}#3};}

  \RequirePackage{forest}
  \useforestlibrary{linguistics}

  \forestset{
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
    default preamble={
      nice nodes
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://tex.stackexchange.com/questions/132783/how-to-write-checkmark-in-latex
\newcommand*{\boldcheckmark}{%
  \textpdfrender{
    TextRenderingMode=FillStroke,
    LineWidth=.5pt, % half of the line width is outside the normal glyph
  }{\checkmark}%
}

\newcommand{\sfeat}[1]{[\textbullet#1\textbullet]}
\newcommand{\sfeatc}[1]{\sfeat{#1} \boldcheckmark}
\newcommand{\sfeats}[1]{\sout{\sfeat{#1}}}
\newcommand{\pfeat}[1]{$[$+#1+$]$}
\newcommand{\pfeatc}[1]{\plusf{#1} $\boldcheckmark$}
\newcommand{\tns}[1]{Tns$_{\text{#1}}$}
\newcommand{\proj}[1]{$\overline{\text{#1}}$} % Deprecated



