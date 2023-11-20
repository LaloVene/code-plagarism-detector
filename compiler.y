%{
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(const char *s);
FILE* yyin;
FILE *outputFile;
%}

%union {
    int ival;
    char *sval;
}

%token <sval> IF ELSE FOR WHILE SWITCH CASE DEFAULT EQ NEQ LT LEQ GT GEQ AND OR LBRACE RBRACE LPAREN RPAREN SEMICOLON COLON COMMA IDENTIFIER INTEGER_LITERAL STRING ASSIGN INCREMENT DECREMENT INCLUDE PRINT DECLARATION RETURN

%type <sval> expression function_call

%%

instructions:
    | instructions instruction
;

instruction:
    | INCLUDE { fprintf(outputFile, "INCLUDE\n"); }
    | PRINT { fprintf(outputFile, "PRINT\n"); }
    | DECLARATION expression { fprintf(outputFile, "DECLARATION\n"); }
    | RETURN expression { fprintf(outputFile, "RETURN\n"); }
    | IF LPAREN expression RPAREN { fprintf(outputFile, "IF\n"); }
    | ELSE { fprintf(outputFile, "ELSE\n"); }
    | FOR LPAREN expression SEMICOLON expression SEMICOLON expression RPAREN { fprintf(outputFile, "FOR\n"); }
    | WHILE LPAREN expression RPAREN { fprintf(outputFile, "WHILE\n"); }
    | SWITCH LPAREN expression RPAREN { fprintf(outputFile, "SWITCH\n"); }
    | function_call          { fprintf(outputFile, "FUN\n"); }
    | error
;


function_call:
    IDENTIFIER LPAREN fgets_arguments RPAREN
;

fgets_arguments:
    | expression COMMA expression COMMA expression COMMA expression
    | expression COMMA expression COMMA expression
    | expression COMMA expression
    | expression
;

expression:
    | relational_variable logical_operator relational_variable
    | relational_variable relational_operator relational_variable
    | relational_variable ASSIGN relational_variable { fprintf(outputFile, "ASSIGN\n"); }
    | relational_variable INCREMENT
    | relational_variable DECREMENT
    | LPAREN expression RPAREN
    | IDENTIFIER
    | function_call
    | INTEGER_LITERAL
    | STRING
;

relational_variable:
    IDENTIFIER | function_call | INTEGER_LITERAL | STRING
;

relational_operator:
    EQ | NEQ | LT | LEQ | GT | GEQ
;

logical_operator:
    AND | OR
;

%%

int yylex(void);
void yyerror(const char *s);

int main(int argc, char **argv) {

    FILE *inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        fprintf(stderr, "Usage: ./c_compiler input output\n");
        return 1;
    }

    outputFile = fopen(argv[2], "w");

    yyin = inputFile;
    yyparse();
    fclose(inputFile);
    fclose(outputFile);
    
    return 0;
}
