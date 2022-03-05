%{ // Description of Area
	#include <ctype.h>
	#include <string.h>
	#include <stdlib.h>
	#include <stdio.h>
	
	int m = 0,n = 0;   // Counters
%} 

%% //Rules of Area
"\"" {
static int  temporary = 0;		//used to track open curly braces and turn off curly braces tracking
if(temporary == 0){printf("OP_OC\n"); 	temporary = 1;}else{printf("OP_CC\n");temporary = 0;}}

and|or|not|equal|less|nil|list|append|concat|set|deffun|for|if|exit|load|disp|true|false {  //keywords 

int iterator = 0;
while(yytext[iterator ]){ yytext[iterator] = (toupper(yytext[iterator])); iterator++;}
printf("KW_%s\n",yytext);}

"+" {printf("OP_PLUS\n");} // operators of our Flex language
"-" {printf("OP_MINUS\n");}
"/" {printf("OP_DIV\n");}
"*" {printf("OP_MULT\n");}
"(" {printf("OP_OP\n");}
")" {printf("OP_CP\n");}
"**" {printf("OP_DBLMULT\n");}

"," {printf("OP_COMMA\n");}

"0" {printf("VALUE\n");}



[-]*[1-9]*[0-9]+ {printf("VALUE\n");}  //if given input is a number program write VALUE

[a-zA-Z_][a-zA-Z0-9_]* {printf("IDENTIFIER\n");}//if given input starts a letter and then continue letter or number program write IDENTIFIER

[0-9]*+[a-zA-Z_]*  {printf("SYNTAX ERROR \n");}  //if given input starts a number and a letter program write a error message
{}

[ \t\n]+ // ignores white spaces

";;".*$ {printf("COMMENT\n");}//detects comments

"(exit)".*$ {exit(0); }
%% 

// CODE PART >>>>
int yywrap(){} 

void gppinterpreter(){
	
	FILE *f_POINTER;
	char *f_NAME,*LINE,*Str;
	
	f_NAME = (char*) malloc(sizeof(char));
	Str = (char*) malloc(sizeof(char));


	scanf("%c",&Str[m]);//get command if interpreter gets code from file from terminal. 
	
	while(Str[m] !='\n'){
		if(Str[m] != ' ' && Str[m] != '$' && Str[m] != 'g' && Str[m] != '+'){
			f_NAME[n] = Str[m];
			n++;
		}
		m++;
		scanf("%c",&Str[m]);
	}
	if(Str[4] =='\n'){;// if interpreter gets inputs from terminal
		
		printf("> ");
		yylex();
		free(LINE);
	}
	else{;// Get input from .txt files
		
		printf(">\n");
		f_POINTER = fopen(f_NAME,"r");
		yyin = f_POINTER;
		yylex();
		free(f_NAME);
	}
	
	free(Str);
	fclose(f_POINTER);
}
int main(){ 
	;// Calling the Function
	gppinterpreter();
	return 0; 
}