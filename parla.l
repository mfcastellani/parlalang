%{
	#include <stdlib.h>
	#include "main.h"
  #include "y.tab.h"
  #define LOOKUP 0
%}


%s COMMENT

%%
^[ \t]*\*\* { BEGIN COMMENT; }
^[ \t]*\*\*[ \t]*.*[ \t]*\*\*\n {  } 

[a-z] { yylval.sIndex = *yytext - 'a'; return VARIABLE; }

-?[0-9]* { yylval.iValue = atoi(yytext); return INTEGER; }

[eE][-+]?[0-9]*\.[0-9]+  { yylval.iValue = atoi(yytext); return FLOAT; }

([-()<>=+*/;{}.,:]) { return *yytext;}

\*\*.*\*\* { return COMMENT; }

#.*									/* Possibilita o uso de she-bang */
">="                return GE;
"<="                return LE;
"=="                return EQ;
"!="                return NE;
"bchar"							return BCHAR_TYPE;
"set"								return DEFTOKEN;
"do"								return '{';
"echar"							return ECHAR_TYPE;
"else"              return ELSE;
"end"								return '}';
"if"                return IF;
"into"							return INTO;
"like"      				return TYPETOKEN;
"load"							return LOADTOKEN;
"say"               return PRINT;
"say bye" 			    return QUIT;
"say details about" |
"about"						  return INSPECT;
"while"             return WHILE;
\n 							    return EOL;
[ \t]								/* Ignorar espaço em branco e tab */
%%

int yywrap(void) {
    return 1;
}