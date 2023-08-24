\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{famcal}[2023/08/24 Family Calendar LaTeX class by Arne Meier]

\RequirePackage{babel}
\RequirePackage{translator} 

\DeclareOption{german}{%
	\PassOptionsToPackage{\CurrentOption}{babel}%
	\PassOptionsToPackage{\CurrentOption}{translator}%
}

\PassOptionsToClass{fontsize=14pt}{scrartcl}

\PassOptionsToPackage{paper=a3, pagesize, DIV=calc}{typearea}

\ProcessOptions\relax

\LoadClass{scrartcl}



\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper,margin=2cm,left=1cm]{geometry}

\RequirePackage{tikz}
\usetikzlibrary{calendar} 
\def\boxsize{\dimexpr(\linewidth-3cm)/\deffamilysize}
