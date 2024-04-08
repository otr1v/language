%{
#include <stdio.h>
#include <stdbool.h>
#include "y.tab.h"
const int MAX_VARIABLE_LENGTH = 32;
int lineno = 0;

int number_of_vars = 0;
%}

NUM ([0-9])+

%%

"main"                 {  return MAIN;}
{NUM}              { yylval.number = atoi(yytext); return (NUM); }
"int"                  {return TYPE;}
"char"                 {return TYPE;}
"if"                   { return IF;}
"elif"                  {return ELIF;}
"else"                  {return ELSE;}
"end"                    {return END;}
"while"                  { return WHILE;}
"!="                   { return NOT_EQUALS;}
"letmesee"             { return LETMESEE;}      //printf

[a-zA-Z][a-zA-Z0-9]*   { yylval.name = strdup(yytext);
                         return (VARYABLE); }   // variable

"=="                   { return EQUALS;}
">"                     {return MORE;}
"!="                     {return NOT_EQUALS;}
"<"                     {return LESS;}
"+"                    { return ADD; }
"-"                    { return SUB; }
"*"                    { return MUL; }
"/"                    { return DIV; }
";"                    { return SEMICOLON;}
"{"                     { return CURLYOB;}
"}"                     {return CURLYCB;}
"("                     {return CIRCLEOB;}
")"                   {return CIRCLECB;}
"="                   {return ASSIGN;}
[ \t]    {}
[ \n]    {lineno++;}        
"--"[a-zA-Z()0-9\\ * / - + \"]*[\nEOF] {}     // comment
.    {printf("%s\n", yytext);}  ;   
%%

yywrap()
{

}


  
  

