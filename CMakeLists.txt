
cmake_minimum_required(VERSION 3.15)
project(Valeria)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" "${CMAKE_MODULE_PATH}")

find_package(Reflex REQUIRED)
find_package(BISON REQUIRED)
find_package(TreeCC REQUIRED)

set (LEXER_SOURCE_FILE ${CMAKE_SOURCE_DIR}/Lexer.l)
set (LEXER_CPP_SOURCE Lexer.cpp)
set (LEXER_CPP_HEADER Lexer.hpp)
set (PARSER_CPP_SOURCE Parser.cpp)
set (PARSER_CPP_HEADER Parser.hpp)
set (AST_CPP_SOURCE Ast.cpp)
set (AST_CPP_HEADER Ast.hpp)

message(STATUS "Reflex version: ${REFLEX_VERSION}")
message(STATUS "Bison version: ${BISON_VERSION}")
message(STATUS "TreeCC version: ${TREECC_VERSION} ${TREECC_FOUND}")

add_custom_command(
    OUTPUT ${LEXER_CPP_HEADER} ${LEXER_CPP_SOURCE}
    COMMAND Reflex::Reflex -o ${LEXER_CPP_SOURCE} --header-file=${LEXER_CPP_HEADER} ${LEXER_SOURCE_FILE}
    DEPENDS ${LEXER_SOURCE_FILE}
    COMMENT "Building the Lexer...."
)

BISON_TARGET(Parser Parser.y ${CMAKE_CURRENT_BINARY_DIR}/Parser.cpp
            DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/Parser.hpp)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Ast.cpp ${CMAKE_CURRENT_BINARY_DIR}/Ast.hpp
    COMMAND ${TREECC_EXECUTABLE} -o ${CMAKE_CURRENT_BINARY_DIR}/Ast.cpp -h ${CMAKE_CURRENT_BINARY_DIR}/Ast.hpp ${CMAKE_SOURCE_DIR}/Ast.tc
    DEPENDS ${CMAKE_SOURCE_DIR}/Ast.tc
)

add_executable(${PROJECT_NAME} main.cpp ${LEXER_CPP_SOURCE} ${LEXER_CPP_HEADER} ${PARSER_CPP_SOURCE} ${PARSER_CPP_HEADER} ${AST_CPP_SOURCE} ${AST_CPP_HEADER})

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR})
target_link_libraries(${PROJECT_NAME} PRIVATE Reflex::ReflexLibStatic )

