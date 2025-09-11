\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{famcal}[2023/08/24 Family Calendar LaTeX class by Arne Meier, Version of 2025/09/11]

\LoadClass[fontsize=14pt,a4paper,DIV=20]{scrartcl}

% Color and keyval
\RequirePackage{xcolor}
\RequirePackage{xkeyval}

% Page layout and misc
\RequirePackage[utf8]{inputenc}
\RequirePackage{pagecolor}

% Language and translation packages
\RequirePackage{babel}
\RequirePackage{translator} 

% TikZ and calendar
\RequirePackage{tikz}
\usetikzlibrary{calendar} 
\RequirePackage{pgfcalendar}
\RequirePackage{pgffor}
\RequirePackage{xstring} % For string testing

% aux packages
\RequirePackage{eso-pic}
\RequirePackage{ifthen}

% Default colours for vacation etc.
\colorlet{vacation}{green!75!black}
\colorlet{bgdots}{blue!50!black}
\colorlet{bglightblue}{white!91!blue}
\colorlet{vacationColor}{red!50!white}
\DeclareOptionX{vacation}[green]{\colorlet{vacation}{#1}}

% Theme option
\newcommand{\theme}{plain}
  \DeclareOptionX{theme-bubbles}{%
	\renewcommand{\theme}{bubbles}
}

% Pass babel/translator options for german etc.
\DeclareOptionX{german}{%
	\PassOptionsToPackage{\CurrentOption}{babel}%
	\PassOptionsToPackage{\CurrentOption}{translator}%
  }


\ProcessOptionsX

% Counters for julian date calculations
\newcount\startjulian
\newcount\endjulian
\newcount\checkjulian

% Boolean flag for vacation
\newif\ifvacation
\vacationfalse

% further dimensions
\def\boxsize{\dimexpr(\linewidth-3.1cm)/\deffamilysize}


% Macro to check if given date is within a given date range (or equals a single date)
% #1 = date to check (YYYY-MM-DD)
% #2 = vacation date range or single date (YYYY-MM-DD/YYYY-MM-DD or YYYY-MM-DD) 
\newcommand{\checkvacation}[2]{% #1 = date, #2 = range or single date
  \IfStrEq{#2}{}{%
    % do nothing for empty string
  }{%
    \IfSubStr{#2}{/}{%
      % It's a range
      \expandafter\splitdaterange#2\relax
      \pgfcalendardatetojulian{\startdate}{\startjulian}%
      \pgfcalendardatetojulian{\enddate}{\endjulian}%
      \pgfcalendardatetojulian{#1}{\checkjulian}%
      % Inclusive range check
      \ifnum\checkjulian < \startjulian
      \else
        \ifnum\checkjulian > \endjulian
        \else
          \global\vacationtrue
        \fi
      \fi
    }{%
      % It's a single date, compare as strings (robust)
      \ifx#1#2
        \global\vacationtrue
      \fi
    }%
  }%
}


% Macro to split YYYY-MM-DD/YYYY-MM-DD into \startdate and \enddate
\def\splitdaterange#1/#2\relax{%
  \def\startdate{#1}%
  \def\enddate{#2}%
}

% Macro to process a comma-separated list of date ranges and set \ifvacation
\newcommand{\checkvacations}[2]{% #1 = date, #2 = list
  \vacationfalse % reset flag
  \edef\expandedvaclist{#2}%
   \foreach \range in \expandedvaclist {%
    \checkvacation{#1}{\range}%
  }%
}


% #1 base1 colour of the dots
% #2 base2 colour of the dots
\newcommand{\randomdots}[2]{
\pgfmathsetseed{\number\pdfrandomseed}
\begin{tikzpicture}[overlay,remember picture]
	\foreach \x in {0,...,100}{
		\pgfmathsetmacro\xrand{20*abs(rand)}
		\pgfmathsetmacro\yrand{40*abs(rand)}
		\pgfmathsetmacro\rrand{5*abs(rand)+2}
		\pgfmathsetmacro\crand{abs(rand)*100}
		\colorlet{bgdots}{#1!\crand!#2}
		\node[opacity=.5,fill=bgdots,inner sep=0mm,circle,minimum width=\rrand*4mm,minimum height=\rrand*4mm,xshift=1mm,yshift=1mm] at (\xrand,\yrand) {};
	}
\end{tikzpicture}
}



% #1 month index
% Define color names and RGB values for each month
\def\monthcolorname#1{%
  \ifcase#1
    \or blueviolet% 1
    \or icyblue% 2
    \or turqois% 3
    \or coldgreen% 4
    \or warmgreen% 5
    \or yellowgreen% 6
    \or sunshineyellow% 7
    \or orangeyellow% 8
    \or autumnorange% 9
    \or orangered% 10
    \or november% 11
    \or iceturqois% 12
  \fi
}
\def\monthcolorrgb#1{%
  \ifcase#1
    \or 83,0,194% 1
    \or 71,94,119% 2
    \or 57,220,198% 3
    \or 0,139,60% 4
    \or 170,214,136% 5
    \or 200,253,61% 6
    \or 255,253,55% 7
    \or 253,185,21% 8
    \or 238,153,80% 9
    \or 254,68,1% 10
    \or 190,119,103% 11
    \or 214,221,220% 12
  \fi
}


\newcommand{\bgtheme}[1]{%
  \ifthenelse{\equal{\theme}{bubbles}}{%
    \definecolor{\monthcolorname{#1}}{RGB}{\monthcolorrgb{#1}}%
    \newpagecolor{\monthcolorname{#1}!10!white}%
    \AddToShipoutPictureBG*{\randomdots{\monthcolorname{#1}}{white}}%
  }{}%
}

% #1: year
% #2: person names separated by ","
% #3: vacations
\newcommand{\makeFamCal}[3]{
	\xdef\defyear{#1}
	\foreach \n [count=\famsize] in {#2}{%
		\xdef\deffamilysize{\famsize}%
	}
	\def\vacationlist{#3}
	
	\foreach \m in {1,...,12}{
	  \pagestyle{empty}
	  \bgtheme{\m}
    \noindent\begin{tikzpicture}
      \foreach \person [count=\personcount] in {#2} {
        \node[
          fill=white,
          rounded corners,
          anchor=west,
          minimum width=\boxsize,
          minimum height=1.6em,
          xshift=\boxsize*(\personcount-1)+2em,
          yshift=1.8em
        ] {\person}; % 1.8cm above origin
      }
    \calendar [
      dates=\defyear-\m-01 to \defyear-\m-last,
      day list downward,
      day yshift=1.6em,
      month label left vertical,
      month text={\large\bfseries\pgfcalendarmonthname{\pgfcalendarcurrentmonth}~\pgfcalendarcurrentyear},
      every month/.append style={yshift=1em},
      day code={%
        % Build date string as YYYY-MM-DD
        \edef\currentdatestring{\pgfcalendarcurrentyear-\pgfcalendarcurrentmonth-\pgfcalendarcurrentday}%       
        % Check for vacation
        \checkvacations{\currentdatestring}{\vacationlist}%
        \ifvacation
          \def\myfill{vacationColor}
        \else
          \def\myfill{white}
        \fi
        % Day of week bubble
        \node[anchor = east, rounded corners, inner sep=0mm, minimum size=0.8cm, circle, fill=\myfill, opacity=0.93]  {\pgfcalendarweekdayshortname{\pgfcalendarcurrentweekday}};
        % Day number bubble
        \node[anchor = east, xshift=1.5em, rounded corners, inner sep=0mm,minimum size=0.8cm, circle, fill=\myfill, opacity=0.93] {\tikzdaytext};
        % Family size boxes
        \foreach \i [count=\icount] in {1,...,\deffamilysize}{
          \node[xshift=2em,anchor=west,draw=black,opacity=0.93,fill=white,minimum width=\boxsize,minimum height=1.6em,xshift=\boxsize*(\icount-1)] {};
        }
}
  ];
\end{tikzpicture}
	\newpage
	}	
}