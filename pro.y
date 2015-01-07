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
%token <i>  jc_count mi_count;
%token <f>  nodes beam_x beam_y;
%token <s>  join_coordinates member_incidences; 

%%

FELT:/*empty*/
	  FELT jc_count			{}
	| FELT mi_count			{cout << $2 << endl;}
	| FELT join_coordinates		{fn.write_join_coordinates($2);;}
	| FELT member_incidences	{cout << $2 << endl;  }
	| FELT nodes			{cout << $2 << endl; }
	| FELT beam_x			{ cout << $2 << endl;}
	| FELT beam_y			{cout << $2 << endl; }
	| jc_count			{}
	| mi_count			{cout << $1 << endl;}
	| join_coordinates		{ fn.write_join_coordinates($1);}
	| member_incidences		{cout << $1 << endl;  }
	| nodes				{cout << $1 << endl; }
	| beam_x			{ cout<< $1 << endl; }
	| beam_y			{cout<< $1 << endl; }
	;	
%%

main()
{	string file_name, input_file, input_text;

	 FILE *text= fopen("beam.flt", "r");
 	if (!text) {
		cout << "I can't open this file" << endl;
		return -1;
	}
//	time_t now = time(0);
//	char* dt = ctime(&now);

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
/*	fout.open("staad_file.std", std::ofstream::out);
	fout << "STAAD SPACE\nSTART JOB INFORMATION\nENGINEER DATE "<<dt<<"END JOB INFORMATION\nINPUT WIDTH 79\nUNIT METER KN"<<endl;*/
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


