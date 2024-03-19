%{
#include <stdio.h>
#include <stdbool.h>
#include "y.tab.h"
const int MAX_VARIABLE_LENGTH = 32;


int number_of_vars = 0;
%}

NUM ([0-9])+

%%

"main"                 {  return MAIN;}
{NUM}              { yylval.number = atoi(yytext); printf("numdd");return (NUM); }
"int"                  {return TYPE;}
"char"                 {return TYPE;}
"if"                   { return IF;}
"elif"                  {return ELIF;}
"else"                  {return ELSE;}
"for"                  { return FOR;}
"!="                   { return NOT_EQUALS;}
"letmesee"             { return LETMESEE;}      //printf

[a-zA-Z][a-zA-Z0-9]*   { yylval.name = strdup(yytext);
                         return (VARYABLE); }   // variable

"=="                   { return EQUALS;}
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
[ \n]    {}        
"--"[a-zA-Z()0-9\\ * / - + \"]*[\nEOF] {}     // comment
.    {printf("%s\n", yytext);}  ;   
%%

yywrap()
{

}


  
  
