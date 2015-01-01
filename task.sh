bison -d pro.y
flex pro.l
g++ write.cpp pro.tab.c lex.yy.c -lfl -o pro 
               

