bison -d pro.y
flex pro.l
g++ pro.tab.c lex.yy.c -lfl -o pro
               

