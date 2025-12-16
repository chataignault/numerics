#include <iostream>
#include <numbers>
#include <cmath>
#include <functional> 
#include <stdlib.h>


double sin_x_plus_cos_sqrt2_times_x( double x )
    {
        return std::sin( x ) + std::cos(x * M_SQRT2 );
    }


void test11() {
    std::cout << "test-11" << std::endl;
    std::cout << "sin_x_plus_cos_sqrt2_times_x(1) = "
              << sin_x_plus_cos_sqrt2_times_x( 1. ) << std::endl;
    std::cout << sin_x_plus_cos_sqrt2_times_x( -4.5 ) << std::endl;

}


void test12() {
    float x;
    std::cout << "Enter value:" << std::endl;
    std::cin >>  x;
    std::cout << "test12 result" << std::endl;
    std::cout << sin_x_plus_cos_sqrt2_times_x( x ) << std::endl;
}


void test21() {
    float x;
    std::cout << "Enter value:" << std::endl;
    std::cin >>  x;
    std::cout << "test21 result" << std::endl;
    for (int i{0}; i <= 10 ; i++) {
        std::cout << "sin_x_plus_cos_sqrt2_times_x( " << x + static_cast< float >( i ) <<  ") :"
                  << sin_x_plus_cos_sqrt2_times_x( x + static_cast< float >( i ) ) << std::endl;
    }
    
}


void print_sin_x_plus_cos_sqrt2_times_x( double begin, double end, double step ) {
    for (int i{0}; static_cast< float >( i )*step + begin <= end; i++) {
        std::cout << "sin_x_plus_cos_sqrt2_times_x( " << begin + step*static_cast< float >( i ) <<  ") :"
                  << sin_x_plus_cos_sqrt2_times_x( begin + step*static_cast< float >( i ) ) << std::endl;
    }
}


void test22() {
    print_sin_x_plus_cos_sqrt2_times_x(-10.,10.,2.);
}


void test23() {

    float begin;
    float end;
    int number;

    std::cout << "Enter begin:" << std::endl;
    std::cin >>  begin;

    std::cout << "Enter end:" << std::endl;
    std::cin >>  end;

    std::cout << "Enter number:" << std::endl;
    std::cin >>  number;

    if (begin < end) {
        float step{(end - begin)/number}; 
        print_sin_x_plus_cos_sqrt2_times_x(begin, end, step);
    }
}


double compute_derivative( std::function< double( double ) > func, double x, double epsilon ) {
    return (func(x+epsilon) - func(x))/epsilon;
}


void test31() {
    float step{0.01};
    float begin{-4.6};
    float end{-4.5};
    float epsilon{0.00001};

    for (int i{0}; static_cast< float >( i )*step+begin <= end; i++) {
        double estimate = compute_derivative( sin_x_plus_cos_sqrt2_times_x, static_cast< float >( i )*step+begin, epsilon);
        std::cout << "Derivative(" << static_cast< float >( i )*step+begin << ") is :" << estimate << std::endl;
    }
}


double find_zero( std::function< double( double ) > func, double begin, double end, double precision ) {
    double val_begin{func(begin)};
    double val_end{func(end)};

    if (val_begin*val_end > 0.) {
        return 0.;
    }
    else {
        double middle{ ( begin+end )/2. };
        double value{ func( middle ) };

        while ((abs(value) > precision)) {
            middle =  (begin+end)/2;

            if (middle == begin) return 0.;
            if (middle == end) return 0.;

            value = func( middle );

            if (val_begin*value < 0) {
                end = middle;
                val_end = value;
            }
            else {
                begin = middle;
                val_begin = value;
            }
        }
        return middle;
    }

}

double dichotomy_root_finding( std::function<double(double)> func, double begin, double end, double precision) {
    double begin_val = func(begin);
    double end_val = func(end);
    double mid{ (end + begin) / 2 }; 
    if ( begin_val * end_val > 0) { 
        return 0. ; 
    } else {
        double value{ func(mid) };

        while (std::abs(value) > precision) {

            mid = (end + begin) / 2;

            if (mid == begin) return 0.;
            if (mid == end) return 0.;

            value = func(mid);

            if ( value * begin_val < 0) {
                end_val = value;
                end = mid;
            }
            else {
                begin_val = value;
                begin = mid;
            }
        }
    }

    return mid;
}


double brent_root_finding( std::function< double(double) > func, double begin, double end, double precision ) {
    return 0;
}


void test32() {
    double root{find_zero(sin_x_plus_cos_sqrt2_times_x, -2., 0., 1e-5)};
    double root_dichotomy{dichotomy_root_finding(sin_x_plus_cos_sqrt2_times_x, -2., 0., 1e-5)};
    std::cout << "sin_x_plus_cos_sqrt2_times_x(" <<  root << ") = " << sin_x_plus_cos_sqrt2_times_x(root) << std::endl;
    std::cout << "sin_x_plus_cos_sqrt2_times_x(" <<  root_dichotomy << ") = " << sin_x_plus_cos_sqrt2_times_x(root_dichotomy) << std::endl;
}


int find_all_zeros( std::function< double( double ) > func, double begin, double end, double width, 
                    double precision, double results[], int max_number_of_results ) 
{   
    int number_of_results{0};

    for (double x{begin}; x + width <= end; x += width) {
        double f_val_begin{func(x)};
        double f_val_end{func(x + width)};
        if (f_val_begin*f_val_end > 0) continue;
        double root{ find_zero(func, x, x+width, precision)};
        results[number_of_results] = root;
        if (++number_of_results > max_number_of_results) return max_number_of_results;
        // ++number_of_results;
    }
    return number_of_results;
}


void test41()
{
    double results[10];
    int n{find_all_zeros(sin_x_plus_cos_sqrt2_times_x, -10., 10., 0.5, 1e-5, results, 10)};
    std::cout << "Number of zeros = " << n << std::endl;
    for (int i{0}; i<n; i++){
        std::cout << "f( " << results[i] << " ) = " << sin_x_plus_cos_sqrt2_times_x(results[i]) << std::endl;
    }

}


int find_all_extrema( std::function< double( double ) > func, double begin, double end, double width, 
                      double precision, double epsilon, double results[], int max_number_of_results ) 
{
    // Solution avec une fonction lambda
    auto derivative = [func, epsilon]( double x ) { return compute_derivative( func, x, epsilon ); };

    return find_all_zeros(derivative, begin, end, width, precision, results, max_number_of_results);
}


void test42()
{
    double results[10];
    int nb{ find_all_extrema( sin_x_plus_cos_sqrt2_times_x, -10, 10, 0.5, 1e-5, 1e-5, results, 10 ) };
    for (int i{0}; i<nb; i++) {
        std::cout << "f( " << results[i] << " ) = " << sin_x_plus_cos_sqrt2_times_x(results[i]) << std::endl;
    }
}
        

int main() {
    test32();
    test42();
}
