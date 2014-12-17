%{
#include "write.h"
#include <cstdio>
#include<iostream>
#include <fstream>
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1
%}

%union{
	
	float xnodes;
	float ynodes;
	float znodes;
	float beamx;
	float beamy;
}

%token <xnodes> xnodes;
%token <ynodes> ynodes;
%token <znodes> znodes;
%token  <beamx> beamx;
%token <beamy> beamy;

%%

FELT:/*empty*/
	|FELT xnodes {cout<<$2<<endl; }
	| FELT ynodes { cout<<$2<<endl; }
	| FELT znodes { cout<<$2<<endl;}
	| FELT beamx  { cout<< $2<<endl;}
	| FELT beamy  {cout <<$2 <<endl;}
	| xnodes  {cout<<$1<<endl;}
	| ynodes        { cout<<$1<<endl;}
	| znodes {cout<<$1<<endl;}
	|beamx{ cout<<$1<<endl;}
	|beamy { cout<< $1<<endl;}

%%

main()
{	string file_name, input_file;
	cout<<" Enter the name of input file:\n";
	cin>>file_name;

	 FILE *text= fopen(input_file.c_str(), "r");
 	if (!text) {
		cout << "I can't open this file" << endl;
		return -1;
	}

        yyin = text; 


	do{

//	yydebug = 1;

	yyparse();
	} while (!feof(yyin));

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}


