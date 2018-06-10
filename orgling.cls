%!TEX TS-program = XeLaTeX
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{orgling}[2018/02/22  LaTeX Class for CS180 course documents]
\LoadClass[a4paper, 12pt]{article}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Class Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{ifpdf}
\RequirePackage{remreset}
\RequirePackage{etoolbox}
\RequirePackage{changepage}
\RequirePackage{xstring}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[left=1in, right=1in, top=1.3in, bottom=1in]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{kvoptions}
\RequirePackage{kvoptions-patch}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Option Declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\SetupKeyvalOptions{
  family=ORGLING,
  prefix=ORGLING@
} % use shorter name for family name and prefix



% Org-mode Default Package Options
\DeclareBoolOption{nofontenc}
\DeclareBoolOption{nofixltx2e}
\DeclareBoolOption{nographicx}
\DeclareBoolOption{nolongtable}
\DeclareBoolOption{nofloat}
\DeclareBoolOption{nowrapfig}
\DeclareBoolOption{nosoul}
\DeclareBoolOption{notextcomp}
\DeclareBoolOption{nomarvosym}
\DeclareBoolOption{nowasysym}
\DeclareBoolOption{nointegrals}
\DeclareBoolOption{nolatexsym}
\DeclareBoolOption{noamssymb}
\DeclareBoolOption{nohyperref}

% Other Default Package Options
\DeclareBoolOption{noulem}
\DeclareBoolOption{norotating}
\DeclareBoolOption{nosubcaption}
\DeclareBoolOption{nomulticol}
\DeclareBoolOption{noenumitem}
\DeclareBoolOption{noxcolor}
\DeclareBoolOption{noamsthm}
\DeclareBoolOption{nocolorthms}
\DeclareBoolOption{nominted}
\DeclareBoolOption{nonameref}
\DeclareBoolOption{nocleveref}
\DeclareBoolOption{novarioref}
\DeclareBoolOption{nopdfrender}
\DeclareBoolOption{nonatbib}

% Font Options
\DeclareBoolOption{nofontspec}
\DeclareBoolOption{libertine}
\DeclareBoolOption{times}
\DeclareBoolOption{lmodern}

% Optional Package Options
\DeclareBoolOption{paralist}
\DeclareBoolOption{microtype}
\DeclareBoolOption{doublespace}

% Linguistics Package Options
\DeclareBoolOption{notipa}
\DeclareBoolOption{nogb4e}
\DeclareBoolOption{nogloss} % Alias to elide gb4e
\DeclareBoolOption{automath}
\DeclareBoolOption{noforest}
\DeclareBoolOption{nodatetime2}

% Document/Formatting Options
\DeclareStringOption{coursename}
\DeclareStringOption{coursenum}
\DeclareStringOption{coursedept}
\DeclareStringOption{duedate}
\DeclareBoolOption{homework}
\DeclareStringOption{hwnum}
\DeclareBoolOption{nodefault}
\DeclareBoolOption{noheader}
\DeclareComplementaryOption{notebook}{homework}
\DeclareStringOption{seriesnum}

% Process Options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}


\let\ORGLING@duedate\relax % https://tex.stackexchange.com/a/353852/156736

\ProcessKeyvalOptions*
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% Default Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@nofontenc}}{}{\RequirePackage[T1]{fontenc}}
\ifthenelse{\boolean{ORGLING@nofixltx2e}}{}{\RequirePackage{fixltx2e}}
\ifthenelse{\boolean{ORGLING@nographicx}}{}{\RequirePackage{graphicx}}
\ifthenelse{\boolean{ORGLING@nolongtable}}{}{\RequirePackage{longtable}}
\ifthenelse{\boolean{ORGLING@nofloat}}{}{\RequirePackage{float}}
\ifthenelse{\boolean{ORGLING@nowrapfig}}{}{\RequirePackage{wrapfig}}
\ifthenelse{\boolean{ORGLING@nosoul}}{}{\RequirePackage{soul}}
\ifthenelse{\boolean{ORGLING@notextcomp}}{}{\RequirePackage{textcomp}}
\ifthenelse{\boolean{ORGLING@nomarvosym}}{}{\RequirePackage{marvosym}}
\ifthenelse{\boolean{ORGLING@nointegrals}}{%
  {\RequirePackage{nointegrals}}%
  {\RequirePackage{integrals}}%
}

\ifthenelse{\boolean{ORGLING@nolatexsym}}{}{\RequirePackage{latexsym}}

\ifthenelse{\boolean{ORGLING@noamssymb}}{}{%
  \RequirePackage{amsmath}
  \RequirePackage{stmaryrd}
  \RequirePackage{mathptmx}
  \RequirePackage{amsfonts}
  \RequirePackage{amssymb}
  \RequirePackage{calligra}
  \RequirePackage{calrsfs}
  \RequirePackage[mathscr]{euscript}
  \DeclareMathAlphabet{\mathcalligra}{T1}{calligra}{m}{n}
  \newcommand{\R}{\mathbb{R}}
  \newcommand{\N}{\mathbb{N}}
  \newcommand{\Z}{\mathbb{Z}}
}

\ifthenelse{\boolean{ORGLING@noxcolor}}{}{\RequirePackage[dvipsnames,x11names]{xcolor}}

%%%%%%%%%%%%%%%%%%%%%%%%%
% Other Default Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@noulem}}{}{\RequirePackage[normalem]{ulem}}
\ifthenelse{\boolean{ORGLING@norotating}}{}{\RequirePackage{rotating}}
\ifthenelse{\boolean{ORGLING@nosubcaption}}{}{\RequirePackage{subcaption}}
\ifthenelse{\boolean{ORGLING@nomulticol}}{}{\RequirePackage{multicol}}
\ifthenelse{\boolean{ORGLING@noenumitem}}{}{\RequirePackage{enumitem}}

