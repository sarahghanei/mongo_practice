Queries on restaurant data source.
{
  "address": {
     "building": "1007",
     "coord": [ -73.856077, 40.848447 ],
     "street": "Morris Park Ave",
     "zipcode": "10462"
  },
  "borough": "Bronx",
  "cuisine": "Bakery",
  "grades": [
     { "date": { "$date": 1393804800000 }, "grade": "A", "score": 2 },
     { "date": { "$date": 1378857600000 }, "grade": "A", "score": 6 },
     { "date": { "$date": 1358985600000 }, "grade": "A", "score": 10 },
     { "date": { "$date": 1322006400000 }, "grade": "A", "score": 9 },
     { "date": { "$date": 1299715200000 }, "grade": "B", "score": 14 }
  ],
  "name": "Morris Park Bake Shop",
  "restaurant_id": "30075445"
}

//display specific fields (include and exclude fields)
//db.restaurants.find({},{"restaurant_id" : 1,"name":1,"borough":1,"cuisine" :1, "_id":0});

//first 5 restaurants where bprough = Bronx
//db.restaurants.find({"borough":"Bronx"}).limit(5)
//skip the first 5 restaurants and display the next 5 restaurants where borough=Bronx
//db.restaurants.find({"borough":"Bronx"}).skip(5).limit(5)

//restaurants with the score more than 90, but not working IDK
//db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 90}}}},{"name":1,"grades":1, "_id":0})
//db.restaurants.find({"grades.score":{$gt:90}},{"name":1,"grades":1, "_id":0})

//restaurants that achieved a score, more than 80 but less than 100
//db.restaurants.find({"grades.score":{$gt:80,$lt:100 }},{"name":1,"grades":1, "_id":0})

//find the restaurants which locate in latitude value less than -95.754168
//db.restaurants.find({"address.coord":{$lt:-95.75416}},{"name":1,"address.coord":1, "_id":0})

//find the restaurants that do not prepare any cuisine of 'American' and their grade score more than 70 and latitude less than -65.754168
//db.restaurants.find(
//    {$and:
//        [
//            {"cuisine":{$ne:"American "}},
//            {"grades.score":{$gt:70}},
//            {"address.coord":{$lt:-65.754168}}
//        ]}
//
//,{"name":1,"address.coord":1,"cuisine":1, "_id":0})
//query without and
//db.restaurants.find(
//                           {
//                             "cuisine" : {$ne : "American "},
//                             "grades.score" :{$gt: 70},
//                             "address.coord" : {$lt : -65.754168}
//                            }
//                     );

//find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Wil' as first three letters for its name
//db.restaurants.find({"name":/^Wil/},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})
//db.restaurants.find({"name":{$regex:".*Wil.*"}},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})

// find the restaurant Id, name, borough and cuisine for those restaurants which contain 'ces' as last three letters for its name
//db.restaurants.find({"name":/ces$/},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})
//db.restaurants.find({"name":{$regex:".*ces$"}},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})

// find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Reg' as three letters somewhere in its name.
//db.restaurants.find({"name":{$regex:".*Reg.*"}},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})
//db.restaurants.find({"name":/.*Reg.*/},{"restaurant_id":1,"name":1, "borough":1,"cuisine":1, "_id":0})


//find the restaurants which belong to the borough Bronx and prepared either American or Chinese dish.
//db.restaurants.find({
//    "borough":"Bronx",
//    $or:[
//        {"cuisine":"American "},
//        {"cuisine":"Chinese"}
//    ]
//
//})

//find the restaurant Id, name, borough and cuisine for those restaurants which belong to the borough Staten Island or Queens or Bronxor Brooklyn.
//db.restaurants.find(
//{
//    "borough":{
//    $in:[
//        "Staten Island", "Queens","Bronx","Brooklyn"
//
//    ]
//    }
//
//},
//{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})

//find the restaurant Id, name, borough and cuisine for those restaurants which are not belonging to the borough Staten Island or Queens or Bronxor Brooklyn.
//db.restaurants.find(
//    { "borough":{
//        $nin:["Staten Island", "Queens","Bronx","Brooklyn"]
//    }},
//    {"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0}
//)

//find the restaurant Id, name, borough and cuisine for those restaurants which achieved a score which is not more than 10.
//db.restaurants.find({"grades.score":{$lte:10}},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1,"grades.score":1, "_id":0})
//db.restaurants.find({"grades.score":{$not:{$gt:10}}},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1,"grades.score":1, "_id":0})

//find the restaurant Id, name, borough and cuisine for those restaurants which prepared dish except 'American' and 'Chinees' or restaurant's name begins with letter 'Wil'
//db.restaurants.find(
//{$or:[
//    {"name":/^Wil/},   //{"name":{$regex:".*Wil.*"}
//    {$and:[
//        {"cuisine":{$ne:"American "}},
//        {"cuisine":{$ne:"Chinese"}}
//
//    ]}
//
//]},
//    {"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0}
//    )

//find the restaurant Id, name and grades for those restaurants where the 2nd element of grades array contains a grade of "A" and score 9 on an ISODate "2014-08-11T00:00:00Z"
//db.restaurants.find({
//    $and:[
//        {"grades.grade":"A"},
//        {"grades.score":9},
//        {"grades.date":ISODate("2014-08-11T00:00:00Z")}
//    ]
//},
//{"restaurant_id":1, "name":1, "borough":1, "grades":1, "_id":0})

//find the restaurant Id, name, address and geographical location for those restaurants where 2nd element of coord array contains a value which is more than 42 and upto 52.
//db.restaurants.find(
//    {$and:
//    [
//        {"address.coord.1":{$gte:42}},
//        {"address.coord.1":{$lte:52}}
//    ]
//    },
//    {"restaurant_Id":1, "name":1, "address.coord":1, "_id":0}
//)

//arrange the name of the restaurants in ascending order along with all the columns.
//db.restaurants.find().sort({"name":1})

//arrange the name of the restaurants in descending along with all the columns
//db.restaurants.find().sort({"name":-1})

//arrange the name of the cuisine in ascending order and for that same cuisine borough should be in descending order.
//db.restaurants.find().sort(
//{
//    "cuisine":1,
//    "borough":-1,
//});

//Write a MongoDB query to know whether all the addresses contains the street or not.
//db.restaurants.find({
//    "address.street":{$exists: true}
//},{"name":1, "address.street":1, "_id":0})

//Write a MongoDB query which will select all documents in the restaurants collection where the coord field value is Double.
//db.restaurants.find({"address.coord":{$type:1}},{"name":1, "address.coord":1, "_id":0})

//select the restaurant Id, name and grades for those restaurants which returns 0 as a remainder after dividing the score by 7.
//db.restaurants.find({"grades.score":{$mod:[7,0]}},{"restaurant_id":1,"name":1, "grades":1, "_id":0})

//find the restaurant name, borough, longitude and attitude and cuisine for those restaurants which contains 'mon' as three letters somewhere in its name.
//db.restaurants.find(
//{"name":{$regex:".*mon.*"}},
//{"name":1, "borough":1, "address.coord":1, "_id":0}
//)
//db.restaurants.find(
//{"name":/.*mon.*/},
//{"name":1, "borough":1, "address.coord":1, "_id":0}
//)

// find the restaurant name, borough, longitude and latitude and cuisine for those restaurants which contain 'Mad' as first three letters of its name.
//db.restaurants.find(
//{"name":{$regex:".Mad.*"}},
//{"name":1, "borough":1, "address.coord":1, "_id":0})
//db.restaurants.find(
//{"name":/.Mad.*/},
//{"name":1, "borough":1, "address.coord":1, "_id":0})
