%language "C++"
%require "3.2"
%define api.value.type variant

%token <std::string> OP_PLUS OP_SUB OP_MULT OP_DIVIDE OP_MODULE //aritmeticos
%token <std::string> EQUAL_TO NOT_EQUAL LESS_THAN LESS_EQUAL GREATER_THAN GREATER_EQUAL //compare
%token <std::string> LOGIC_AND  LOGIC_OR LOGIC_NOT //logic
%token <std::string> ASSIGN  OPEN_PAR CLOSE_PAR
%token SEMICOLON COMMA  LEFT_BRACKET  RIGHT_BRACKET LEFT_BRACE RIGHT_BRACE
%token <long> NUMBER 
%token <std::string> IDENTIFIER INT_KEY VOID_KEY IF_KEY ELSE_KEY WHILE_KEY PRINT_KEY DEF_KEY RETURN_KEY REF_KEY ARROW 

%nterm <AstNode*> program
%type <AstNode*> declaration varDecl funcDecl param optionParam arrayDecl
%type <AstNode*> statement assignment ifStmt whileStmt printStmt returnStmt exprStmt block
%type <AstNode*> expr logicalOr logicalAnd equality comparison term factor unary primary funcCall argList   
%type <List>  statementList declare_list paramList
%type <std::string> returnType eq com arith arith1 logic


%define parse.error verbose
%define api.namespace {Proyect}
%define api.parser.class {Parser}

%parse-param {ProyectoLexer& lexer}
%parse-param {AstNode*& root}

%code requires{
    #include "Ast.hpp"
    namespace Proyect
    {
         class ProyectoLexer;
    }
}

%{
#include <string>
#include "Parser.hpp"
#include "Lexer.hpp"
#include <iostream>

namespace Proyect{
    void Parser::error(const std::string& msg){
        throw syntax_error(msg);
    }
}

#define yylex(p) lexer.nextToken(p)

%}

%nonassoc OTRO_ELSE_KEY
%nonassoc ELSE_KEY


%%

program: declare_list {root = new Program($1);};
declare_list: { $$ = List(); } |  declare_list declaration {  $1.push_back($2); $$ = $1; };
declaration: varDecl {$$ = $1;}| funcDecl {$$ = $1;} | arrayDecl;
varDecl: INT_KEY IDENTIFIER SEMICOLON {$$ = new VarDecl(new IdentifierExpr($2), nullptr);}| 
         INT_KEY IDENTIFIER ASSIGN expr SEMICOLON
         { $$ = new VarDecl(new IdentifierExpr($2), $4);};
funcDecl: DEF_KEY IDENTIFIER OPEN_PAR optionParam CLOSE_PAR ARROW returnType block
        {$$ = new FuncDecl(new IdentifierExpr($2), $4, $7, $8); };
optionParam: {$$ = nullptr ;} | paramList {$$ = new ParamList($1) ;}
paramList: param { $$ = List();  $$.push_back($1); }| paramList COMMA param { $1.push_back($3); $$ = $1; };
param: INT_KEY IDENTIFIER {$$ = new Param("",new IdentifierExpr($2));}| 
        INT_KEY REF_KEY IDENTIFIER {$$ = new Param("ref", new IdentifierExpr($3));};

statementList: {$$ = List() ;}| statementList statement { $1.push_back($2); $$ = $1; };
statement: varDecl{$$ = $1 ;} | assignment {$$ = $1 ;}| ifStmt {$$ = $1 ;}| whileStmt {$$ = $1 ;}| printStmt {$$ = $1 ;}| returnStmt{$$ = $1 ;}| exprStmt{$$ = $1 ;}| block{$$ = $1 ;};
assignment: IDENTIFIER ASSIGN expr SEMICOLON {$$ = new AssignStmt(new IdentifierExpr($1), $3) ;};
ifStmt: IF_KEY OPEN_PAR expr CLOSE_PAR statement %prec OTRO_ELSE_KEY{$$ = new IfStmt($3, $5, nullptr); } | 
        IF_KEY OPEN_PAR expr CLOSE_PAR statement ELSE_KEY statement {$$ = new IfStmt($3, $5, $7);};
whileStmt: WHILE_KEY OPEN_PAR expr CLOSE_PAR statement {$$ = new WhileStmt($3, $5);};
printStmt: PRINT_KEY OPEN_PAR expr CLOSE_PAR SEMICOLON {$$ = new PrintStmt($3);};
returnStmt: RETURN_KEY SEMICOLON {$$ = new ReturnStmt(nullptr); }| RETURN_KEY expr SEMICOLON {$$ = new ReturnStmt($2); };
exprStmt: funcCall SEMICOLON {$$ = new ExprStmt($1); };
block: LEFT_BRACKET statementList RIGHT_BRACKET {$$ = new Block($2); };

expr : logicalOr {$$ = $1;};
logicalOr: logicalAnd {  $$ = new LogicalOr($1, Rest()); } 
        |  logicalOr LOGIC_OR logicalAnd 
        { auto node = dynamic_cast<LogicalOr*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
logicalAnd: equality { $$ = new LogicalAnd($1, Rest());; } | logicalAnd LOGIC_AND equality 
    { auto node = dynamic_cast<LogicalAnd*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
equality: comparison { $$ = new Equality($1, Rest());; } | equality eq comparison 
    { auto node = dynamic_cast<Equality*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
comparison: term {$$ = new Comparison($1, Rest());; } | comparison com term 
    { auto node = dynamic_cast<Comparison*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
term: factor { $$ = new Term($1, Rest()); } | term arith factor 
    { auto node = dynamic_cast<Term*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
factor: unary {$$ = new Factor($1,Rest());} | factor arith1 unary 
    { auto node = dynamic_cast<Factor*>($1);
        node->rest.push_back(std::make_pair($2, $3));
        $$ = node;};
unary: logic unary {$$ = new Unary($1, $2, nullptr); }| primary {$$ = $1; };
logic: LOGIC_NOT {$$ = $1; } | OP_SUB { $$ = $1; };
primary: NUMBER {$$ = new NumberExpr($1); }| IDENTIFIER {$$ = new IdentifierExpr($1);} | funcCall{$$ = $1;}  | OPEN_PAR expr CLOSE_PAR {$$ = new ParenExpr($2);} ;

funcCall: IDENTIFIER OPEN_PAR argList CLOSE_PAR { $$ = new FuncCall(new IdentifierExpr($1), $3);};
argList: { List v; $$ = new ArgList(v);}
       | expr {  List v; v.push_back($1); $$ = new ArgList(v); }
       | argList COMMA expr { auto node = dynamic_cast<ArgList*>($1); node->arg.push_back($3); $$ = node; };


returnType: INT_KEY {$$ = $1 ;}| VOID_KEY{$$ = $1 ;};
eq: EQUAL_TO {$$ = $1; } | NOT_EQUAL{ $$ = $1;};
com: LESS_THAN {$$= $1; } | LESS_EQUAL {$$= $1; } | GREATER_THAN {$$= $1; } | GREATER_EQUAL {$$= $1; };
arith: OP_PLUS {$$ = $1; } | OP_SUB {$$ = $1; };
arith1: OP_MULT {$$ = $1; } | OP_DIVIDE{ $$ = $1; } | OP_MODULE {$$ = $1;}
%%


