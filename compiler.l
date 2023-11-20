%{
#include "y.tab.h"
%}

%%
[ \t]+                  ; /* ignore whitespace */
"if"                { return IF; }
"else"              { return ELSE; }
"for"               { return FOR; }
"while"             { return WHILE; }
"switch"            { return SWITCH; }
"case"              { return CASE; }
"default"           { return DEFAULT; }
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
\".*\"   { yylval.sval = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return IDENTIFIER; }
[0-9]+              { yylval.sval = strdup(yytext); return INTEGER_LITERAL; }
[ \t\n]+            ; // Ignore whitespace
.                   ; /* ignore other characters */

%%

int yywrap(void) {
    return 1;
}
