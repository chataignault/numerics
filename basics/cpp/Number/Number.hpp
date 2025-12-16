#ifndef NUMBER_HPP_INCLUDED
#define NUMBER_HPP_INCLUDED

#include <iostream>
#include <string>
#include <utility>

class Number {
public:
    // Constructeur
    Number( unsigned long l ) { 
        this->first_ = new Digit(l); // initialise first_ that is the only attribute of Number
    }
    // Destructeur
    ~Number() { 
        delete first_;
     }
    
    // Constructeur de copie
    Number( const Number & n) {
        first_ = new Digit( *n.first_ );
    }

    void swap( Number & n) {
        std::swap(first_, n.first_);
    }

    Number & operator=( const Number & n) {
        Number temp{n}; //construction de la copie
        swap(temp);
        return *this;
    }

    // operateur+
    /*
    // utiliser constructeur de copie puis
    // utiliser constructeur +=
    */
 
    void print( std::ostream & out ) const { 
        this->first_->print( out );
     }

    Number & operator+=(unsigned int n) { 
        /*
        & means we pass the reference of the argument and not the object itself
        avoids problems of partage et corruption de representation
        */ 
        this->first_->add(n);
        return *this; // returns a reference otherwise it creates a copy
        // this est un pointeur sur moi
    }

    Number & operator*=( unsigned int n ) {
        this->first_->multiply(n);
        return *this;
    }

    Number & operator+( unsigned int i ) {
        static Number m = *this;
        m += i;
        return m;
    }

    Number & operator*( unsigned int i ) {
        static Number m = *this;
        m *= i;
        return m;
    }

private:
    using DigitType = unsigned int;
    // Un seul chiffre décimal par maillon : l'objectif ici n'est pas la performance
    static const DigitType number_base{ 10u };
    struct Digit {
        DigitType digit_;
        Digit * next_;

        // constructeur
        Digit( unsigned long l ) { // recursive constructor
            DigitType r{ l % number_base };
            this->digit_ = r ;
            this->next_ = nullptr;
            if(l >= number_base) {
                this->next_ = new Digit{l/number_base}; // dynamic allocation, new returns the adress of the object
            }
        }
        // destructeur
        ~Digit(){
            if (next_ != nullptr) {
                delete next_; // recursive by construction 
            } 
        }

        // constructeur de copie
        Digit(const Digit & d) {
            digit_ = d.digit_;
            if (d.next_ == nullptr) next_ = nullptr;
            else next_ = new Digit( *d.next_ );
        }
        
        // surcharge de l'operateur d'affectation
        Digit & operator=( const Digit &d ) {
            Digit temp{d};
            swap(temp); // to define for Digit
            return *this;
        }

        void swap(Digit & d) {
            std::swap(next_, d.next_);
            std::swap(digit_, d.digit_);
        }

        void print( std::ostream & out ) {
            if (this->next_ != nullptr) {
                this->next_->print(out);
            }
            out << this->digit_;
        }

        void add(unsigned int n) {
            // new value for the digit
            unsigned int value{this->digit_ + n}; 
            // update digit value
            this->digit_ =  value % number_base;
            // if there is a residue
            if (value >= number_base) {
                if (this->next_ == nullptr) {
                    this->next_ = new Digit(value/number_base);
                }
                else this->next_->add(value/number_base);
            }
            // build one with k if its larger than number base and add it 
        }

        void multiply( unsigned int n, unsigned int carry=0 ) {
            unsigned int value{ n*this->digit_ + carry};
            this->digit_ = value % number_base;
            if (this->next_ == nullptr) {
                if (value >= number_base) {
                    this->next_ = new Digit(value/number_base);
                }
            }
            else this->next_->multiply(n, value/number_base);
            
        }
    };
        
    Digit * first_;
};

inline std::ostream & operator<<( std::ostream & out, const Number & n )
{
    n.print( out );
    return out;
}

Number * factorielle(unsigned int n);

#endif
