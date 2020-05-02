

//https://medium.com/@dinyangetoh/how-to-build-simple-restful-api-with-nodejs-expressjs-and-mongodb-99348012925d
//this was essential!!!
//use postman and try it!
//I also got some help from Dev Ed on YouTube with the .env and how to understand the packages


const express = require('express');
const app = express();
const mongoose = require('mongoose');
//const fs = require('fs');
const bodyparser = require('body-parser');
//this is just to hide the database credentials from Github. The MongoDB Atlas link would go where process.env.DB_CONNECT is right now
const dotenv = require('dotenv');
dotenv.config();


//Connect to DB
mongoose.connect(
  process.env.DB_CONNECT,
  { useNewUrlParser: true },
	() => console.log('Connected to MongoDB Atlas')

);

var db = mongoose.connection;


//middleware
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));
let apiRoutes = require('./api-routes');
app.use('/api', apiRoutes);





//how to listen to the server
app.listen(7000); //listening to port 3000
