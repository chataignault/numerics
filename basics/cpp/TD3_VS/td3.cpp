/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences - Campus de Paris-Saclay
 * 3MD1080 – C++ - TD n°3
 * https://wdi.centralesupelec.fr/3MD1080/TD3
 *
 *
 * c++ -std=c++20 -o td3 td3.cpp
 * ./td3
 */



#include "td3.h"




// Définir dans main() une variable du bon type pour mémoriser les données lues
int main( int argc, char * argv[] )
{
     //Measure m("2019;2;9;19;12.2");
     //std::cout << "year: " << m.year << std::endl;
     //std::cout << "month: " << m.month << std::endl;
     //std::cout << "day: " << m.day << std::endl;
     //std::cout << "hour: " << m.year << std::endl;
     //std::cout << "temperature: " << m.temperature << std::endl;

    std::vector< Measure > measures;
    std::ifstream data("temperatures.csv");
    // flux d'entree peut etre considere comme un conteneur dont on va pouvoir faire la copie
    std::copy(
        std::istream_iterator< std::string >( data ), // iterateur de debut
        std::istream_iterator< std::string >(), // iterateur de fin
        std::back_inserter( measures )
    );

     std::cout << "count: " << measures.size() << std::endl;
     std::cout << "year: " << measures[0].year << std::endl;
     std::cout << "month: " << measures[0].month << std::endl;
     std::cout << "day: " << measures[0].day << std::endl;
     std::cout << "hour: " << measures[0].year << std::endl;
     std::cout << "temperature: " << measures[0].temperature << std::endl;
    
    namespace acc = boost::accumulators;
    using MonthAccumulator = acc::accumulator_set<double, acc::stats< acc::tag::mean, acc::tag::min, acc::tag::max >>; // defini un type


    // stats sur l'ensemble des données
    std::map< int, MonthAccumulator > statistics;
    auto key_year_month = [](const Measure & m) {return m.year * 12 + m.month - 1;};
    auto month_from_key = []( int key ) {return key%12 +1;}; 
    auto year_from_key = []( int key ) {return key/12;};   
    for ( const auto & m: measures ) {
        if (statistics.count(key_year_month(m)) == 0) {
            statistics[key_year_month(m)] = MonthAccumulator{};
        }        statistics[key_year_month(m)](m.temperature);
    }

    // display the results
    for (const auto & [key, value] : statistics) {
        std::cout << month_from_key(key) << "-" << year_from_key(key) << " min: "
            << acc::min(value) << " max: " << acc::max(value)
            << " moy: " << acc::mean(value) << "\n";
    }


}
