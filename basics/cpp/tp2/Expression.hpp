/*
 * Cursus CentraleSupélec - Dominante Mathématiques et Data Sciences
 * 3MD1080 - C++ - TP n°2
 *
 * Expression.hpp
 */

#ifndef EXPRESSION_HPP_INCLUDED
#define EXPRESSION_HPP_INCLUDED

#include <iostream>
#include <string>
#include <utility>
#include <memory>
#include <typeinfo>


class Expression {
public:
    Expression() {++nombre_instances_; };
    virtual ~Expression() {--nombre_instances_; };
    Expression(const Expression & e) {++nombre_instances_;};
    virtual void print( std::ostream & out ) const = 0; // virtual precise qu'il faut aller chercher la methode dans les sous classes

    // retourne une nouvelle expression qui représente la dérivée de l'expression courante
    // cette nouvelle expression retournée est allouée dynamiquement
    // l'expression courante n'est pas modifiée ce qui se traduit par le tag const en fin de definition
    virtual Expression * derive( std::string var ) const = 0; // const : on ne modifie pas l'expression courante
    static int nb_instances() {return nombre_instances_; }
    virtual Expression * clone() = 0;
private:
    static int nombre_instances_;
};

inline std::ostream & operator<<( std::ostream & out, const Expression & e ) {
    e.print( out );
    return out;
} // on met pas dans la classe Expression car la premiere operande est un objet de la bibliotheque standard qu'on ne peut pas modifier


class Nombre : public Expression {
public:
    Nombre( double valeur ) : valeur_{ valeur } {} // on intitialise valeur_ à valeur, dans les crochets on peut mettre les affectations (y=5 p ex)
    Nombre( const Nombre & n) {
        valeur_ = n.valeur_;
    }

    double valeur() const {return valeur_ ; }

    void print( std::ostream & out ) const { 
        out << valeur_;
    }

    Nombre * derive( std::string var ) const {
        return new Nombre( 0 );
    }
    Expression * clone() {
        return new Nombre(this->valeur_);
    }
private:
    double valeur_;
};


class Variable : public Expression {
public:
    Variable( std::string nom) : nom_{ nom } {}
    Variable( const Variable & v) { nom_ = v.nom_; }

    void print( std::ostream & out ) const { 
        out << nom_;
    }

    std::string nom() const {return nom_; }

    Nombre * derive( std::string var ) const {
        if (var == nom()) return new Nombre( 1 );
        return new Nombre( 0 );
    }
    Expression * clone() {
        return new Variable(this->nom_);
    }
private:
    std::string nom_;
};

// les operandes doivent appartenir de maniere unique a chaque instance d'operation pour gerer la creation et la destruction proprement
// on utilise pour cela l'allocation dynamique qui justifie le typage des operandes en pointeurs sur des expressions
class Operation : public Expression {
public:
    Operation(Expression * op_gauche, Expression * op_droit) : op_gauche_{op_gauche}, op_droit_{op_droit} {};
    ~Operation() {
        delete op_gauche_;
        delete op_droit_;
    }
    Operation(const Operation & o) : Expression(o) {
        op_droit_ = o.op_droit_->clone();
        op_gauche_ = o.op_gauche_->clone();
    }
    Expression * derive( std::string var ) const = 0;
    virtual void print_symbole( std::ostream & out ) const = 0;
    void print( std::ostream & out ) const {
        out << *op_gauche_;
        print_symbole( out );
        out << *op_droit_;
    }; 
protected: // protection intermediaire qui donne acces dans la classe et dans les sous classes
    Expression * op_gauche_;
    Expression * op_droit_;
};


class Addition : public Operation {
public:
    Addition(Expression * op_gauche, Expression * op_droit) : Operation(op_gauche, op_droit) {};
    Addition( const Addition & other ) : Operation(other) {};
    void print_symbole( std::ostream & out ) const {
        out << "+";
    }
    Expression * derive( std::string var ) const {
        return new Addition(op_gauche_->derive( var ), op_droit_->derive( var ));
    }
    Expression * clone() {
        return new Addition(this->op_gauche_->clone(), this->op_droit_->clone());
    }
};


