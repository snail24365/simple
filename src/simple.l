/***************************************************************************
Scanner for the Simple language
***************************************************************************/
%{
/*=========================================================================
C-libraries and Token definitions
=========================================================================*/
#include <string.h> /* for strdup */
/*#include <stdlib.h> */ /* for atoi */
#include "simple.tab.h" /* for token definitions and yylval */
%}
/*=========================================================================
TOKEN Definitions
=========================================================================*/
DIGIT [0-9]
ID [a-z][a-z0-9]*
/*=========================================================================
REGULAR EXPRESSIONS defining the tokens for the Simple language
=========================================================================*/
%%
":=" { return(ASSGNOP); }
{DIGIT}+ { yylval.intval = atoi( yytext );return(NUMBER); }
do { return(DO); }
else { return(ELSE); }
end { return(END); }
fi { return(FI); }
if { return(IF); }
in { return(IN); }
integer { return(INTEGER); }
let { return(LET); }
read { return(READ); }
skip { return(SKIP); }
then { return(THEN); }
while { return(WHILE); }
write { return(WRITE); }
{ID} { yylval.id = (char *) strdup(yytext);return(IDENTIFIER); }
[ \t\n]+ /* eat up whitespace */{ }
. { return(yytext[0]); }
%%

int yywrap(void){ return 0;}
/************************** End Scanner File */




/***************************************************************************
Symbol Table Module
***************************************************************************/
/*=========================================================================
DECLARATIONS
=========================================================================*/
/*-------------------------------------------------------------------------
SYMBOL TABLE RECORD
-------------------------------------------------------------------------*/
struct symrec
{
char *name; /* name of symbol */
int offset; /* data offset */
struct symrec *next; /* link field */
};
typedef struct symrec symrec;
/*-------------------------------------------------------------------------
SYMBOL TABLE ENTRY
-------------------------------------------------------------------------*/
symrec *identifier;
/*-------------------------------------------------------------------------
SYMBOL TABLE
Implementation: a chain of records.
------------------------------------------------------------------------*/
symrec *sym_table = (symrec *)0; /* The pointer to the Symbol Table */
/*========================================================================
Operations: Putsym, Getsym
========================================================================*/
symrec * putsym (char *sym_name)
{
symrec *ptr;
ptr = (symrec *) malloc (sizeof(symrec));
ptr->name = (char *) malloc (strlen(sym_name)+1);
strcpy (ptr->name,sym_name);
ptr->offset = data_location();
ptr->next = (struct symrec *)sym_table;
sym_table = ptr;
return ptr;
}
symrec * getsym (char *sym_name)
{
symrec *ptr;
for ( ptr = sym_table;
ptr != (symrec *) 0;
ptr = (symrec *)ptr->next )
if (strcmp (ptr->name,sym_name) == 0)
return ptr;
return 0;
}
/************************** End Symbol Table **************************/
