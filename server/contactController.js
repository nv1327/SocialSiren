Contact = require('./contactModel');


exports.index = function(req, res) {
  Contact.get(function (err, contacts) {
    if (err) {
      res.json({
        status: "error",
        message: err
      });
    }
    res.json({
      status: "success",
      message: "Contacts retrieved successfully",
      data: contacts
    });
  });
};


exports.new = function(req, res) {
  var contact = new Contact();
  //contact.uid = req.body.uid ? req.body.uid : contact.uid;
  contact.sick = req.body.sick;
  contact.lat = req.body.lat;
  contact.long = req.body.long;


  contact.save(function (err) {
    if (err)
      res.json(err);

    res.json({
      message: "New contact created",
      data: contact
    });
  });
};


//handle view contact info
exports.view = function(req, res) {
  Contact.findById (req.params.contact_id, function(err, contact) {
    if(err)
      res.send(err);
    res.json({
      message: "Contact details loading...",
      data: contact
    });
  });
};





exports.update = function(req, res) {
  Contact.findById(req.params.contact_id, function(err, contact) {
    if(err)
      res.send(err);

    //contact.uid = req.body.uid ? req.body.uid : contact.uid;
    contact.sick = req.body.sick;
    contact.lat = req.body.lat;
    contact.long = req.body.long;

    contact.save(function(err) {
      if(err)
        res.json(err);
      res.json({
        message: "Contact Info updated",
        data: contact
      });
    });
  });
};




exports.delete = function(req, res) {
  Contact.remove({
    _id: req.params.contact_id
  }, function(err, contact) {
    if(err)
      res.send(err);

    res.json({
      status: "Success",
      message: "Contact deleted"
    });
  });
};
