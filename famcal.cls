\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{famcal}[2023/08/24 Family Calendar LaTeX class by Arne Meier]

\RequirePackage{babel}
\RequirePackage{translator} 

\RequirePackage{xcolor}
\RequirePackage{xkeyval}
\RequirePackage{tikz}
\RequirePackage{eso-pic}
\colorlet{vacation}{green!75!black}

\DeclareOptionX{vacation}[green]{\colorlet{vacation}{#1}}

\colorlet{bgdots}{blue!50!black}
\colorlet{bglightblue}{white!91!blue}

\newcommand{\theme}{plain}
\DeclareOptionX{theme-bubbles}{%
	\renewcommand{\theme}{bubbles}
}

\DeclareOptionX{german}{%
	\PassOptionsToPackage{\CurrentOption}{babel}%
	\PassOptionsToPackage{\CurrentOption}{translator}%
}

\PassOptionsToClass{fontsize=14pt}{scrartcl}

\PassOptionsToPackage{paper=a3, pagesize, DIV=calc}{typearea}

\ProcessOptionsX

\LoadClass{scrartcl}


\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper,margin=1cm,left=.5cm]{geometry}

\usetikzlibrary{calendar} 
\def\boxsize{\dimexpr(\linewidth-3cm)/\deffamilysize}



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


\RequirePackage{ifthen}
% #1 month index
\newcommand{\bgtheme}[1]{%
	\ifthenelse{\equal{\theme}{bubbles}}{%
		\ifthenelse{\equal{#1}{1}}{ % JANUARY
			\definecolor{blueviolet}{RGB}{83,0,194}
			\newpagecolor{blueviolet!10!white}
			\AddToShipoutPictureBG*{\randomdots{blueviolet}{white}}
		}{}
		\ifthenelse{\equal{#1}{2}}{ % FEBRUARY
			\definecolor{icyblue}{RGB}{71,94,119}
			\newpagecolor{icyblue!10!white}
			\AddToShipoutPictureBG*{\randomdots{icyblue}{white}}
		}{}
		\ifthenelse{\equal{#1}{3}}{ % MARCH
			\definecolor{turqois}{RGB}{57,220,198}
			\newpagecolor{turqois!10!white}
			\AddToShipoutPictureBG*{\randomdots{turqois}{white}}
		}{}
		\ifthenelse{\equal{#1}{4}}{ % APRIL
			\definecolor{coldgreen}{RGB}{0,139,60}
			\newpagecolor{coldgreen!10!white}
			\AddToShipoutPictureBG*{\randomdots{coldgreen}{white}}
		}{}
		\ifthenelse{\equal{#1}{5}}{ % MAY
			\definecolor{warmgreen}{RGB}{170,214,136}
			\newpagecolor{warmgreen!10!white}
			\AddToShipoutPictureBG*{\randomdots{warmgreen}{white}}
		}{}
		\ifthenelse{\equal{#1}{6}}{ % JUNE
			\definecolor{yellowgreen}{RGB}{200,253,61}
			\newpagecolor{yellowgreen!10!white}
			\AddToShipoutPictureBG*{\randomdots{yellowgreen}{white}}
		}{}
		\ifthenelse{\equal{#1}{7}}{ % JULY
			\definecolor{sunshineyellow}{RGB}{255,253,55}
			\newpagecolor{sunshineyellow!10!white}
			\AddToShipoutPictureBG*{\randomdots{sunshineyellow}{white}}
		}{}
		\ifthenelse{\equal{#1}{8}}{ % AUGUST
			\definecolor{orangeyellow}{RGB}{253,185,21}
			\newpagecolor{orangeyellow!10!white}
			\AddToShipoutPictureBG*{\randomdots{orangeyellow}{white}}
		}{}
		\ifthenelse{\equal{#1}{9}}{ % SEPTEMBER
			\definecolor{autumnorange}{RGB}{238,153,80}
			\newpagecolor{autumnorange!10!white}
			\AddToShipoutPictureBG*{\randomdots{autumnorange}{white}}
		}{}	
		\ifthenelse{\equal{#1}{10}}{ % OCTOBER
			\definecolor{orangered}{RGB}{254,68,1}
			\newpagecolor{orangered!10!white}
			\AddToShipoutPictureBG*{\randomdots{orangered}{white}}
		}{}	
		\ifthenelse{\equal{#1}{11}}{ % NOVEMBER
			\definecolor{november}{RGB}{190,119,103}
			\newpagecolor{november!10!white}
			\AddToShipoutPictureBG*{\randomdots{november}{white}}
		}{}		
		\ifthenelse{\equal{#1}{12}}{ % DECEMBER
			\definecolor{iceturqois}{RGB}{214,221,220}
			\newpagecolor{iceturqois!10!white}
			\AddToShipoutPictureBG*{\randomdots{iceturqois}{white}}
		}{}		
	}{}
}

\RequirePackage{pagecolor}
% #1: year
% #2: person names separated by ","
% #3: vacations
\newcommand{\makeFamCal}[3]{
	\xdef\defyear{#1}
	\foreach \n [count=\famsize] in {#2}{%
		\xdef\deffamilysize{\famsize}%
	}
	
	\foreach \m in {1,...,12}{
	\pagestyle{empty}
	\bgtheme{\m}
	\noindent\hspace*{2.98cm}\begin{tikzpicture}
		\foreach \person [count=\personcount] in {#2}{
			\node[xshift=3cm,fill=white,rounded corners,anchor=west,minimum width=\boxsize,minimum height=1.6em,xshift=\boxsize*(\personcount-1),align=center] {\person};
		}
	\end{tikzpicture}
	
	\noindent\begin{tikzpicture} 
		  \calendar [%
		  dates=\defyear-\m-01 to \defyear-\m-last,%
		  day list downward,%
		  day yshift=1.72em,%
		  month label left vertical,%
		  every month/.append style={yshift=1em},%
		  day code={%
			\node[anchor = east, rounded corners, inner sep=1mm, circle, fill=white, opacity=0.93]  {\pgfcalendarweekdayshortname{\pgfcalendarcurrentweekday}};
			\node[anchor = east, xshift=1.5em, rounded corners, inner sep=1mm, circle, fill=white, opacity=0.93] {\tikzdaytext};
			\foreach \i [count=\icount] in {1,...,\deffamilysize}{
				\node[xshift=2em,anchor=west,draw=black,opacity=0.93,fill=white,minimum width=\boxsize,minimum height=1.72em,xshift=\boxsize*(\icount-1)] {};}
			},
		  ]
	      if (Sunday) [red!75!black]
	      #3;
	\end{tikzpicture}
	\newpage
	}	
}