%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdarg.h>
  #include <string.h>
  #include "main.h"

  /* prototypes */
  nodeType *opr(int oper, int nops, ...);
  nodeType *id(int i);
  nodeType *con(int value);
  void freeNode(nodeType *p);
  int ex(nodeType *p);
  int yylex(void);

  void yyerror(char *s);
  int sym[26];                    /* symbol table */
%}

%union {
    int iValue;                 /* integer value */
    char sIndex;                /* symbol table index */
    nodeType *nPtr;             /* node pointer */
};

/* Basic tokens */
%token <iValue> INTEGER
%token <iValue> FLOAT
%token <sIndex> VARIABLE
%token WHILE IF PRINT EOL INTO LOADTOKEN
%token QUIT INSPECT DEFTOKEN TYPETOKEN
%token BCHAR_TYPE ECHAR_TYPE NUMBER_TYPE

/* System tokens */
%token VERSION 
%nonassoc IFX
%nonassoc ELSE

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%type <nPtr> stmt expr stmt_list

%%

program:
        function                { exit(0); }
        ;

function:
        function stmt           { ex($2); freeNode($2); }
        | /* NULL */
        ;

stmt:
          EOL                               { $$ = opr(';', 2, NULL, NULL); }
        | QUIT EOL                          { printf("Bye!\n"); exit(0); }
        | PRINT expr EOL                    { $$ = opr(PRINT, 1, $2); }
        | INSPECT expr EOL                  { $$ = opr(INSPECT, 1, $2); }
        | VARIABLE '=' expr EOL             { $$ = opr('=', 2, id($1), $3); }
        | TYPETOKEN expr DEFTOKEN VARIABLE  { $$ = opr(DEFTOKEN, 2, id($4), $2); }
        | LOADTOKEN expr INTO VARIABLE      { $$ = opr('=', 2, id($4), $2); }
        | WHILE '(' expr ')' stmt           { $$ = opr(WHILE, 2, $3, $5); }
        | IF '(' expr ')' stmt %prec IFX    { $$ = opr(IF, 2, $3, $5); }
        | IF '(' expr ')' stmt ELSE stmt    { $$ = opr(IF, 3, $3, $5, $7); }
        | expr EOL                          { $$ = $1; }
        | '{' stmt_list '}'                 { $$ = $2; }
        ;

stmt_list:
          stmt                  { $$ = $1; }
        | stmt_list stmt        { $$ = opr(';', 2, $1, $2); }
        ;

expr:
          INTEGER               { $$ = con($1); }
        | FLOAT                 { $$ = con($1); }
        | VARIABLE              { $$ = id($1); }
        | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
        | expr '+' expr         { $$ = opr('+', 2, $1, $3); }
        | expr '-' expr         { $$ = opr('-', 2, $1, $3); }
        | expr '*' expr         { $$ = opr('*', 2, $1, $3); }
        | expr '/' expr         { $$ = opr('/', 2, $1, $3); }
        | expr '<' expr         { $$ = opr('<', 2, $1, $3); }
        | expr '>' expr         { $$ = opr('>', 2, $1, $3); }
        | expr GE expr          { $$ = opr(GE, 2, $1, $3); }
        | expr LE expr          { $$ = opr(LE, 2, $1, $3); }
        | expr NE expr          { $$ = opr(NE, 2, $1, $3); }
        | expr EQ expr          { $$ = opr(EQ, 2, $1, $3); }
        | '(' expr ')'          { $$ = $2; }
        | error                 { yyerror; }
        ;

%%

nodeType *con(int value) {
    nodeType *p;

    /* allocate node */
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeCon;
    p->con.value = value;

    return p;
}

nodeType *id(int i) {
    nodeType *p;

    /* allocate node */
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeId;
    p->id.i = i;

    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    int i;

    /* allocate node */
    if ((p = malloc(sizeof(nodeType))) == NULL)
        yyerror("out of memory");
    if ((p->opr.op = malloc(nops * sizeof(nodeType))) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
}

void freeNode(nodeType *p) {
    int i;

    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    free (p->opr.op);
    }
    free (p);
}

int main(int argc, char *argv[]) {
  size_t arglen;
  int i = 0;

  printf("Parla, a small test language just because I can\n");
  printf("Version: %d.%d.%d - Marcelo Castellani (c) - 2013\n\n", MAJOR_VERSION, MINOR_VERSION, REVISION_VERSION);
  yyparse();

  return 0;
}

void yyerror(char *s) {
  printf("%s\n ->> %s", s, s);
}
