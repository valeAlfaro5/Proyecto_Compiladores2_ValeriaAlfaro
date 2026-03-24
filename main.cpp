#include <iostream>
#include <fstream>
#include "Lexer.hpp" 
#include "CodeGen.hpp"   
#include "Parser.hpp"   
#include "Ast.hpp"

int main(int argc, char* argv[]) {

    // verificar argumentos
    if (argc < 3){
        std::cerr << "Usage: " << argv[0] << " <input_file> <output.ll>\n";
        return 1;
    }
    
    std::ifstream inputFile(argv[1]);
    if (!inputFile.is_open()) {
        std::cerr << "Error opening file: " << argv[1] << "\n";
        return 1;
    } 

    Proyect::ProyectoLexer my_lexer(&inputFile);

    // root del AST
    AstNode* root = nullptr;
    Proyect::Parser my_parser(my_lexer, root);

    try{
        my_parser();

        if (root) {
            std::cout << "De txt a AST:\n" << root->toString() << std::endl;
            std::cout << "Syntax correct\n";

            std::string llvmCode = root->genCode().code; 

            std::ofstream outputFile(argv[2]);
            if (!outputFile.is_open()) {
                std::cerr << "Error creando archivo de salida\n";
                return 1;
            }

            outputFile << llvmCode;
            outputFile.close();

            std::cout << "Archivo LLVM generado en: " << argv[2] << "\n";
        }
       
    }catch(const Proyect::Parser::syntax_error& e){
        std::cerr << "Error de sintaxis: " << e.what() <<  "\n";
    }

    return 0;
}