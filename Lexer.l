%option lexer = "SampleLexer"
%option lex = "nextToken"
%option namespace = "Expr"
%option bison-cc
%option bison-cc-namespace = "Expr"
%option bison-cc-parser = "Parser"

%top{
    #include "Parser.hpp"
}

%class{
        using Token = Expr::Parser::token;
}

%%

"+"     { return Token::OP_PLUS; }
"-"     { return Token::OP_SUB; }
"*"     { return Token::OP_MULT; }
"/"     { return Token::OP_DIVIDE; }
"%"     { return Token::OP_MODULE; }
"("     { return Token::OPEN_PAR; }
")"     { return Token::CLOSE_PAR; }
[0-9]+  yylval.emplace<long>(std::stol(str())); return Token::NUMBER;
[A-Za-z_][A-Za-z_0-9]*  yylval.emplace<std::string>(text()); return Token::IDENTIFIER;
[ \t\r\n]+    ;   // ignorar espacios
<<EOF>>       { return 0; }
%%