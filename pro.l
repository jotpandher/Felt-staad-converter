%{
#include <iostream>
#include <string>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "pro.tab.h"
float splitnodex( string s )
{
	string delimiter = "= ";

	size_t pos = 0;
	while ((pos = s.find(delimiter)) != string::npos)
	{
    		s.erase(0, pos + delimiter.length());
	}
	float t;
	t = atof(s.c_str());
	return t;
}
float splitnodey( string s )
{
        string delimiter = "= ";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

float splitnodez( string s )
{
        string delimiter = "= ";

        size_t pos = 0;
        while ((pos = s.find(delimiter)) != string::npos)
        {
                s.erase(0, pos + delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

float splitbeamx( string s )
{
        string delimiter = "[ ";

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
                s.erase(0, pos + delimiter.length());
        }
        float t;
        t = atof(s.c_str());
        return t;
}

%}

digits			[0-9]+	
float			{digits}*"."{digits}	
text			[a-zA-Z]+
nodes			[\t]*[=]+{digits}
beamx			[=]+[[]+{digits}+
beamy			[\n]*[,]+{digits}+[]]

%%

[ \n]

x{nodes}+	{ yylval.xnodes = splitnodex(yytext);
			return xnodes; }
y{nodes}+	{yylval.ynodes = splitnodey(yytext);
			return ynodes; }
z{nodes}+	{yylval.znodes = splitnodez(yytext);
			return znodes; }
{beamx}+	{yylval.beamx = splitbeamx(yytext);
			return beamx; }
{beamy}+	{yylval.beamy = splitbeamy(yytext);
			return beamy; }
.		;

