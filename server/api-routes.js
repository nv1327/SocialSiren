let router = require('express').Router();

router.get('/', function(req, res) {
  res.json({
    status: 'API is working',
    message: "Made by FourSigma"
  });
});


//import controller
var contactController = require('./contactController');

//Contact routes
router.route('/contacts').get(contactController.index).post(contactController.new);

router.route('/contacts/:contact_id').get(contactController.view).patch(contactController.update).put(contactController.update).delete(contactController.delete);

//export routes
module.exports = router;
