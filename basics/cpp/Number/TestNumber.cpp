#include <exception>
#include <sstream>
#include <utility>

#include "Number.hpp"

#include <iostream>


void test21() {
    unsigned long l{123};
    Number{ l };
    // no garbage collector so the destructor of Number is called just after creation
}

 
void test22()
{
    unsigned long l{123};
    std::cout << "Print 123:" << std::endl;
    std::cout << Number{ l } << std::endl;
}

void test31() {
    unsigned int n{7};
    Number m{9};
    std::cout << "9+=7 = ";
    std::cout << (m += n) << std::endl;
    std::cout << "res*=7 = " << (m *= n) << std::endl;
}


void test32() {
    Number n = * factorielle(5);
    std::cout << "5!=" << n << std::endl;
}

void test41() {
    Number n{10};
    // construction par copie
    std::cout << std::endl << "Number n : " << n << std::endl;
    Number m{n};
    m = n;
    std::cout << "Number m initialised with n : " << m << std::endl;
    m += 1;
    std::cout << "Now m = " << m << std::endl;
    // affectation par copie
    n = m;
    std::cout << "Now n set to m : n = " << n << std::endl;
}

void test42() {

    std::cout << std::endl << "*** Test operator+ operator* ***" <<std::endl; 
    Number n{1};
    Number m = n + 4;
    std::cout << "1 + 4 = " << m << std::endl;
    Number k = m * 3;
    std::cout << "(1 + 4) * 3 = " << k << std::endl;

} 

int main()
{
    test21();
    test22();
    test31();
    test32();
    test41();
    test42();
}
