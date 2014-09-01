/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INTEGER = 258,
     FLOAT = 259,
     VARIABLE = 260,
     WHILE = 261,
     IF = 262,
     PRINT = 263,
     EOL = 264,
     INTO = 265,
     LOADTOKEN = 266,
     QUIT = 267,
     INSPECT = 268,
     DEFTOKEN = 269,
     TYPETOKEN = 270,
     BCHAR_TYPE = 271,
     ECHAR_TYPE = 272,
     NUMBER_TYPE = 273,
     VERSION = 274,
     IFX = 275,
     ELSE = 276,
     NE = 277,
     EQ = 278,
     LE = 279,
     GE = 280,
     UMINUS = 281
   };
#endif
/* Tokens.  */
#define INTEGER 258
#define FLOAT 259
#define VARIABLE 260
#define WHILE 261
#define IF 262
#define PRINT 263
#define EOL 264
#define INTO 265
#define LOADTOKEN 266
#define QUIT 267
#define INSPECT 268
#define DEFTOKEN 269
#define TYPETOKEN 270
#define BCHAR_TYPE 271
#define ECHAR_TYPE 272
#define NUMBER_TYPE 273
#define VERSION 274
#define IFX 275
#define ELSE 276
#define NE 277
#define EQ 278
#define LE 279
#define GE 280
#define UMINUS 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 20 "parla.y"
{
    int iValue;                 /* integer value */
    char sIndex;                /* symbol table index */
    nodeType *nPtr;             /* node pointer */
}
/* Line 1529 of yacc.c.  */
#line 107 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

