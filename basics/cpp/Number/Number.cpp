#include <exception>
#include <iomanip>
#include <iostream>
#include <string>
#include <utility>

#include "Number.hpp"


Number * factorielle(unsigned int i) {
    // why not use Number instead of pointer ?
    // dynamic allocation needed then ?
    Number *n{new Number{1}};
    for (int k{1}; k<=i; k++) {
        *n *= k;
    }
    
    return n;
}
