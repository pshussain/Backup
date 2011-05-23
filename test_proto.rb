require 'tutorial.pb'
personArray=[]

person = Tutorial::Person.new
person.id = 1234
person.name = 'John Doe'
person.email = 'jdoe@example.com'
#~ phone = Tutorial::Person::PhoneNumber.new
#~ phone.number = '555-4321'
#~ phone.type = Tutorial::Person::PhoneType::HOME
#~ person.phone << phone
serialized_string = person.serialize_to_string
personArray<<personArray
 personArray.serialize_to_file('person.dat')
 
 
