%language "C++"
%require "3.2"
%define api.value.type variant

%token <std::string> OP_PLUS "+"
%token <std::string> OP_SUB "-"
%token <std::string> OP_MULT "*"
%token <std::string> OP_DIVIDE "/"
%token <std::string> OP_MODULE "%"
%token <std::string> EQUAL_TO "=="
%token <std::string> NOT_EQUAL "!="
%token <std::string> LESS_THAN "<"
%token <std::string> LESS_EQUAL "<="
%token <std::string> GREATER_THAN ">"
%token <std::string> GREATER_EQUAL ">="
%token <std::string> LOGIC_AND "&&"
%token <std::string> LOGIC_OR "||"
%token <std::string> LOGIC_NOT "!"
%token <std::string> ASSIGN "="
%token SEMICOLON ";"
%token COMMA ","
%token LEFT_BRACKET "{"
%token RIGHT_BRACKET "}"
%token <std::string>  OPEN_PAR "("
%token <std::string> CLOSE_PAR ")"
%token COMMENT "//"
%token <long> NUMBER 
%token <std::string> IDENTIFIER 
%token <std::string> INT_KEY 
%token <std::string> VOID_KEY 
%token <std::string> IF_KEY 
%token <std::string> ELSE_KEY 
%token <std::string> WHILE_KEY 
%token <std::string> PRINT_KEY 
%token <std::string> DEF_KEY 
%token <std::string> RETURN_KEY 
%token <std::string> REF_KEY 
%token <std::string> ARROW 

%define parse.error verbose
%define api.namespace {Expr}
%define api.parser.class {Parser}

%parse-param {ProyectoLexer& lexer}
%parse-param {AstNode*& root}

%code requires{

    namespace Expr
    {
         class ProyectoLexer;
    }
}

%{
#include <string>
#include "Parser.hpp"
#include "Lexer.hpp"
#include <iostream>

namespace Expr{
    void Parser::error(const std::string& msg){
        throw syntax_error(msg);
    }
}

#define yylex(p) lexer.nextToken(p)

%}


%%

program: declare_list {root = new Program($1);};
declare_list: {$$ =nullptr;}| declare_list declaration {$$ = $1 + $2;};
declaration: varDecl {$$ = $1;}| funcDecl {$$ = $1;};
varDecl: INT_KEY IDENTIFIER SEMICOLON {$$ = new VarDecl($2);}| 
         INT_KEY IDENTIFIER ASSIGN expr SEMICOLON
         { $$ = new VarDecl($2, $4);};
funcDecl: DEF_KEY IDENTIFIER OPEN_PAR optionParam CLOSE_PAR ARROW returnType block
        {$$ = new FuncDecl($2, $4, $6, $7, $8) };
optionParam: {$$ = nullptr ;} | paramsList {$$ = new ParamList($1) ;}
returnType: INT_KEY {$$ = $1 ;}| VOID_KEY{$$ = $1 ;};
paramsList: param {$$ = new Param($1) ;}| paramsList COMMA param {$$ = $1 + " " + $2 + " " $3;}
param: INT_KEY IDENTIFIER {$$ = new Param($2);}| 
        INT_KEY REF_KEY IDENTIFIER {$$ = new Param(new std::string("ref"), $3);};

statementList: {$$ = nullptr ;}| statementList statement {$$ = $1 + $2; };
statement: varDecl{$$ = $1 ;} | assignment {$$ = $1 ;}| ifStmt {$$ = $1 ;}| whileStmt {$$ = $1 ;}| printStmt {$$ = $1 ;}| returnStmt{$$ = $1 ;}| exprStmt{$$ = $1 ;}| block{$$ = $1 ;};
assignment: IDENTIFIER ASSIGN expr SEMICOLON {$$ = $1 + " " + $2 + " " + $3 + " " + $4 ;};
ifStmt: ;
whileStmt: WHILE_KEY OPEN_PAR expr CLOSE_PAR statementList {$$ = $1 + $2 + " " + $3 + " " + $4 + " " $5;};
printStmt: PRINT_KEY OPEN_PAR expr CLOSE_PAR SEMICOLON {$$ = $1 + $2 + " " + $3 + " " + $4 + " " $5;};
returnStmt: RETURN_KEY SEMICOLON {$$ = $1 + $2; }| RETURN_KEY expr SEMICOLON {$$ = $1 + " " + $2 + $3; };
exprStmt: funcCall SEMICOLON {$$ = $1 + $2; };
block: LEFT_BRACKET statementList RIGHT_BRACKET {$$ = $1 + " " + $2 + " " + $3; };

%%