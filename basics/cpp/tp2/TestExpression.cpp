/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences
 * 3MD1080 - C++ - TP n°2
 *
 * TestExpression.cpp
 * c++ -std=c++20 -o TestExpression Expression.cpp TestExpression.cpp
 */

#include <iostream>
#include <utility>

#include "Expression.hpp"


void test12()
{
    std::cout << std::endl << "*** Test 1.2 ***" << std::endl;
    Nombre n{ 3 };
    std::cout << "Nombre : " << n << std::endl;
    Expression * zero = n.derive("x");
    std::cout << "Derivee du nombre: " << *zero << std::endl;


    Variable x { "x" };
    std::cout << "Variable : " << x << std::endl;
    Expression *d = x.derive("x");
    std::cout << "Derivee de x : " << *d << std::endl;

    std::cout << "Number of instances at the end of test 1.2 = " << Expression::nb_instances() << std::endl;

    delete zero;
    delete d;

}

void test131() 
{
    std::cout << std::endl << "*** Test 1.3.1 ***" << std::endl;
    Addition a {new Variable("x"), new Variable("y")};
    std::cout << "The addition is : " << a << std::endl;
    Expression *d = a.derive("x");
    std::cout << "It's derivative according to x is : " << *d << std::endl;

    delete d;
}

void test132()
{
    std::cout << std::endl << "*** Test 1.3.2 ***" << std::endl;
    Nombre n{3}; Variable x{"x"}; Addition a{new Nombre(5), new Variable("y")};
    // Construction par copie
    Nombre m(n); Variable z(x); Addition b(a);
    std::cout << "New Nombre : " << m << std::endl
              << "New Variable : " << z << std::endl
              << "New Addition : " << b << std::endl;
}

void test133()
{
    std::cout << std::endl << "*** Test 1.3.3 ***" << std::endl;
    Multiplication m(new Nombre(2), new Variable("y"));
    std::cout << "The multiplication is : " << m << std::endl;
    Expression *d = m.derive("y");
    std::cout << "It's derivate according to y is : " << *d << std::endl;
    delete d;
}

void test2()
{
    std::cout << std::endl << "*** Test 2. Shared Pointers ***" << std::endl;
    SmartNombre sn{3};
    SmartVariable sx{"x"};
    std::shared_ptr<SmartExpression> dsn = sn.derive("x");
    std::shared_ptr<SmartExpression> dsx = sx.derive("x");
    std::cout << "Derivative of a number : " << *dsn << std::endl
              << "Derivative of a variable : " << *dsx << std::endl;
    
    std::cout << "Number of instances : " << SmartExpression::nb_instances() << std::endl;

    shared_expr psn{std::make_shared<SmartNombre>(sn)};
    shared_expr psx{std::make_shared<SmartVariable>(sx)};
    SmartAddition sa(psn, psx);
    std::shared_ptr<SmartExpression> dsa = sa.derive("x");
    std::cout << "Addition : " << sa << std::endl
              << "It's derivative : " << *dsa << std::endl;

    SmartMultiplication sm(psn, psx);
    shared_expr dsm = sm.derive("x");
    std::cout << "Multiplication : " << sm << std::endl
              << "It's derivative : " << *dsm << std::endl; 

}

void test3() 
{
    std::cout << std::endl << "*** Test 3 Bonus ***" << std::endl;
    SmartNombre sn{2};
    SmartVariable sx{"x"};
    SmartVariable sy{"y"};
    shared_expr psn{std::make_shared<SmartNombre>(sn)};
    shared_expr psx{std::make_shared<SmartVariable>(sx)};
    shared_expr psy{std::make_shared<SmartVariable>(sy)};
    SmartMultiplication sm(psn, psx);
    SmartAddition sa(std::make_shared<SmartMultiplication>(sm), psy);
    std::shared_ptr<SmartExpression> dsadx = sa.derive("x");
    std::cout << "The expression : " << sa << std::endl
              << "It's derivative according to x: " << *dsadx << std::endl;
    std::shared_ptr<SmartExpression> dsady = sa.derive("y");
    std::cout << "It's derivative according to y: " << *dsady << std::endl;
    SmartMultiplication m(psn, psy);
    std::cout << "The multiplication is (same as in 1.3.3): " << m << std::endl;
    std::shared_ptr<SmartExpression> dmdy = m.derive("y");
    std::cout << "It's derivate according to y is : " << *dmdy << std::endl;

    SmartAddition sap = SmartAddition(sn, sx);



}

int main( int argc, char * argv[] )
{
    std::cout << "Number of instances at the beginning of main = " << Expression::nb_instances() << std::endl;
    test12();
    test131();
    test132();
    test133();
    test2();
    test3();
    std::cout << std::endl << "Number of instances at the end of main = " << Expression::nb_instances() + SmartExpression::nb_instances() << std::endl;
}
