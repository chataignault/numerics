#include <iostream>
#include <algorithm>
#include <functional>
#include <cmath>

// define constant 
int const zero{0};
int num{1};
int * const ptr_constant{ &num };
int const * ptr_sur_constant{ &num };

// swith control structure
void switch_test() {
    std::cout << "***Switch test***";
    int n;
    std::cout << "Enter 0 or 1 : " << std::endl;
    std::cin >> n;
    switch (n)
    {
    case 0:
        std::cout << "No : 0" << std::endl;
        break;
    case 1:
        std::cout << "Yes : 1" << std::endl;
        break;
    default:
        std::cout << "This case is not captured" << std::endl << std::endl;
        break;
    }
}

// lambda function
auto lambda = [] (int n ) -> bool {return n % 2 ==0;};
// another way
std::function< int (bool) > lambda2{ lambda };

// lambda function passed as argument 
void for_each_test() {
    std::cout << std::endl << "***For each and lambda function test***" << std::endl;
    int tab[] = {1, 2, 3, 4};
    std::cout << "tab looks like : " << tab << std::endl;
    std::for_each(
        tab, tab+4, [](int & n){n++;}
    );
    std::cout << "Now tab looks like that" << tab;
}

// capture de contexte 
void capture_context_test() {
    std::cout << std::endl << "***Context capture test***" << std::endl;
    int i{1}, j{2};
    auto sum = [i, &j]() {return i + j;};
    std::cout << "Initially : i=" << i << ", j=" << j << ", sum=" << sum() <<std::endl;
    i++;
    std::cout << "Increasing i: i=" << i << ", j=" << j << ", sum=" << sum() << std::endl;
    j++;
    std::cout << "Now increasing j: i=" << i << ", j=" << j << ", sum=" << sum() << std::endl;
}

// agregate
struct Complex {
    double real;
    double imag;
};
void aggregate_test() {
    std::cout << std::endl << "***Aggregate test***" << std::endl;
    Complex c{ 1.3, 2.8};
    std::cout << "Our complex number is c=(" << c.real << ", " << c.imag <<")" << std::endl; // can I write a tuple like that ?
    double r = c.real;
    c.imag += 2.;
    Complex c_nul{0., 0.};
    c = c_nul;
}

// enum
void enum_test() {
    std::cout << "\n ***Color test***\n";
    enum class Color {red, green, blue};
    Color c{Color::green};
    switch(c)
    {
        case Color::red : std::cout << "The color is red\n"; break;
        case Color::green : std::cout << "The color is green\n"; break;
        case Color::blue : std::cout << "The color is blue\n"; break;
    }
}

// pointeurs
void pointeur_test() {
    std::cout << std::endl << "***Pointeur test***" << std::endl;
    int i{5};
    std::cout << "We defined i=" << i << " and &i=" << &i << " is its address" << std::endl;
    int *p; // une variable de type pointeur
    p = &i; // p points towards i
    *p = -7;
    std::cout << "Modifying i through pointer p : i=" << i << std::endl;
    // & operator returns the adress
    // * operator returns the value at a specified adress
    // both operators are complementary
}

// faire un effet de bord en passant un pointeur comme argument
int * pointeur_passing_test(int * p) {
    std::cout << std::endl << "***Pointeur passing test***" << std::endl;
    std::cout << *p << std::endl;
    p[0] = 1; p[1] = 2;
    return p;
}

// allocation statique / automatique
int x{1}; // allocation statique,  disparait a la fin de main()
void f() {
    static int y{2}; // allocation statique, disparait a la fin de main()
    int z{3}; // allocation automatique, va disparaitre à la fin du bloc
    int *p{ new int{} }; // allocation dynamique
    *p = 5;
    // ...
    delete p;
}

// allocation dynamique de tab
int taille{5};
auto tab( new int[taille] );
int * p1{ &tab[0] };
int * p2{ &tab[5] };
ptrdiff_t i{ p2 - p1 };

// retour de valeur
int & getVal() {
    static int val{ 5 };
    return val;
}

// class 
struct Complex_m {
    private:
        double real;
        double imag;

    public:
        Complex_m( double real, double imag ) {
            this->real = real;
            this->imag = imag;
        }; // __init__ in python as now the attributes real and imag are private
        double module() const { return std::sqrt( real*real + imag*imag ); }; 
};
// its possible to define the methods outside of the class declaration as well like this :
/*   
double Complex_m::module() const { // modification des attributs interdite avec flag const
    return std::sqrt( real*real + imag*imag );
    // this is the pointer that references the instance of the object
    // we could have written :
    // return std::sqrt( this->real * this->real + this->imag * this->imag )
    // this -> real equivalent to ( *this ).real
}
*/


int main() {
    switch_test();
    for_each_test();
    capture_context_test();
    aggregate_test();
    enum_test();
    pointeur_test();
    std::cout << getVal();
    int tab1[3]; // table of length 3
    std::cout << tab1 << tab1[0];
    std::cout << *(pointeur_passing_test(tab1));

    // test valeur gauche
    int i{0}; 
    i = 3;
    std::cout << std::endl << i << std::endl;

    // reference sur la valeur gauche 
    int & j{i}; // reference ie j suit la valeur de i  contrairement à k
    int k{i}; 
    i++;
    std::cout << i <<j << k << std::endl;
    i--; j++;
    std::cout << i <<j << k << std::endl;  // i suit la valeur de j aussi
}
