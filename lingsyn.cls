%!TEX TS-program = XeLaTeX
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lingsyn}[2018/02/22  Class for Ling120B Syntax course documents]

\newcommand{\headlinecolor}{\normalcolor}
\LoadClass[a4paper, 12pt, colorlinks=true]{article}

% Default Packages used with org export dispatcher
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{grffile}
\RequirePackage{longtable}
\RequirePackage{wrapfig}
\RequirePackage{rotating}
\RequirePackage[normalem]{ulem}
\RequirePackage{amsmath}
\RequirePackage{textcomp}
\RequirePackage{amssymb}
\RequirePackage{capt-of}
\RequirePackage{hyperref}

% Need to disable shell escape for latexmk when using
% Tex-command-master
% \RequirePacakge{minted}
\RequirePackage{soul}
\RequirePackage[left=0.75in, right=0.75in, top=1.3in,
bottom=1in]{geometry}
\RequirePackage{ifthen}
\RequirePackage{float}
\RequirePackage{ifthen}

\RequirePackage{fontspec}
\setmainfont[Ligatures=TeX, Numbers={OldStyle, Proportional}]{Linux Libertine}

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% Other Packages
\RequirePackage{enumitem}
\RequirePackage{kvoptions}
\RequirePackage{xcolor}
\PassOptionsToPackage{hyperref,x11names}{xcolor}
\hypersetup{colorlinks=true,urlcolor=black,linkcolor=black}


% Linguistics Packages
\RequirePackage{linguex}
\RequirePackage{tipa}
\RequirePackage{phonrule}
\RequirePackage{gb4e}
\RequirePackage{leipzig}
\noautomath
\RequirePackage[linguistics,edges]{forest}



% Class Commands
\newcommand{\linkcolor}{\color{black}}
\newcommand{\urlcolor}{\color{black}}
\newcommand{\citecolor}{\color{black}}

\newcommand{\coursenumber}{120B}
\newcommand{\coursedepartment}{Linguistics}
\newcommand{\courseabbrev}{Ling}
\newcommand{\coursesecnum}{1D}
\newcommand{\coursename}{Syntax I}

% Linguistics Features
\newcommand{\sel}[1]{$\big[$ $\bullet$ #1 $\bullet$ $\big]$}
\newcommand{\plusf}[1]{$\big[$ + #1 + $\big]$}
\newcommand{\proj}[1]{$\overline{\text{#1}}$}

%% Class Options 

\DeclareOption{bluelinks}{%
  \renewcommand{\linkcolor}{\color{blue}}
  \renewcommand{\urlcolor}{\color{blue}}
  \renewcommand{\citecolor}{\color{blue}}
}

\newcommand{\coursedoc}{\@title}


\DeclareStringOption{num}
\ProcessKeyvalOptions*

\DeclareOption{assignment}{%
  \renewcommand{\coursedoc}{Assignment \lingsyn@num}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax


% Document Formatting
\pagestyle{fancy}

% Clear all header and footer fields
\fancyhead{}
\fancyfoot{}

\fancyhead[L]{%
  \ifthenelse{\value{page}=1}%
  {%
    \bfseries%
    \Large \coursedepartment \, \coursenumber \, - \coursedoc \\
    \large Section \coursesecnum
  }{%
    \courseabbrev \coursenumber \, - \coursedoc
  }%
}


\fancyhead[R]{%
  \ifthenelse{\value{page}>1}{Section \coursesecnum}{}
}

\rfoot{\thepage \, of \pageref{LastPage}}

\renewcommand{\headrulewidth}{2pt}

\renewcommand{\maketitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  \begin{flushright}
    \@author \\
    \courseabbrev \, \coursesecnum \, - \coursename \\
    \@date
  \end{flushright}
}
