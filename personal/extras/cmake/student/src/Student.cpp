#include <iostream>
#include <string>
#include "Student.h"
#include "Person.h"
using namespace std;

Student::Student(string name):Person(name){}


string Student::takeTest(string test) {
    return "pass";
}
