%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
FILE* yyin;
FILE *outputFile;
%}

%union {
    int ival;
    char *sval;
}

%token <sval> IF ELSE FOR WHILE SWITCH CASE DEFAULT EQ NEQ LT LEQ GT GEQ AND OR LBRACE RBRACE LPAREN RPAREN SEMICOLON COLON COMMA IDENTIFIER INTEGER_LITERAL

%type <sval> expression variable constant initialization condition update

%%

instructions:
    | instructions instruction
;

instruction:
    | IF LPAREN expression RPAREN block { fprintf(outputFile, "IF statement\n"); }
    | FOR LPAREN initialization SEMICOLON condition SEMICOLON update RPAREN block { fprintf(outputFile, "FOR loop\n"); }
    | WHILE LPAREN condition RPAREN block { fprintf(outputFile, "WHILE loop\n"); }
    | SWITCH LPAREN expression RPAREN switch_block { fprintf(outputFile, "SWITCH statement\n"); }
    | other_statement           { fprintf(outputFile, "Other statement\n"); }
    | error                     { fprintf(outputFile, "Invalid statement\n"); }
;

block:
    LBRACE statement_list RBRACE

statement_list:
    statement
    | statement statement_list
;

statement:
    if_statement
    | for_loop
    | while_loop  { fprintf(outputFile, "WHILE loop\n"); }
    | switch_statement
    | other_statement
;

if_statement:
    IF LPAREN expression RPAREN block
    | IF LPAREN expression RPAREN block ELSE block
;

for_loop:
    FOR LPAREN initialization SEMICOLON condition SEMICOLON update RPAREN block
;

while_loop:
    WHILE LPAREN condition RPAREN block
;

switch_statement:
    SWITCH LPAREN expression RPAREN switch_block
;

switch_block:
    LBRACE case_list RBRACE
;

case_list:
    case_statement
    | case_statement case_list
;

case_statement:
    CASE constant COLON statement_list
    | DEFAULT COLON statement_list
;

other_statement:
    SEMICOLON
    | expression SEMICOLON
    | IDENTIFIER COLON statement
;

initialization:
    expression
;

condition:
    expression
;

update:
    expression
;

expression:
    variable relational_operator variable
    | variable relational_operator constant
    | constant relational_operator variable
    | constant relational_operator constant
    | expression logical_operator expression
    | LPAREN expression RPAREN
    | variable
    | constant
;

variable:
    IDENTIFIER
;

constant:
    INTEGER_LITERAL
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
        fprintf(stderr, "Usage: ./c_compiler filename\n");
        return 1;
    }

    outputFile = fopen("result.txt", "w");

    yyin = inputFile;
    yyparse();
    fclose(inputFile);
    fclose(outputFile);
    
    return 0;
}
