#include<string>
#include "Person.h"

class Teacher : public Person{
private:

public:
	Teacher(std::string);

        void display() override;
        virtual std::string giveTest();
};
