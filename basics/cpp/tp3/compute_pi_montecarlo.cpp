/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences
 * 3MD1080 - C++ - TP n°3
 *
 * compute_pi_montecarlo.cpp
 * c++ -o compute_pi_montecarlo compute_pi_montecarlo.cpp -lpthread
 */

#define _USE_MATH_DEFINES

#include <chrono>
#include <future>
#include <iostream>
#include <iomanip>
#include <numbers>
#include <random>
#include <string>
#include <thread>

#include <cctype>
#include <cmath>
#include <cstdlib>

#include <numeric>


using FloatKind = float;

FloatKind next_random()
{
    static thread_local std::mt19937 generator{ std::random_device{}() };
    std::uniform_real_distribution< FloatKind > distribution{};
    return distribution( generator );
}

unsigned long nb_points_inside_unit_circle( unsigned long nb_points )
{
    unsigned long nb_inside{0};

    for (int i{0}; i< nb_points; i++)
    {
        FloatKind x = next_random();
        FloatKind y = next_random();
        if (x*x+y*y <= 1) nb_inside++;
    }
    return nb_inside;
}

FloatKind compute_pi( unsigned long nb_points )
{
    unsigned long nb_inside = nb_points_inside_unit_circle(nb_points);
    return 4*FloatKind(nb_inside)/FloatKind(nb_points);
}

void test11(unsigned long nb_points)
{
    std::cout << std::endl << "***Test 1.1***" << std::endl;
    FloatKind pi_approx = compute_pi(nb_points);
    std::cout << "The approximate value is : " << pi_approx << std::endl
              << "It's absolute difference with the real value of pi is : " << std::abs(M_PI - pi_approx) << std::endl;
}

void test12( unsigned long nb_points )
{
    std::cout << std::endl << "***Test 1.2***" << std::endl;
    auto start = std::chrono::steady_clock::now();
    FloatKind pi_approx = compute_pi(nb_points);
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration< double > elapsed_seconds = end - start;

    std::cout << "The computation time was : " << elapsed_seconds.count() << std::endl
              << "Corresponding to an absolute error of : " << std::abs(M_PI - pi_approx) << std::endl;
}

void test14( unsigned long nb_points )
{
    std::cout << std::endl << "***Test 1.4***" << std::endl;
    auto start = std::chrono::steady_clock::now();
    FloatKind max_diff = std::abs(M_PI - compute_pi(nb_points));
    for (int i{0}; i<9 ; i++)
    {
        FloatKind diff = std::abs(M_PI - compute_pi(nb_points));
        if (diff > max_diff) max_diff = diff;
    }
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration< double > elapsed_seconds = end - start;
    std::cout << "The max absolute difference for 10 iterations is : " << max_diff << std::endl
              << "The computation time was : " << elapsed_seconds.count() << std::endl;
}

FloatKind compute_pi( unsigned long nb_points, unsigned int nb_threads )
{
    std::vector<std::thread> pool;
    std::vector<std::future<unsigned long>> results;
    std::vector<FloatKind> pi_approximations;

    for (int i{0}; i < nb_threads; i++)
    {
        std::packaged_task<unsigned long(unsigned long)> task{nb_points_inside_unit_circle};
        results.push_back( std::future<unsigned long>(task.get_future()) );
        pool.push_back(std::thread(std::move(task), nb_points));
    }
    for (int i{0}; i < nb_threads; i++)
    {
        std::cout << "Waiting for task " << i << " to finish..." << std::endl; 
        pool[i].join();
        unsigned long result{ results[i].get() };
        pi_approximations.push_back( 4*FloatKind(result)/FloatKind(nb_points) );
    }

    FloatKind sum = std::accumulate(pi_approximations.begin(), pi_approximations.end(), 0.);
    FloatKind mean = sum/pi_approximations.size();

    return mean;
}

void test2( unsigned long nb_points, unsigned long nb_threads )
{
    std::cout << std::endl << "***Test 2***" << std::endl;
    auto start = std::chrono::steady_clock::now();
    FloatKind pi_approx = compute_pi(nb_points, nb_threads);
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration< double > elapsed_seconds = end - start;

    std::cout << "The computation time was : " << elapsed_seconds.count() << std::endl
              << "Corresponding to an absolute error of : " << std::abs(M_PI - pi_approx) << std::endl;
}

int main( int argc, char * argv[] )
{
    unsigned long nb_points = std::stoul(argv[1]);
    test11(nb_points);
    test12(nb_points);

    /*1.3*/
    /*
    compute_pi_montecarlo.exe 100000000
    takes 17 seconds to run,
    with -O, it takes 8 seconds
    with 500000000, it then takes 40 seconds to run with the first optimisation
    it takes 45 seconds with -O2 and 54 seconds with -O3 
    */

   test14(nb_points); // with 10 000 000 points, the difference is in 10e-4

    /*1.5*/
    /*
    Using double instead of floats leads to an slight increase in computation time, the precision is unchanged
    Using long double has the same effect.
    */

    unsigned long nb_threads = std::stoul(argv[2]); 
    test2(nb_points, nb_threads);
}