%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex() /** declearative block*/
#include "parser.tab.h"

%}
/**tokens as input */
space		[[:space:]]
digit		[0-9]+
integer		{digit}
float		{integer}"."{digit}*
endl		[\r]*[\n]*
jc		(JOINT{space}COORDINATES{endl})
mi		(MEMBER{space}INCIDENCES{endl})
semicolon	[;]
finish		(FINISH)

month           Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec
date            ({digit}-{month}-{digit})
width           (WIDTH{space}{digit})

%%
[ \t\n]			;     /**ignore space, tab, next line */

{jc}			{ yylval.c = strdup (yytext); return JC; }   /** yylval = value reading 
									* strdup = string duplicate function
										*/

{mi}			{ yylval.c = strdup (yytext); return MI; }

{integer}|{float}	{ yylval.f = atof (yytext); return DIGIT; }

{width}									/** use of tokens */

{date}			{ yylval.c = strdup (yytext); return DESCRIPTION; }

{semicolon}		{ return SEMICOLON; }

{finish}		{ return FINISH; }

.			;				/** any digit except new line */

