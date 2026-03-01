%language "C++"
%require "3.2"
%define api.value.type variant

%token OP_PLUS "+"
%token OP_SUB "-"
%token OP_MULT "*"
%token OP_DIVIDE "/"
%token OP_MODULE "%"
%token EQUAL_TO "=="
%token NOT_EQUAL "!="
%token LESS_THAN "<"
%token LESS_EQUAL "<="
%token GREATER_THAN ">"
%token GREATER_EQUAL ">="
%token LOGIC_AND "&&"
%token LOGIC_OR "||"
%token LOGIC_NOT "!"
%token ASSIGN "="
%token SEMICOLON ";"
%token COMMA ","
%token LEFT_BRACKET "{"
%token RIGHT_BRACKET "}"
%token OPEN_PAR "("
%token CLOSE_PAR ")"
%token COMMENT "//"
%token <long>NUMBER "number"
%token <std::string> IDENTIFIER "identifier"
%token <std::string>INT_KEY "int"
%token <std::string> VOID_KEY "void"
%token <std::string> IF_KEY "if"
%token <std::string> ELSE_KEY "else"
%token <std::string> WHILE_KEY "while"
%token <std::string> PRINT_KEY "print"
%token <std::string> DEF_KEY "def"
%token <std::string> RETURN_KEY "return"
%token <std::string> REF_KEY "ref"

%define parse.error verbose
%define api.namespace {Expr}
%define api.parser.class {Parser}

%parse-param {ProyectoLexer& lexer}

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

program: declare_list {$$ = $1;};
declare_list: {$$ = "";}| declare_list declaration {$$ = $1;};
declaration: varDecl {$$ = $1;}| funcDecl {$$ = $1;};
varDecl: INT_KEY IDENTIFIER SEMICOLON {$$ = $1 + ""+ $2 +";";}| 
         INT_KEY IDENTIFIER ASSIGN expr SEMICOLON
         { $$ = $1 + " " + $2 + " = " + $4 + ";";};
funcDecl: DEF_KEY IDENTIFIER {$$ = $1 + "" + $2;};
param: INT_KEY IDENTIFIER {$$ = $1 + "" + $2;}| 
        INT_KEY REF_KEY IDENTIFIER {$$ = $1 + "" + $2 + "" + $3;};


statement: varDecl | assignment | ifStmt | whileStmt | printStmt | returnStmt| exprStmt| block;
assignment: IDENTIFIER ASSIGN expr SEMICOLON;
ifStmt: ;
whileStmt: WHILE_KEY OPEN_PAR expr CLOSE_PAR statement;
printStmt: PRINT_KEY OPEN_PAR expr CLOSE_PAR SEMICOLON;
returnStmt: RETURN_KEY SEMICOLON | RETURN_KEY expr SEMICOLON;
block: LEFT_BRACKET s

%%