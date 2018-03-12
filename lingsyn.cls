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
\RequirePackage{amssymb}
\RequirePackage{textcomp}
\RequirePackage{capt-of}
\RequirePackage{hyperref}
\RequirePackage{adjustbox}

% Need to disable shell escape for latexmk when using
% Tex-command-master
% \RequirePacakge{minted}

\RequirePackage{soul}
\RequirePackage[left=0.75in, right=0.75in, top=1.3in, bottom=1in]{geometry}
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

\DeclareBoolOption{automath}
\DeclareStringOption{num}
\DeclareBoolOption{nogloss}
\DeclareBoolOption{tipa}

\ProcessKeyvalOptions*

\iflingsyn@tipa
\RequirePackage{linguex}
\RequirePackage{tipa}
\else
% Do nothing
\fi

\iflingsyn@nogloss
% Do nothing
\else
\RequirePackage{gb4e}
\iflingsyn@automath
% Do nothing
\else
\noautomath
\fi
\fi
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

% Features
\newcommand{\self}[1]{$\big[$$\bullet$#1$\bullet$$\big]$}
\newcommand{\plusf}[1]{$\big[$+#1+$\big]$}

% Structure 
\newcommand{\xbar}[1]{$\overline{\text{#1}}$}
\newcommand{\proj}[1]{$\overline{\text{#1}}$}

%% Class Options 

\DeclareOption{bluelinks}{%
  \renewcommand{\linkcolor}{\color{blue}}
  \renewcommand{\urlcolor}{\color{blue}}
  \renewcommand{\citecolor}{\color{blue}}
}

\newcommand{\coursedoc}{\@title}


\DeclareOption{assignment}{%
  \renewcommand{\coursedoc}{Assignment \lingsyn@num}
}

\DeclareOption{notebook}{%
  \renewcommand{\coursedoc}{Course Notebook}
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
    \courseabbrev \, \coursenumber \, - \coursename \\
    \@date
  \end{flushright}
}
