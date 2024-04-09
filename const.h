#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern FILE *yyout;
extern int lineno;
extern const int MAX_VARIABLE_LENGTH;

const int REG_RAX             = 0;
const int REG_RBX             = 1;
const int REG_RCX             = 2;
const int REG_RDX             = 3;
const int REG_REX             = 4;
const int REG_RFX             = 5;
