/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences
 * 3MD1080 - C++ - TP n°3
 *
 * compute_pi_area.cpp
 * c++ -o compute_pi_area compute_pi_area.cpp -ltbb12
 */ //ltbb12 is to find in the lib folder in mingw64

#define _USE_MATH_DEFINES

#include <chrono>
#include <iostream>
#include <iomanip>
#include <numbers>
#include <string>
#include <cmath>

#include <cmath>
#include <cstdlib>
#include <functional>


#include <tbb/tbb.h>

using FloatKind = double;

FloatKind one_over_one_plus_x_squared( FloatKind x )
{
    return FloatKind(1)/(FloatKind(1) + x*x);
}

FloatKind compute_area( std::function< FloatKind( FloatKind ) > func, FloatKind x, FloatKind width )
{
    return width*func(x);
}

FloatKind compute_integral( std::function< FloatKind( FloatKind ) > func, FloatKind begin, FloatKind end, unsigned long nb_points )
{
    FloatKind width = (end-begin)/nb_points;
    FloatKind integral{0};
    for (int i{0}; i < nb_points; i++)
    {
        integral += compute_area(func, begin+i*width, width);
    }

    return integral;
}

FloatKind compute_pi( unsigned long nb_points )
{
    return FloatKind(4)*compute_integral(one_over_one_plus_x_squared, 0, 1, nb_points);
}

void test3( unsigned long nb_points )
{
    std::cout << std::endl << "***Test 3***" << std::endl;
    auto start = std::chrono::steady_clock::now();
    FloatKind pi_approx{ compute_pi( nb_points )};
    std::cout << "Pi approximation is : " << pi_approx << std::endl;
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration< double > elapsed_seconds = end - start;

    std::cout << "The computation time was : " << elapsed_seconds.count() << std::endl
              << "Corresponding to an absolute error of : " << std::abs(M_PI - pi_approx) << std::endl;
}

// FloatKind compute_integral_tbb( std::function< FloatKind( FloatKind ) > func, FloatKind * begin, FloatKind * end, unsigned long nb_points )
// {
//     FloatKind width{(*end-*begin)/nb_points};
//     std::cout << "Width = " << width << std::endl;
//     return tbb::parallel_reduce(
//         tbb::blocked_range<FloatKind*>(begin, end, nb_points), 
//         FloatKind{0},
//         [func, width] (const tbb::blocked_range<FloatKind*>& r, FloatKind res)->FloatKind { for( FloatKind* a=r.begin(); a!=r.end(); ++a ) res += func(*a)*width; return res; }, 
//         []( FloatKind x, FloatKind y )->FloatKind { return x+y ;}
//         );
// }

FloatKind compute_integral_tbb( std::function< FloatKind( FloatKind ) > func, FloatKind begin, FloatKind end, unsigned long nb_points )
{
    FloatKind width{(end-begin)/nb_points};
    std::cout << "Width = " << width << std::endl;
    return tbb::parallel_reduce(
        tbb::blocked_range<FloatKind>(begin, end, nb_points), 
        FloatKind{0},
        [func, width] (const tbb::blocked_range<FloatKind>& r, FloatKind res)->FloatKind { for( FloatKind x{r.begin()}; x<= r.end(); x+=width ) res += func(x)*width; return res; }, 
        []( FloatKind x, FloatKind y )->FloatKind { return x+y ;}
        );
}

FloatKind compute_pi_tbb( unsigned long nb_points )
{
    return FloatKind(4)*compute_integral_tbb(
        one_over_one_plus_x_squared,
        FloatKind(0),
        FloatKind(1),
        nb_points
    );
}

void test4( unsigned long nb_points )
{
    std::cout << std::endl << "***Test 4***" << std::endl;
    auto start = std::chrono::steady_clock::now();
    FloatKind pi_approx{ compute_pi_tbb( nb_points )};
    std::cout << "Pi approximation is : " << pi_approx << std::endl;
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration< double > elapsed_seconds = end - start;

    std::cout << "The computation time was : " << elapsed_seconds.count() << std::endl
              << "Corresponding to an absolute error of : " << std::abs(M_PI - pi_approx) << std::endl;
}

int main( int argc, char * argv[] )
{
    unsigned long nb_points = std::stoul(argv[1]);
    test3(nb_points);
    /* 3.
    With 100000000 points, the programs take 7.5 seconds to run and has a precision of 1e-8
    It is much better than the other solution
    */
   test4(nb_points);
    /*
    4.
    It takes now 3 seconds to run the computation .
    With the first compiler optimisation the computation time boils down to 0.36 seconds.
    */
}
