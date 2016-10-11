#include <iostream>
#include"Student.h"
#include "Teacher.h"

using namespace std;

int main(int argc, char *argv[]){

    cout << "-------" << endl;
    Student s("Joe");
    s.display();
    s.takeTest("what is the sound of sound?");

    Teacher t("Sam");

    t.display();

    Student joel("asfdsa");



    cout << "-------" << endl;
    return 0;

}
