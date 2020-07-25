# Clang-cast

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Clang cast is a a C/C++ compiler and debugger using lex and yacc

  - Checks if the code is c or c++
  - Imitates Clang compiler
  - Throws error for wrong code compilation

## Tools!

  - Flex
  - Bison

Feautures:
  - Takes the code.txt as input and outputs parse.txt
  - Checks for variable and outs their value
  - Checks for validity of the code

### Execute

Clangcode requires flex and bison to run. Install them if not downloaded

```sh
$ cd Clang-cast
$ flex compiler.l
$ bison -dy compiler.y
$ gcc lex.yy.c y.tab.c
$ ./a.out
```
### Todos

 - Check for OOP(classes) support
 - Add more C features

License
----

MIT

**Free Software, Hell Yeah!**
