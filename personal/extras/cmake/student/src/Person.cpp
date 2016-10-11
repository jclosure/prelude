#include <iostream>
#include <string>
#include "Person.h"
using namespace std;

Person::Person(string name):name(name){}

void Person::display() {
    cout << this->name << endl;
}
