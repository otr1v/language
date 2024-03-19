
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex();
void yyerror(char *s);

int num_of_vars = 0;
int idx = -1;
int counter_of_labels = 0;
extern const int MAX_VARIABLE_LENGTH;
const int REG_RAX             = 0;
const int REG_RBX             = 1;
const int REG_RCX             = 2;
const int REG_RDX             = 3;
const int REG_REX             = 4;
const int REG_RFX             = 5;

struct variable_struct
		{
			char* var_name;
			int var_type;       // not used yet
			int ival;           // not used yet
		}variable[500]; 



int FindVar(char* var)
{
    for (int i = 0; i < num_of_vars; i++)
    {
        if (strcmp(variable[i].var_name, var) == 0)
        {
            return i;
        }
    }
}


void PrintReg(int index)
{
    FILE* out = fopen("bisonout.txt", "a+");
    if (idx == REG_RAX)
    {
        fprintf(out, "rax\n");
    }
    else if (idx == REG_RBX)
    {
        fprintf(out, "rbx\n");
    }
    else if (idx == REG_RCX)
    {
        fprintf(out, "rcx\n");
    }
    else if (idx == REG_RDX)
    {
        fprintf(out, "rdx\n");
    }
    else if (idx == REG_REX)
    {
        fprintf(out, "rex\n");
    }
    else if (idx == REG_RFX)
    {
        fprintf(out, "rfx\n");
    }
    fclose(out);
}

%}

%token TYPE VARYABLE NUM SEMICOLON ADD MUL SUB DIV EOL MAIN IF EQUALS LETMESEE NOT_EQUALS FOR CURLYOB CURLYCB CIRCLEOB CIRCLECB
%token ASSIGN MORE LESS ELIF ELSE 

%type <name> VARYABLE SEMICOLON TYPE ADD MUL SUB DIV EOL MAIN IF EQUALS LETMESEE NOT_EQUALS FOR CURLYOB CURLYCB CIRCLEOB CIRCLECB ASSIGN MORE LESS ELIF ELSE
%type <number> NUM 

%union{
    long number;
	char* name;
}

%%

program: {FILE* out = fopen("bisonout.txt", "a+"); fprintf(out, "ASM 2\n"); fclose(out);}
| program mainfunc 
;  

mainfunc: MAIN CURLYOB commands CURLYCB
{
    
}
;

commands:
|    declaration commands{}
|   condition commands{}
|   loop commands{}         //cant work yet
|   print commands{}
|   assignmemt commands{}
|   elif_condition commands{}       // cant work yet
;

declaration:
    TYPE VARYABLE SEMICOLON
    {
        variable[num_of_vars].var_name = calloc(MAX_VARIABLE_LENGTH, sizeof(char));
        variable[num_of_vars++].var_name = strdup($2);
        
    }
    |
    TYPE VARYABLE ASSIGN exp SEMICOLON
    {
        variable[num_of_vars].var_name = calloc(MAX_VARIABLE_LENGTH, sizeof(char));
        variable[num_of_vars++].var_name = strdup($2);
        FILE* out = fopen("bisonout.txt", "a+");
        fprintf(out, "pop ");
        fclose(out);
        PrintReg(num_of_vars - 1);

    }
;

condition:
    IF CIRCLEOB bool_exp CIRCLECB CURLYOB commands CURLYCB
    {
        FILE* out = fopen("bisonout.txt", "a+");
        fprintf(out, ":%d\n", counter_of_labels - 1);
        fclose(out);
    }
    |
    condition CURLYOB commands CURLYCB
;

elif_condition:
    condition ELIF CIRCLEOB bool_exp CIRCLECB CURLYOB commands CURLYCB
;


bool_exp:
    VARYABLE EQUALS VARYABLE    
    {
        FILE* out = fopen("bisonout.txt", "a+");
        idx = FindVar($1);
        fprintf(out, "push ");
        fclose(out);
        PrintReg(idx);
        out = fopen("bisonout.txt", "a+");
        idx = FindVar($3);
        fprintf(out, "push ");
        fclose(out);
        PrintReg(idx);
        out = fopen("bisonout.txt", "a+");
        fprintf(out, "je :%d\n", counter_of_labels++);
        fclose(out); 
    }
|   VARYABLE NOT_EQUALS VARYABLE
    {
        
    }
|   VARYABLE MORE VARYABLE
    {

    }
|   VARYABLE LESS VARYABLE
    {

    }
;

loop: FOR CIRCLEOB assignmemt SEMICOLON bool_exp SEMICOLON assignmemt CIRCLECB CURLYOB commands CURLYCB
    {
        
    }
;

print: LETMESEE CIRCLEOB VARYABLE CIRCLECB SEMICOLON
    {

    }

;

assignmemt:
    VARYABLE ASSIGN exp SEMICOLON
    {
        idx = FindVar($1);
        FILE* out = fopen("bisonout.txt", "a+");
        fprintf(out, "pop ");
        fclose(out);
        PrintReg(idx);   
    }
    
;


exp:
    NUM
    {
       
       FILE* bisonout = fopen("bisonout.txt", "a+");
       fprintf(bisonout, "push %d\n", $1);
       fclose(bisonout);
    }
    |
    VARYABLE
    {
        idx = FindVar($1);
        FILE* bisonout = fopen("bisonout.txt", "a+");
        fprintf(bisonout, "push ");
        fclose(bisonout);
        PrintReg(idx);
        bisonout = fopen("bisonout.txt", "a+");
        fclose(bisonout);
    }
    |
    NUM ADD NUM
    {
        FILE* out = fopen("bisonout.txt", "a+");
        fprintf(out, "push %d\npush %d\nADD\n", $1, $3);
        fclose(out);
    }
    |
    VARYABLE ADD NUM
    {
        idx = FindVar($1);
        FILE* bisonout = fopen("bisonout.txt", "a+");
        fprintf(bisonout, "push ");
        printf("INDEX %d", idx);
        fclose(bisonout);
        PrintReg(idx);
        bisonout = fopen("bisonout.txt", "a+");
        fprintf(bisonout, "push %d\nADD\n", $3);
        fclose(bisonout);
    }
    |
    VARYABLE SUB NUM
    |
    VARYABLE MUL NUM
    |
    VARYABLE DIV NUM
    |
    VARYABLE ADD VARYABLE
    |
    VARYABLE SUB VARYABLE
    |
    VARYABLE MUL VARYABLE
    |
    VARYABLE DIV VARYABLE


%%

void yyerror(char *s)
{
	printf("Syntax Error \n");
	
}



int main()
{
    yyparse();
}
