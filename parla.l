%{
	#include <stdlib.h>
	#include "main.h"
  #include "y.tab.h"
  #define LOOKUP 0
%}


%%
[a-z] { yylval.sIndex = *yytext - 'a'; return VARIABLE; }

-?[0-9]* { yylval.iValue = atoi(yytext); return INTEGER; }

[eE][-+]?[0-9]*\.[0-9]+  { yylval.iValue = atoi(yytext); return FLOAT; }

([-()<>=+*/;{}.,:]) { return *yytext;}

(^\*{1,2}(.)\*{1,2}\n) { return COMMENT; }

">="                return GE;
"<="                return LE;
"=="                return EQ;
"!="                return NE;
"do"								return '{';
"else"              return ELSE;
"end"								return '}';
"fput"              return FPRINT;
"if"                return IF;
"into"							return INTO;
"load"							return DEFTOKEN;
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