class Multiplication : public Operation {
public:
    Multiplication(Expression * op_gauche, Expression * op_droit) : Operation(op_gauche, op_droit) {};
    Multiplication(const Multiplication & other) : Operation(other) {} ;
    void print_symbole( std::ostream & out ) const {
        out << "*";
    }
    Expression * derive( std::string var ) const {
        return new Addition(new Multiplication(op_gauche_->derive(var), op_droit_->clone()), new Multiplication(op_gauche_->clone(), op_droit_->derive(var)));
    }
    Expression * clone() {
        return new Multiplication(this->op_gauche_->clone(), this->op_droit_->clone());
    }
};


/*********************************************************************SMART POINTERS**************************************************************/

template<typename Base, typename T>
inline bool instanceof(const T el) {
return dynamic_cast<const Base>(el) != nullptr;
}

class SmartExpression {
public:
    SmartExpression() {++nombre_instances_; };
    virtual ~SmartExpression() {--nombre_instances_; };
    SmartExpression(const SmartExpression & e) {++nombre_instances_;};
    virtual void print( std::ostream & out ) const = 0; 
    virtual std::shared_ptr<SmartExpression> derive( std::string var ) const = 0; 
    static int nb_instances() {return nombre_instances_; }
    
private:
    static int nombre_instances_;
};

inline std::ostream & operator<<( std::ostream & out, const SmartExpression & e ) {
    e.print( out );
    return out;
} 

using shared_expr = std::shared_ptr<SmartExpression>;

class SmartNombre : public SmartExpression{ 
public:
    SmartNombre( double valeur ) : valeur_{ valeur } {} 
    SmartNombre( const SmartNombre & n) {
        valeur_ = n.valeur_;
    }
    double valeur() const {return valeur_ ; }
    void print( std::ostream & out ) const { 
        out << valeur_;
    }
    shared_expr derive( std::string var ) const {
        return std::make_shared<SmartNombre>(SmartNombre(0));  
    }
private:
    double valeur_;
};


class SmartVariable : public SmartExpression {
public:
    SmartVariable( std::string nom) : nom_{ nom } {}
    SmartVariable( const SmartVariable & v) { nom_ = v.nom_; }
    void print( std::ostream & out ) const { 
        out << nom_;
    }
    std::string nom() const {return nom_; }
    shared_expr derive( std::string var ) const {
        if (var == nom()) return  std::make_shared<SmartNombre>(SmartNombre( 1 ));
        return std::make_shared<SmartNombre>(SmartNombre( 0 ));
    }
private:
    std::string nom_;
};


class SmartOperation : public SmartExpression {
public:
    SmartOperation(shared_expr op_gauche, shared_expr op_droit) : op_gauche_{op_gauche}, op_droit_{op_droit} {};
    ~SmartOperation() {}

    template<typename A, typename B>
    SmartOperation(A op_gauche, B op_droit) {
        shared_expr op_gauche_ptr{std::make_shared<A>(op_gauche)};
        shared_expr op_droite_ptr{std::make_shared<B>(op_droite)};
        op_droit_ = op_droit_;
        op_gauche_ = op_gauche_;
    }

    SmartOperation(const SmartOperation & o) : SmartExpression(o) {
        op_droit_ = o.op_droit_;
        op_gauche_ = o.op_gauche_;
    }
    shared_expr derive( std::string var ) const = 0;
    virtual void print_symbole( std::ostream & out ) const = 0;
    void print( std::ostream & out ) const {
        out << *op_gauche_;
        print_symbole( out );
        out << *op_droit_;
    }; 
protected:
    shared_expr op_gauche_;
    shared_expr op_droit_;
};


