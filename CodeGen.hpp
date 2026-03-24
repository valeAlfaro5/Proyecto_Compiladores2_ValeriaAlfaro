#pragma once
#include <string>
#include <unordered_map>

struct CodeGen{
    std::string code;
    std::string place;
    std::string type;

    CodeGen() = default;
    CodeGen(const std::string &c) : code(c), place(""), type(""){} //statements
    CodeGen(const std::string &c, const std::string &p) : code(c), place(p), type("") {}//expr
    CodeGen(const std::string &c, const std::string &p, const std::string &t): code(c), place(p), type(t) {} //general
};

using SymbolTable = std::unordered_map<std::string, CodeGen>;

std::string newTemp();
std::string newLabel();
