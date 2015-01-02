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
text			[a-zA-Z]+
beamx			(nodes=)\[{digits}+
beamy			[,]{digits}+

%%

[ \n] 				
{beamx}				{ yylval.f = splitbeamx(yytext); return beamx; }

{beamy}                         { yylval.f = splitbeamy(yytext); return beamy; }

problem\ description		{ yylval.s = (yytext); return line1; }

^nodes=[a-zA-Z0-9]*\n$		{ yylval.s = (yytext); return line3; }

^nodes\ *			{ yylval.s = (yytext); return xnodes; }

^beam\ elements  		{ yylval.s = (yytext); return ynodes; }

^[0-9]+				{ yylval.i = atoi(yytext); return serial_no; }

[a-zA-Z]*=[0-9]*		{ yylval.f = splitnode(yytext); return num;}


^title=\"[a-zA-Z0-9]*$\"		{yylval.s = (yytext); return line2; }

.		;

