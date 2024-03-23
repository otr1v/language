/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    TYPE = 258,                    /* TYPE  */
    VARYABLE = 259,                /* VARYABLE  */
    NUM = 260,                     /* NUM  */
    SEMICOLON = 261,               /* SEMICOLON  */
    ADD = 262,                     /* ADD  */
    MUL = 263,                     /* MUL  */
    SUB = 264,                     /* SUB  */
    DIV = 265,                     /* DIV  */
    EOL = 266,                     /* EOL  */
    MAIN = 267,                    /* MAIN  */
    IF = 268,                      /* IF  */
    EQUALS = 269,                  /* EQUALS  */
    LETMESEE = 270,                /* LETMESEE  */
    NOT_EQUALS = 271,              /* NOT_EQUALS  */
    FOR = 272,                     /* FOR  */
    CURLYOB = 273,                 /* CURLYOB  */
    CURLYCB = 274,                 /* CURLYCB  */
    CIRCLEOB = 275,                /* CIRCLEOB  */
    CIRCLECB = 276,                /* CIRCLECB  */
    ASSIGN = 277,                  /* ASSIGN  */
    MORE = 278,                    /* MORE  */
    LESS = 279,                    /* LESS  */
    ELIF = 280,                    /* ELIF  */
    ELSE = 281                     /* ELSE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define TYPE 258
#define VARYABLE 259
#define NUM 260
#define SEMICOLON 261
#define ADD 262
#define MUL 263
#define SUB 264
#define DIV 265
#define EOL 266
#define MAIN 267
#define IF 268
#define EQUALS 269
#define LETMESEE 270
#define NOT_EQUALS 271
#define FOR 272
#define CURLYOB 273
#define CURLYCB 274
#define CIRCLEOB 275
#define CIRCLECB 276
#define ASSIGN 277
#define MORE 278
#define LESS 279
#define ELIF 280
#define ELSE 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 102 "lang.y"

    int number;
	char* name;

#line 124 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
