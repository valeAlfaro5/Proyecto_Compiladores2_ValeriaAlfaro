#include "CodeGen.hpp"


int temp =0;
int label = 0;
SymbolTable symbol;

std::string newTemp(){
    return "%t" + std::to_string(temp++);
}
std::string newLabel(){
    return "L" + std::to_string(label++);
}