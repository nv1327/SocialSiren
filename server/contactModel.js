var mongoose = require('mongoose');


var contactSchema = mongoose.Schema({
/*
  uid: {
    type: String,
    required: true
  },*/
  sick: {
    type: String,
    required: true
  },
  lat: {
    type: String,
    required: true
  },
  long: {
    type: String,
    required: true
  },
  create_date: {
    type: Date,
    default: Date.now
  }
});


var Contact = module.exports = mongoose.model('contact', contactSchema);

module.exports.get = function(callback, limit) {
  Contact.find(callback).limit(limit);
}
