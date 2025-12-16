#include <iostream>
#include <iomanip>
#include <cctype>
#include <limits>
//#include <boost/multiprecision/gmp.hpp> 
#include <gmpxx.h>

using DigitType = unsigned long;

struct Digit
{
    DigitType digit_;
    Digit * next_; 
};

using Number = Digit *; // type defining a pointer to a Digit

const DigitType number_base = 100000000000;


void print_number( Number n )
{
    if( n == nullptr ) return;
    print_number( n->next_ );
    std::cout << n->digit_;
}

void test31() {
    Digit d1{ 1, nullptr };
    Digit d2{ 2, &d1 };
    Digit d3{3, &d2};
    Number number{&d3};

    print_number(number);
    std::cout << std::endl;

}


void free_number(Number n) {
    if( n == nullptr ) return;
    free_number(n->next_);
    delete n;
}


void test32() {
    Number d1{new Digit{1, nullptr }};
    Number d2{new Digit{ 2, d1 }};
    Number d3{new Digit{ 3, d2 }};

    print_number(d3);
    std::cout << std::endl;

    free_number(d3);

    std::cout << "the variable has been cleaned" << std::endl;
}


Number build_number(unsigned long l) {
    Number n{new Digit{ static_cast<DigitType>(l % number_base), nullptr }};
    if (l >= number_base) n->next_ = build_number( l/number_base );
    return n;

}

void test33() {
    unsigned long l;
    std::cout << "Enter long number\n >>> ";
    std::cin >> l;
    Number number{build_number(l)};
    print_number(number);
    free_number(number);
}

/*
Number read_number() {
    std::cin >> std::ws;              // saut des blancs (whitespaces), <iomanip> nécessaire
    Number p{nullptr};
    while( std::cin.good() ) {
        int c{ std::cin.get() };
        if( std::isdigit( c )) {      // <cctype> nécessaire
            DigitType d{ static_cast< DigitType >( c - '0' )};
            // d contient le chiffre entre 0 et 9 qui vient d'être lu.
            // À vous de compléter...
            Number n{new Digit{d, p}};
            p = n;
        }
        else break;
    }
    return p;
}


void test34() {
    Number n = read_number();
    std::cout << "The number is : \n >>> ";
    print_number(n);
    free_number(n);
} 
*/

/*
void multiply_number( Number n, unsigned int i, unsigned int carry = 0 ) {
    // Prints  multiplication of n by
    if (n == nullptr) return;
    unsigned long mul{(static_cast< unsigned long >(n->digit_) * i + carry)};
    n->digit_ =  mul % number_base;
    if (n->next_ != nullptr) multiply_number(n->next_, i, mul / number_base);
    else if(mul >= number_base) n->next_ = build_number(mul / number_base);
}
*/

void multiply_number( Number n, unsigned int i, unsigned int carry = 0 )
{
    if( n == nullptr ) return;
    // Il est important de faire la multiplication avec des unsigned long
    unsigned long mul{ static_cast< unsigned long >( i ) * n->digit_ + carry };
    n->digit_ = mul % number_base;
    if( n->next_ != nullptr ) multiply_number( n->next_, i, mul / number_base );
    else if( mul >= number_base ) n->next_ = build_number( mul / number_base );
}
/*
void test41() {
    std::cout << "Enter number :\n";
    Number n{read_number()};
    unsigned int l;
    std::cout << "Enter int :\n";
    std::cin >> l;
    multiply_number(n, l);
    std::cout << "n * i = ";
    print_number( n );
    std::cout << "\n";
    free_number( n );
}
*/

Number factorial(unsigned int l) {
    Number n{new Digit{1, nullptr }};
    if (l <= 1) return n;
    for(int i{1}; i <= l; i++) { multiply_number(n, i); };
    /* 
    if( l <= 1 ) return build_number( 1 );
    Number n{ build_number( l )};
    while( --l > 0 ) multiply_number( n, l );
    */
    return n;
}

void test_42() {
    std::cout << "Enter number :\n";
    unsigned int n;
    std::cin >> n;
    Number n_f = factorial(n);
    std::cout << "n! = ";
    print_number( n_f );
    std::cout << "\n";
    free_number( n_f );
}

void test_51() {
    Number n = build_number(number_base - 1);
    multiply_number(n, std::numeric_limits< unsigned int >::max(), std::numeric_limits< unsigned int >::max());
    print_number(n);
    free_number(n);
    // probleme de debordement en 32 bits le resultat est faux
}


void test_52( unsigned int i ) {
    Number n{ factorial( i )};
    std::cout << "i = " << i << std::endl;
    std::cout << "i! = ";
    print_number( n );
    free_number( n );

}


/*
int main() {
    unsigned long big{100};

}
*/

boost::multiprecision::mpz_int factorial_gmp( unsigned long l )
{
    if( l == 0 ) return 1;
    boost::multiprecision::mpz_int n{ l };
    while( --l > 0 ) n *= l;
    return n;
}

/* Recuperer un entier en premier argument */
int main( int argc, char * argv[] )
{
    unsigned int n{ static_cast< unsigned int >( std::stoul( argv[1] ))};
    boost::multiprecision::mpz_int factorial_gmp( static_cast< unsigned long >(n) );
}
/**/