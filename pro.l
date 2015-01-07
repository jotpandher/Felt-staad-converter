%{
#include <iostream>
#include <string>
#include "write.h"
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "pro.tab.h"

float splitnode( string s )
{
        string delimiter = "=";
	float t;
        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        t = atof(s.c_str());
        return t;
}
float splitbeamx( string s )
{
        string delimiter = "[";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

float splitbeamy( string s )
{
        string delimiter = ",";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos+delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

%}

digits			[0-9]+	
float			{digits}*"."{digits}	
nodes			[\t]*(=){digits}+
beamx			(nodes=)\[{digits}+
beamy			[,]{digits}+
jc_count		(nodes=){digits}+
mi_count		(beam=){digits}+

%%

[ \n]

jc_count			{ yylval.i = splitnode(yytext);	return jc_count;}

mi_count			{ yylval.i = splitnode(yytext);	return mi_count;}
 				
^nodes\ *			{ yylval.s = (yytext); return join_coordinates; }

^beam\ elements  		{ yylval.s = (yytext); return member_incidences; }

z{nodes}      		{ yylval.f = splitnode(yytext); return znodes; }

problem\ description	{ yylval.s = (yytext); return line1; }

^nodes=[a-zA-Z0-9]*\n$	{ yylval.s = (yytext); return line3; }

^[0-9]+			{ yylval.i = atoi(yytext); return serial_no; }

[a-zA-Z]*=[0-9]*	{ yylval.f = splitnode(yytext); return num;}

^title=\"[a-zA-Z0-9]*$\" {yylval.s = (yytext); return line2; }

.		;

