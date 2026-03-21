%option lexer = "ProyectoLexer"
%option lex = "nextToken"
%option namespace = "Proyect"
%option bison-cc
%option bison-cc-namespace = "Proyect"
%option bison-cc-parser = "Parser"
//valeria alfaro

%top{
    #include "Parser.hpp"
}

%class{
        using Token = Proyect::Parser::token;
}

%%

"+"     { yylval.emplace<std::string>(text()); return Token::OP_PLUS; }
"-"     { yylval.emplace<std::string>(text()); return Token::OP_SUB; }
"*"     { yylval.emplace<std::string>(text()); return Token::OP_MULT; }
"/"     { yylval.emplace<std::string>(text()); return Token::OP_DIVIDE; }
"%"     { yylval.emplace<std::string>(text()); return Token::OP_MODULE; }
"("     { yylval.emplace<std::string>(text()); return Token::OPEN_PAR; }
")"     { yylval.emplace<std::string>(text()); return Token::CLOSE_PAR; }
"=="    { yylval.emplace<std::string>(text()); return Token::EQUAL_TO; }
"!="    { yylval.emplace<std::string>(text()); return Token::NOT_EQUAL; }
"<"     { yylval.emplace<std::string>(text()); return Token::LESS_THAN; }
"<="    { yylval.emplace<std::string>(text()); return Token::LESS_EQUAL; }
">"     { yylval.emplace<std::string>(text());  return Token::GREATER_THAN; }
">="    { yylval.emplace<std::string>(text()); return Token::GREATER_EQUAL; }
"&&"    { yylval.emplace<std::string>(text()); return Token::LOGIC_AND; }
"||"    { yylval.emplace<std::string>(text()); return Token::LOGIC_OR; }
"!"     { yylval.emplace<std::string>(text()); return Token::LOGIC_NOT; }
"="     { yylval.emplace<std::string>(text()); return Token::ASSIGN; }
";"     { yylval.emplace<std::string>(text()); return Token::SEMICOLON; }
","     { yylval.emplace<std::string>(text()); return Token::COMMA; }
"{"     { yylval.emplace<std::string>(text()); return Token::LEFT_BRACKET; }
"}"     { yylval.emplace<std::string>(text());  return Token::RIGHT_BRACKET; }
"["     { yylval.emplace<std::string>(text()); return Token::LEFT_BRACE; }
"]"     { yylval.emplace<std::string>(text());  return Token::RIGHT_BRACE; }
\/\/.*  ;//ignorar comentarios  
"int"   { yylval.emplace<std::string>(text()); return Token::INT_KEY; }
"void"  { yylval.emplace<std::string>(text()); return Token::VOID_KEY; }
"if"    { yylval.emplace<std::string>(text()); return Token::IF_KEY; }
"else"  { yylval.emplace<std::string>(text()); return Token::ELSE_KEY; }
"while" { yylval.emplace<std::string>(text()); return Token::WHILE_KEY; }
"print" { yylval.emplace<std::string>(text()); return Token::PRINT_KEY; }
"def"   { yylval.emplace<std::string>(text()); return Token::DEF_KEY; }
"return" { yylval.emplace<std::string>(text()); return Token::RETURN_KEY; }
"ref"   { yylval.emplace<std::string>(text()); return Token::REF_KEY; }
"->"    { yylval.emplace<std::string>(text()); return Token::ARROW; }
[0-9]+  yylval.emplace<long>(std::stol(str())); return Token::NUMBER;
[A-Za-z_][A-Za-z_0-9]*  yylval.emplace<std::string>(text()); return Token::IDENTIFIER;
[ \t\r\n]+    ;   // ignorar espacios
<<EOF>>       { return 0; }
%%