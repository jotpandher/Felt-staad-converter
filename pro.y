%{
#include <cstdio>
#include <iostream>
#include <fstream>
#include <ctime>
#include "write.h"
using namespace std;

extern "C" int yylex ();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s);
#define YYDEBUG 1
Write_function fn;
ofstream fout;
%}

%union{
	
	float f;
	char* s;
}

%token <s> line1 line2 line3 xnodes ynodes;

%%

FELT:/*empty*/
	FELT xnodes	{ fout <<"JOINT COORDINATES" << endl; }
	| FELT ynodes	{ fout << "MEMBER INCIDENTS" << endl; }
	| FELT line1	{ fout << ""; }
	| FELT line2	{ fout << ""; }
	| FELT line3 	{ fout << ""; }
	| xnodes	{ fout <<"JOINT COORDINATES" << endl; }
	| ynodes	{ fout << "MEMBER INCIDENTS" << endl; }
	| line1		{ fout << ""<<endl; }
	| line2		{ fout << "" <<endl; }
	| line3		{ fout << ""<< endl; }
	;	
%%

main()
{	string file_name, input_file, input_text;

	 FILE *text= fopen("beam.flt", "r");
 	if (!text) {
		cout << "I can't open this file" << endl;
		return -1;
	}
	time_t now = time(0);
	char* dt = ctime(&now);

        yyin = text; //flex reads its input from yyin

/*	while(1)
	{
		input_text = fgetc(yyin);
		if( feof(yyin) )
		{
			break;
		}
		cout << input_text;
	}
*/	
	fn.write_function();
	fout.open("staad_file.std", std::ofstream::out);
	fout << "STAAD SPACE\nSTART JOB INFORMATION\nENGINEER DATE "<<dt<<"END JOB INFORMATION\nINPUT WIDTH 79\nUNIT METER KN"<<endl;
	do{
	 yyparse(); //This function reads tokens, executes actions, and 
		    //ultimately returns when it encounters end-of-input or an unrecoverable syntax.

	} while (!feof(yyin));


// 	fn.writeFeltFile("nodes");

}

void yyerror(const char *s) {
cout << "Parser error! Message: " << s << endl;
	exit(-1);
}