\ifthenelse{\boolean{ORGLING@noamsthm}}{}{%
  \ifORGLING@noamssymb
    \RequirePackage{amsmath}
  \fi
  \RequirePackage{amsthm}
  \RequirePackage{thmtools}
  \definecolor{thmtextcolor}{RGB}{0, 175, 236}
  \definecolor{thmbackgroundcolor}{RGB}{226, 244, 253}

  \colorlet{LightGray}{White!90!Periwinkle}

  \AtBeginEnvironment{mdframed}{%
    \def\mdf@footnoterule{}
  }
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
    headformat={\llap{\smash{\parbox[t]{0.8in}{\centering \NAME\\
            \NUMBER}}} \hspace{8pt} \NOTE},%
  ]{thmsty}

  \declaretheorem[
    style=thmsty,
    numberwithin=section
  ]{theorem}

  \declaretheorem[
    style=thmsty,
    sharenumber=theorem
  ]{definition}

  \declaretheorem[
    style=thmsty,
    sharenumber=theorem
  ]{lemma}

  \renewcommand\thmt@space{}

}

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
 
% \ifthenelse{\boolean{ORGLING@nocleveref}}{}{\RequirePackage{cleveref}}

\ifthenelse{\boolean{ORGLING@nopdfrender}}{}{\RequirePackage{pdfrender}}

\ifthenelse{\boolean{ORGLING@nonatbib}}{}{%
  \RequirePackage[numbers,comma]{natbib}
  \RequirePackage[version=3]{mhchem}
}

%%%%%%%%%%%%%%%%%%%%%%%%%
% Font Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\unless\ifORGLING@nofontspec
  \RequirePackage{fontspec}
\fi
  
\ifORGLING@lmodern
 \setromanfont[Ligatures=TeX]{Latin Modern Roman}
 % \RequirePackage{unicode-math}
 \setmathfont[math-style=ISO,bold-style=ISO,vargreek-shape=TeX]{Latin Modern Math}
\fi


\ifORGLING@times
  \setmainfont{Times New Roman}
\fi
  

\ifORGLING@libertine
  \setmainfont[Ligatures=TeX, Numbers={OldStyle, Proportional}]{Linux Libertine}}
\fi
  


%%%%%%%%%%%%%%%%%%%%%%%%%
% Optional Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@paralist}}{\RequirePackage{paralist}}{}
\ifthenelse{\boolean{ORGLING@microtype}}{\RequirePackage{microtype}}{}
\ifthenelse{\boolean{ORGLING@doublespace}}{%
  \RequirePackage{setspace}
  \doublespacing
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%
% Linguistics Packages
%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{ORGLING@notipa}}{}{%
  \RequirePackage{linguex}
  \RequirePackage{tipa}
}

\ifthenelse{\boolean{ORGLING@nogb4e}\or\boolean{ORGLING@nogloss}}{}{%
  \RequirePackage{gb4e}
  \unless\ifORGLING@automath
    \noautomath
  \fi
}

\ifthenelse{\boolean{ORGLING@noforest}}{}{%
  \RequirePackage{adjustbox}
  \RequirePackage{tikz}
  \usetikzlibrary{positioning,shapes,fit,arrows}
  \RequirePackage[linguistics,edges]{forest}
}

\ifthenelse{\boolean{ORGLING@nodatetime2}}{%
  \def\duedate{\today}
}{%
  \RequirePackage[calc, en-US, showdow]{datetime2}
  \DTMlangsetup[en-US]{dowmonthsep={,\space}}
  \ifx\ORGLING@duedate\relax
    \ClassWarning{orgling}{Option `duedate' is not set.}
  \else
    \def\duedate{\DTMDate{\ORGLING@duedate}}
  \fi
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

\newcommand{\self}[1]{$[$\textbullet#1\textbullet$]$}
\newcommand{\plusf}[1]{$[$+#1+$]$}
\newcommand{\selfc}[1]{\self{#1} $\boldcheckmark$}
\newcommand{\plusfc}[1]{\plusf{#1} $\boldcheckmark$}
\newcommand{\tns}[1]{Tns$_{\text{#1}}$}
\newcommand{\proj}[1]{$\overline{\text{#1}}$} % Deprecated

\newcommand{\sub}[1]{\textsubscript{#1}}
\newcommand{\msub}[2]{\mathrm{#1}_{\mathrm{#2}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Document Formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{plain}

% Clear all header and footer fields
\fancyhead{}
\fancyfoot{}

\def\lingtitle{\@title}
\def\lingsubtitle{}


\unless\ifORGLING@nodefault
  \ifthenelse{\boolean{ORGLING@homework}}{
    \def\lingsubtitle{Homework \ORGLING@hwnum \, ::  \duedate \, in class}
  }{%
    \def\lingsubtitle{Course Notebook}
  }
  \def\lingtitle{\ORGLING@coursedept \, \ORGLING@coursenum : \ORGLING@coursename}
\fi

\renewcommand{\maketitle}{%
  \begin{center}
    \bgroup\setlength{\parindent}{0pt}{\Huge \lingtitle}\egroup \\ \bigskip
    \large \lingsubtitle \medskip \\
  \end{center}

  \newlength{\namefieldwidth}
  \newlength{\authorwidth}
  \settowidth{\authorwidth}{\@author}
  \setlength{\namefieldwidth}{\dimexpr(0.5\textwidth - \authorwidth)}

  \par \textbf{Name}: \underline{\@author\hspace{\namefieldwidth}} \\ \medskip
}