class SmartAddition : public SmartOperation {
public:
    SmartAddition(shared_expr op_gauche, shared_expr op_droit) : SmartOperation(op_gauche, op_droit) {};
    template<typename A, typename B>
    SmartAddition(A op_gauche, B op_droit) : SmartOperation(op_gauche, op_droit) {};
    SmartAddition( const SmartAddition & other ) : SmartOperation(other) {};
    void print_symbole( std::ostream & out ) const {
        out << "+";
    }
    shared_expr derive( std::string var ) const {

        // filter on Nombres
        if ( (typeid(*op_gauche_) == typeid(SmartNombre)) && (typeid(*op_droit_) == typeid(SmartNombre))) return std::make_shared<SmartNombre>(0);
        if ( (typeid(*op_gauche_) == typeid(SmartVariable)) && (typeid(*op_droit_) == typeid(SmartNombre))) return std::make_shared<SmartNombre>(1);

        // filter on Variables
        if ( (typeid(*op_gauche_) == typeid(SmartNombre)) && (typeid(*op_droit_) == typeid(SmartVariable))) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_droit_); 
            if (tmp_var_ptr->nom() == var) return std::make_shared<SmartNombre>(1);
            else return std::make_shared<SmartNombre>(0);
        }
        if ( (typeid(*op_droit_) == typeid(SmartNombre)) && (typeid(*op_gauche_) == typeid(SmartVariable))) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_gauche_); 
            if (tmp_var_ptr->nom() == var) return std::make_shared<SmartNombre>(1);
            else return std::make_shared<SmartNombre>(0);
        }

        // filter on other trivial cases 
        if ( typeid(*op_droit_) == typeid(SmartNombre)) return op_gauche_->derive( var );
        if ( typeid(*op_gauche_) == typeid(SmartNombre)) return op_droit_->derive( var );
        if ( typeid(*op_droit_) == typeid(SmartVariable)) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_droit_); 
            if (tmp_var_ptr->nom() == var) return std::make_shared<SmartAddition>(SmartAddition(op_gauche_->derive( var ), std::make_shared<SmartNombre>(1)));
            else return op_gauche_->derive( var );
        }
        if ( typeid(*op_gauche_) == typeid(SmartVariable)) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_gauche_); 
            if (tmp_var_ptr->nom() == var) return std::make_shared<SmartAddition>(SmartAddition(std::make_shared<SmartNombre>(1), op_droit_->derive( var )));
            else return op_droit_->derive( var );
        }

        return std::make_shared<SmartAddition>(SmartAddition(op_gauche_->derive( var ), op_droit_->derive( var )));
    }
};


class SmartMultiplication : public SmartOperation {
public:
    SmartMultiplication(shared_expr op_gauche, shared_expr op_droit) : SmartOperation(op_gauche, op_droit) {};
    SmartMultiplication(const SmartMultiplication & other) : SmartOperation(other) {} ;
    template<typename A, typename B>
    SmartMultiplication(A op_gauche, B op_droit) : SmartOperation(op_gauche, op_droit) {};
    void print_symbole( std::ostream & out ) const {
        out << "*";
    }
    shared_expr derive( std::string var ) const {
        if ( (typeid(*op_gauche_) == typeid(SmartVariable)) && (typeid(*op_droit_) == typeid(SmartNombre))) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_gauche_); 
            if (tmp_var_ptr->nom() == var) return op_droit_;
            else return std::make_shared<SmartNombre>(0);
        }
        if ( (typeid(*op_droit_) == typeid(SmartVariable)) && (typeid(*op_gauche_) == typeid(SmartNombre))) {
            auto tmp_var_ptr = std::dynamic_pointer_cast<SmartVariable>(op_droit_); 
            if (tmp_var_ptr->nom() == var) return op_gauche_;
            else return std::make_shared<SmartNombre>(0);
        }
        return std::make_shared<SmartAddition>(SmartAddition(std::make_shared<SmartMultiplication>(SmartMultiplication(op_gauche_->derive(var), op_droit_)), std::make_shared<SmartMultiplication>(SmartMultiplication(op_gauche_, op_droit_->derive(var)))));
    }
};

/*
On est obligé de recréer des Nombres et Variables car on ne sait pas si ils ont déjà été créés ni comment connaitre quel shared_ptr pointe déjà dessus.
Pour remedier à ce problème on pourrait garder en mémoire dans la classe Expression quelles constantes et variables existent deja.
On pourrait l'implémenter en utilisant un dictionnaire avec l'objet comme clé (int valeur_ ou char nom_ de manière équivalente) et avec comme valeur un shared_ptr représentant pointant vers l'objet.
En vérifiant l'existance de la clé dans le dictionnaire on fait soit une copie du pointeur, soit on créé l'objet et on ajoute l'élément au dictionnaire.
*/

#endif

