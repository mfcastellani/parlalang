%{
	#include <stdlib.h>
	#include "main.h"
  #include "y.tab.h"
  #define ECHO fwrite(yytext, yyleng, 1, yyout) 
%}


%%
[a-z] { yylval.sIndex = *yytext - 'a'; return VARIABLE; }
0 { yylval.iValue = atoi(yytext); return INTEGER; }
[1-9][0-9]* { yylval.iValue = atoi(yytext); return INTEGER; }
[0-9]+\.[0-9]+ { yylval.iValue = atoi(yytext); return FLOAT; }

[-()<>=+*/;{}.,:] { return *yytext;}

">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"else"          return ELSE;
"fput"          return FPRINT;
"if"            return IF;
"inspect" 			return INSPECT;
"put"           return PRINT;
"quit"					return QUIT;
"while"         return WHILE;


[ \t]+                  /* ignore whitespace */;
%%

int yywrap(void) {
    return 1;
}