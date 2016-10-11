#include<string>
#include "Person.h"

class Student : public Person{
private:

public:
        Student(std::string);
        virtual std::string takeTest(string test);
};
