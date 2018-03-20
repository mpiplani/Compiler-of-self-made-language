/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    FLOAT = 259,
    CHAR = 260,
    LONG = 261,
    STRING = 262,
    BOOL = 263,
    FOR = 264,
    WHILE = 265,
    IF = 266,
    ELSE = 267,
    ELSEIF = 268,
    PRINT = 269,
    SCAN = 270,
    BREAK = 271,
    CONTINUE = 272,
    RETURN = 273,
    INCREMENT = 274,
    DECREMENT = 275,
    PLUS = 276,
    MINUS = 277,
    MULTIPLY = 278,
    DIVIDE = 279,
    MODULUS = 280,
    GREATER = 281,
    LESSER = 282,
    GE = 283,
    LE = 284,
    EQUALS = 285,
    NOTEQUALS = 286,
    LOGICAND = 287,
    LOGICOR = 288,
    SIZE = 289,
    ID = 290,
    CONSTANT = 291,
    FUNK = 292,
    NEWLINE = 293
  };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define CHAR 260
#define LONG 261
#define STRING 262
#define BOOL 263
#define FOR 264
#define WHILE 265
#define IF 266
#define ELSE 267
#define ELSEIF 268
#define PRINT 269
#define SCAN 270
#define BREAK 271
#define CONTINUE 272
#define RETURN 273
#define INCREMENT 274
#define DECREMENT 275
#define PLUS 276
#define MINUS 277
#define MULTIPLY 278
#define DIVIDE 279
#define MODULUS 280
#define GREATER 281
#define LESSER 282
#define GE 283
#define LE 284
#define EQUALS 285
#define NOTEQUALS 286
#define LOGICAND 287
#define LOGICOR 288
#define SIZE 289
#define ID 290
#define CONSTANT 291
#define FUNK 292
#define NEWLINE 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
