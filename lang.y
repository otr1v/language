
%{
#include "const.h"

int yylex();
void yyerror(char *s);

int num_of_vars = 0;
int idx = -1;
int counter_of_labels = 0;
int counter_of_labels_cycle = -1;

struct variable_struct
		{
			char* var_name;
			int var_type;       // not used yet
			int ival;           // not used yet
		}variable[500]; // 500 is max amount of variables



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
    switch(index)
    {
        case 0:         // == REG_RAX
            printf("rax\n");
            break;
        case 1:         // == REG_RBX
            printf("rbx\n");
            break;
        case 2:         // == REG_RCX
            printf("rcx\n");
            break;
        case 3:         // == REG_RDX
            printf("rdx\n");
            break;
        case 4:         // == REG_REX
            printf("rex\n");
            break;
        case 5:         // == REG_RFX
            printf("rfx\n");
            break;
        default:
            printf("no reg found");
            break;
    }
}

%}

%token TYPE VARYABLE NUM SEMICOLON ADD MUL SUB DIV EOL MAIN IF EQUALS LETMESEE NOT_EQUALS WHILE END CURLYOB CURLYCB CIRCLEOB CIRCLECB
%token ASSIGN MORE LESS ELIF ELSE 

%type <name> VARYABLE SEMICOLON TYPE ADD MUL SUB DIV EOL MAIN IF EQUALS LETMESEE NOT_EQUALS WHILE END CURLYOB CURLYCB CIRCLEOB CIRCLECB ASSIGN MORE LESS ELIF ELSE
%type <number> NUM 

%union{
    int number;
	char* name;
}

%%


program: { printf("ASM 2\n");}
| program mainfunc {}
;  

mainfunc: MAIN CURLYOB commands CURLYCB
{
    printf("out \nhlt\n");
}
;

commands:
|    declaration commands{}
|   condition commands{}
|   loop commands{}         
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
        printf("pop ");
        PrintReg(num_of_vars - 1);

    }
;

condition:
    IF CIRCLEOB bool_exp CIRCLECB CURLYOB commands CURLYCB
    {
        printf(":%d\n", counter_of_labels - 1);
    }
    |
    condition CURLYOB commands CURLYCB
;

elif_condition:
    condition ELIF CIRCLEOB bool_exp CIRCLECB CURLYOB commands CURLYCB
;

loop: while CIRCLEOB bool_exp CIRCLECB CURLYOB commands end_cycle CURLYCB 
    {
        printf(":%d\n", counter_of_labels - 1);
    }
;

while: WHILE 
    {
        printf(":%d\n", counter_of_labels_cycle);
        counter_of_labels_cycle--;
    }
end_cycle: END
    {
        printf("push 1\npush 0\n");     // this is for unconditional jump
        printf("je :%d\n", counter_of_labels_cycle + 1);
    }
bool_exp:
    VARYABLE EQUALS VARYABLE    
    {
        idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
        idx = FindVar($3);
        printf("push ");
        PrintReg(idx);
        printf("je :%d\n", counter_of_labels++);
    }
|   VARYABLE NOT_EQUALS VARYABLE
    {
        idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
        idx = FindVar($3);
        printf("push ");
        PrintReg(idx);
        printf("jne :%d\n", counter_of_labels++);       
    }
|   VARYABLE MORE VARYABLE
    {
    idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
        idx = FindVar($3);
        printf("push ");
        PrintReg(idx);
        printf("ja :%d\n", counter_of_labels++);
    }
|   VARYABLE LESS VARYABLE
    {
        idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
        idx = FindVar($3);
        printf("push ");
        PrintReg(idx);
        printf("jb :%d\n", counter_of_labels++);
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
        printf("pop ");
        PrintReg(idx);   
    }
    
;


exp:
    NUM
    {
       
       printf("push %d\n", $1);
    }
    |
    VARYABLE
    {
        idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
    }
    |
    NUM ADD NUM
    {
        printf("push %d\npush %d\nADD\n", $1, $3);
    }
    |
    VARYABLE ADD NUM
    {
        idx = FindVar($1);
        printf("push ");
        PrintReg(idx);
        printf("push %d\nADD\n", $3);
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
	printf("Syntax Error on line:  %d", lineno);
	
}



int main()
{
    yyout = freopen("out.txt","w",stdout);
    yyparse();
}
