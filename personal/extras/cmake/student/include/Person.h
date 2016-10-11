//Person.h
#ifndef _PERSON_H
#define _PERSON_H

#include<string>

class Person{
protected:
	std::string name;
public:
	Person(std::string);
	virtual void display();
};

#endif
