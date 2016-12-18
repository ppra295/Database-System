# 1. Insert an object containing name of 'Eric', age of 25 and position of 'lecturer' to users collection

db.users.insert(
{ 
"name": "Eric",
" age":  25,
"position": "lecturer"
}
)

# 2. Insert another user object containing name of 'Alice', age of 20, position of 'student' and grade of 84 to users collection

db.users.insert(
{
"name": "Alice",
"age": 20,
"position":  "Student",
"grade": 84
}
)

# 3.Insert another user object containing name of 'Bob', age of 21, position of 'student' and grade of 89 to users collection

db.users.insert(
{
"name": "Bob",
"age": 21,
"position":  "Student",
"grade": 89
}
)

#4.Find all documents under users collection

db.users.find()

#5.Find user name of 'Eric'

db.users.find({ "name": "Eric" })

#6.Find users of age between 20 to 23 (inclusive)

db.users.find({"age": {$gt:20} , "age": {$lt:23}})

#7.Update user object of 'Alice' to grade 95

db.users.update(
{"name": "Alice"},
{ $set:{ " grade": 95}}
)

#8.Delete user 'Bob'

db.users.remove( {"name":  " Bob"} )


#9.Update user of position 'student' to have a new field called homeAddress containing of follwing json:

db.users.update(
{"position":  "Student"},
{ $set:{ homeAddress:
{ street: "1234 Random st.",
    city: "Los Angeles",
    state: "CA"},
	},
	},
	{ multi: true}
)


#10.Drop users collection

db.users.drop()


