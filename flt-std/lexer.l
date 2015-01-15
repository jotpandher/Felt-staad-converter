%{
#include <iostream>
#include <string>
#include "write.h"
using namespace std;
#define YY_DECL extern "C" int yylex()		/** decleartion block */

#include "parser.tab.h"

float splitequaloperator( string s )
{
        string delimiter = "=";				/** split function for nodes */
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
        string delimiter = "[";				/** split function for beam x */

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
					/** split function for beam y */
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
/** regular expressions or tokens */
space           [[:space:]]
endl            [\r]*[\n]*
digits		[0-9]+	
float		{digits}*"."{digits}	
nodes		[\t]*(=){digits}
beamx		(nodes=)\[{digits}
beamy		[,]{digits}
jc_count	(nodes)(=){digits}
mi_count	(elements=){digits}

%%

[ \n\t]				/** ignore space, line and tab */

{jc_count}			{ yylval.i = splitequaloperator(yytext); return jc_count;}	/** define tokens */


{mi_count}			{ yylval.i = splitequaloperator(yytext); return mi_count;}	/** yylval function for input value */
 				
^(nodes){endl}			{ yylval.s = strdup(yytext); return joint_coordinates; }
												/** strdup string duplicate function */
^(beam{space}elements){endl}	{ yylval.s = strdup(yytext); return member_incidences; }

x{nodes}                        { yylval.f = splitequaloperator(yytext); return x_nodes; }

y{nodes}                        { yylval.f = splitequaloperator(yytext); return y_nodes; }

z{nodes}			{ yylval.f = splitequaloperator(yytext); return z_nodes; }

{beamx}				{ yylval.f = splitbeamx(yytext); return beam_x; }

{beamy}                         { yylval.f = splitbeamy(yytext); return beam_y; }

end				{ return end; }

.		;				/** any character other than new line */

