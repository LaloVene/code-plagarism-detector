%{
#include "y.tab.h"
%}

%%
[ \t]+                  ; /* ignore whitespace */
"#include"          { return INCLUDE; }
"if"                { return IF; }
"else"              { return ELSE; }
"for"               { return FOR; }
"while"             { return WHILE; }
"switch"            { return SWITCH; }
"case"              { return CASE; }
"default"           { return DEFAULT; }
"printf"            { return PRINT; }
"int"               { return DECLARATION; }
"char"              { return DECLARATION; }
"double"            { return DECLARATION; }
"float"             { return DECLARATION; }
"void"              { return DECLARATION; }
"return"            { return RETURN; }
"="                 { return ASSIGN; }
"++"                { return INCREMENT; }
"--"                { return DECREMENT; }
"=="                { return EQ; }
"!="                { return NEQ; }
"<"                 { return LT; }
"<="                { return LEQ; }
">"                 { return GT; }
">="                { return GEQ; }
"&&"                { return AND; }
"||"                { return OR; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
";"                 { return SEMICOLON; }
":"                 { return COLON; }
","                 { return COMMA; }
\".*\"              {return STRING; }
[a-zA-Z_][a-zA-Z0-9_]*  {return IDENTIFIER; }
[0-9]+              {return INTEGER_LITERAL; }
[ \t\n]+            ; // Ignore whitespace
.                   ; /* ignore other characters */

%%

int yywrap(void) {
    return 1;
}
