/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences - Campus de Paris-Saclay
 * 3MD1080 – C++ - TD n°3
 * https://wdi.centralesupelec.fr/3MD1080/TD3
 *
 *
 * c++ -std=c++20 -o td3 td3.cpp
 * ./td3
 */


#include <algorithm>
#include <fstream>
#include <iostream>
#include <iterator>
#include <map>
#include <string>
#include <vector>

#include <boost/accumulators/accumulators.hpp>
#include <boost/accumulators/statistics/max.hpp>
#include <boost/accumulators/statistics/mean.hpp>
#include <boost/accumulators/statistics/min.hpp>
#include <boost/accumulators/statistics/stats.hpp>
#include <boost/algorithm/string/classification.hpp>
#include <boost/algorithm/string/split.hpp>


// Définir un agrégat Measure permettant de stocker les données d'une mesure
struct Measure {
    int year;
    int month;
    int day;
    int hour;
    float temperature;

    Measure::Measure(std::string line);

};

// Définir un constructreur pour Measure recevant une chaîne de caractères et l'utilisant 
// pour initialiser les attributs ; on supposera que l'argument reçu respecte le format 
// CSV spécifié
Measure::Measure(std::string data) {
    std::vector< std::string > parts;
    boost::algorithm::split( parts, data, boost::is_any_of( ";"));
    year        = std::stoi( parts[0] );
    month       = std::stoi( parts[1] );
    day         = std::stoi( parts[2] );
    hour        = std::stoi( parts[3] );
    temperature = std::stod( parts[4] );
};

// Définir dans main() une variable du bon type pour mémoriser les données lues
int main( int argc, char * argv[] )
{
    // Measure m("2019;2;9;19;12.2")
    // std::cout << "year: " << m.year << std::endl;
    // std::cout << "month: " << m.month << std::endl;
    // std::cout << "day: " << m.day << std::endl;
    // std::cout << "hour: " << m.year << std::endl;
    // std::cout << "temperature: " << m.temperature << std::endl;

    std::vector< Measure > measures;
    std::ifstream data("temperatures.csv");
    // flux d'entree peut etre considere comme un conteneur dont on va pouvoir faire la copie
    std::copy(
        std::istream_iterator< std::string >( data ), // iterateur de debut
        std::istream_iterator< std::string >(), // iterateur de fin
        std::back_inserter( measures )
    );

    // std::cout << "count: " << measures.size() << std::endl;
    // std::cout << "year: " << measuers[0].year << std::endl;
    // std::cout << "month: " << measuers[0].month << std::endl;
    // std::cout << "day: " << measuers[0].day << std::endl;
    // std::cout << "hour: " << measuers[0].year << std::endl;
    // std::cout << "temperature: " << measuers[0].temperature << std::endl;
    
    namespace acc = boost::accumulators;
    using MonthAccumulator = acc::accumulator_set<double, acc::stats< acc::tag::mean, acc::tag::min, acc::tag::max >>; // defini un type

    // stats sur l'ensemble des données
    // MonthAccumulator all;
    // // for_each (slide 150)
    // for( const auto & m: measures ) all( m.temperature );
    // std::cout << "Mean: " << acc::mean( all ) << std::endl;

    std::map< int, MonthAccumulator > statistics;
    auto key_year_month = [](const Measure & m) {return m.year * 12 + m.month - 1;};
    auto month_from_key = []( int key ) {return key%12 +1;}; 
    auto year_from_key = []( int key ) {return ke/%12;};
    

}
