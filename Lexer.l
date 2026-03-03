%option lexer = "ProyectoLexer"
%option lex = "nextToken"
%option namespace = "Proyect"
%option bison-cc
%option bison-cc-namespace = "Proyect"
%option bison-cc-parser = "Parser"

%top{
    #include "Parser.hpp"
}

%class{
        using Token = Proyect::Parser::token;
}

%%

"+"     { return Token::OP_PLUS; }
"-"     { return Token::OP_SUB; }
"*"     { return Token::OP_MULT; }
"/"     { return Token::OP_DIVIDE; }
"%"     { return Token::OP_MODULE; }
"("     { return Token::OPEN_PAR; }
")"     { return Token::CLOSE_PAR; }
"=="    { return Token::EQUAL_TO; }
"!="    { return Token::NOT_EQUAL; }
"<"     { return Token::LESS_THAN; }
"<="    { return Token::LESS_EQUAL; }
">"     { return Token::GREATER_THAN; }
">="    { return Token::GREATER_EQUAL; }
"&&"    { return Token::LOGIC_AND; }
"||"    { return Token::LOGIC_OR; }
"!"     { return Token::LOGIC_NOT; }
"="     { return Token::ASSIGN; }
";"     { return Token::SEMICOLON; }
","     { return Token::COMMA; }
"{"     { return Token::LEFT_BRACKET; }
"}"     { return Token::RIGHT_BRACKET; }
\/\/.*  ;//ignorar comentarios  
"int"   { return Token::INT_KEY; }
"void"  { return Token::VOID_KEY; }
"if"    { return Token::IF_KEY; }
"else"  { return Token::ELSE_KEY; }
"while" { return Token::WHILE_KEY; }
"print" { return Token::PRINT_KEY; }
"def"   { return Token::DEF_KEY; }
"return" { return Token::RETURN_KEY; }
"ref"   { return Token::REF_KEY; }
"->"    { return Token::ARROW; }
[0-9]+  yylval.emplace<long>(std::stol(str())); return Token::NUMBER;
[A-Za-z_][A-Za-z_0-9]*  yylval.emplace<std::string>(text()); return Token::IDENTIFIER;
[ \t\r\n]+    ;   // ignorar espacios
<<EOF>>       { return 0; }
%%