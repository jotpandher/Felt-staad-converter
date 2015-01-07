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
write fn;
ofstream fout;
%}

%union{
	
	int i;
	float f;
	char* s;
}
%token <i>  serial_no ;
%token <f>  num beamy beamx xnodes ynodes znodes;
%token <s> line1 line2 line3 blank;

%%

FELT:/*empty*/
	FELT xnodes	{ fout << "JOINT COORDINATES"; }
	| FELT ynodes	{ fout << "\nMEMBER INCIDENTS"; }
	| FELT znodes	{ }
	| FELT line1	{ fout << ""; }
	| FELT line2	{ fout << ""; }
	| FELT line3 	{ fout << ""; }
	| FELT num	{ fout << $2<<" ";}
	| FELT serial_no{ fout <<"\n"<<$2<<" ";}
	| FELT beamx	{ fout << $2<<" ";}
	| FELT beamy	{ fout << $2 << "; "; }
	| FELT blank	{ fout << ""; }
	| xnodes	{ fout <<"JOINT COORDINATES"; }
	| ynodes	{ fout <<"\nMEMBER INCIDENTS"; }
	| znodes	{ }
	| line1		{ fout << ""<<endl; }
	| line2		{ fout << "" <<endl; }
	| line3		{ fout << ""<< endl; }
	| num		{ fout << $1<<" "; }
	| serial_no	{ fout <<"\n"<<$1<<" "; }
	| beamx		{ fout << $1; }
	| beamy		{ fout << $1 << ";\n"; }
	| blank		{ fout <<""; }
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


