\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{template}
{2025-09-06}{1.0.0}{Jishen Lin}

\PassOptionsToPackage{quiet}{xeCJK}
\ProcessOptions\relax
\LoadClass[zihao=5,autoindent=0.5em]{ctexart}

\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage[para]{footmisc}
\RequirePackage[colorlinks=false,hidelinks,]{hyperref}
\RequirePackage{xeCJKfntef}
\RequirePackage{xcolor}

\pagestyle{empty}
\geometry{a4paper,margin=1cm, bottom=0.5cm}

\seq_new:N \g__resume_contacts_seq
\tl_new:N \g__resume_title_name_tl

\pagenumbering{gobble}

\ctexset{
    section={
        nameformat={},
        number={},
        format=\noindent \zihao{4} \heiti \__resume_section_title_format:n,
        indent=-1em,
        afterskip=0.5em,
        beforeskip=0.2em
    }
}

\setlist{
    labelsep=2pt,
    labelwidth=5pt,
    leftmargin=1.3em,
    itemsep=0em,
    parsep=0.20em,
    topsep=0em
}

\linespread{1.15}
\newcounter{resumebookmark}

\cs_new:Npn \__resume_append_concat:n #1{
    \seq_put_right:Nn \g__resume_contacts_seq {#1}
}
\cs_new:Npn \__resume_section_title_format:n #1{
    #1 \vspace{3pt} \hrule
}

\NewDocumentCommand{\ResumeContact}{m}{
    \__resume_append_concat:n {#1}
}

\NewDocumentCommand{\ResumeContacts}{m}{
    \seq_set_from_clist:Nn \l__input_seq:N {#1}
    \seq_map_inline:Nn \l__input_seq:N{
        \__resume_append_concat:n {##1}
    }
}

\NewDocumentCommand{\ResumeName}{m}{
    \tl_set:Nn \g__resume_title_name_tl {#1}
}

\NewDocumentCommand{\ResumeTitle}{}{
    \begin{center}
        \zihao{-2} \songti \bfseries \g__resume_title_name_tl
    \end{center}
    \vspace{-1.4em}
    \begin{center}
        \seq_use:Nnnn \g__resume_contacts_seq {~|~} {~|~} {~|~}
    \end{center}
}

\NewDocumentCommand{\ResumeItem}{omoo}{{
    \zihao{-4} \par \noindent{
        \heiti #2 \IfValueTF{#1}
        {
            \pdfbookmark[2]{#1}{subsec:\arabic{resumebookmark}}
        }
        {
            \pdfbookmark[2]{#2}{subsec:\arabic{resumebookmark}}
        }
        \stepcounter{resumebookmark}
    }
    \IfValueT{#3}{
        \tl_if_empty:nF {#3} {
            \ | \textit{#3}
        }
    }
    \hfill \IfValueT{#4}{#4} \par
}}

\NewDocumentCommand{\GrayText}{m}{
    \textcolor{gray}{#1}
}

\NewDocumentCommand{\ResumeUrl}{mm}{
    \href{#1}{\CJKunderline{#2}}
}

\endinput
