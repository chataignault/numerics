// What is this header for ?
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

    Measure(std::string line);

};

// Définir un constructreur pour Measure recevant une chaîne de caractères et l'utilisant 
// pour initialiser les attributs ; on supposera que l'argument reçu respecte le format 
// CSV spécifié
Measure::Measure(std::string data) {
    std::vector< std::string > parts;
    boost::algorithm::split(parts, data, boost::is_any_of(";"));
    year = std::stoi(parts[0]);
    month = std::stoi(parts[1]);
    day = std::stoi(parts[2]);
    hour = std::stoi(parts[3]);
    temperature = std::stod(parts[4]);
};
