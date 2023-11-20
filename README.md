# Code Plagarism Detector

Checklist for the project

- [ ] Detect Variable declarations
- [ ] Detect Variable assignments
- [ ] Detect Function declarations
- [ ] Detect Function calls
- [ ] Detect If statements
- [ ] Detect For loops
- [ ] Detect While loops
- [ ] Detect Switch statements

### ML Stuff

- [ ] Train a model to detect plagarism

### How to run

yacc -d compiler.y && lex compiler.l && gcc y.tab.c lex.yy.c -ly -ll -o c_compiler
./c_compiler < test.c
