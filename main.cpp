#include <iostream>
#include <fstream>
#include "Lexer.hpp"    
#include "Parser.hpp"   
#include "Ast.hpp"

int main(int argc, char* argv[]) {

    //verificar que tenga archivo
    if (argc <2){
        std::cerr << "Usage: " << argv[0] << " <input_file>\n";
        return 1;
    }
    
    std::ifstream inputFile(argv[1]);
    if (!inputFile.is_open()) {
        std::cerr << "Error opening file: " << argv[1] << "\n";
        return 1;
    } 

    Proyect::ProyectoLexer my_lexer(&inputFile);
    //instanciar root primero porque el parser lo necesita 
    AstNode* root = nullptr;
    Proyect::Parser my_parser(my_lexer, root);

    try{
        my_parser();
        //validar que root tenga algo
        if (root) {
            std::cout << "De txt a AST: " << root->toString() << std::endl;
            std::cout<<"Syntax correct\n";
        }
       
    }catch(const Proyect::Parser::syntax_error& e){
        std::cerr << "Error de sintaxis: " << e.what() << "\n";
    }

    return 0;
}

