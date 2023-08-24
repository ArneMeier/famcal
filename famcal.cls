\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{famcal}[2023/08/24 Family Calendar LaTeX class by Arne Meier]

\RequirePackage{babel}
\RequirePackage{translator} 

\RequirePackage{xcolor}
\RequirePackage{xkeyval}

\colorlet{vacation}{green}

\DeclareOptionX{vacation}[green]{\colorlet{vacation}{#1}}


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

\RequirePackage{tikz}
\usetikzlibrary{calendar} 
\def\boxsize{\dimexpr(\linewidth-3cm)/\deffamilysize}





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
	\noindent\hspace*{2.98cm}\begin{tikzpicture}
		\foreach \person [count=\personcount] in {#2}{
			\node[xshift=3cm, draw=black,anchor=west,minimum width=\boxsize,minimum height=1.6em,xshift=\boxsize*(\personcount-1),align=center] {\person};
		}
	\end{tikzpicture}
	
	\noindent\begin{tikzpicture} 
		  \calendar [%
		  dates=\defyear-\m-01 to \defyear-\m-last,%
		  day list downward,%
		  day yshift=1.6em,%
		  month label left vertical,%
		  every month/.append style={yshift=1em},%
		  day code={%
			\node[anchor = east]  {\pgfcalendarweekdayshortname{\pgfcalendarcurrentweekday}};
			\node[anchor = east, xshift=1.5em] {\tikzdaytext};
			\foreach \i [count=\icount] in {1,...,\deffamilysize}{
				\node[xshift=2em, anchor=west,draw=black,minimum width=\boxsize,minimum height=1.6em,xshift=\boxsize*(\icount-1)] {};}
			},
		  ]
	      if (Sunday) [red!75!black]
	      #3;
	\end{tikzpicture}
	\newpage
	}	
}