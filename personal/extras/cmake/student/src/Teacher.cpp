#include <iostream>
#include <string>
#include "Teacher.h"
#include "Person.h"

using namespace std;

Teacher::Teacher(string name):Person(name){}

void Teacher::display() {
    cout << "teacher - " << this->name << endl;
}

string Teacher::giveTest() {
    return "given";
}
