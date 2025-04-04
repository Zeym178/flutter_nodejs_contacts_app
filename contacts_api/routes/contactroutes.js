const express = require("express");
const router = express.Router();
const {
    getAllContacts,
    getContact,
    createContact,
    updateContact,
    deleteContact,
} = require("../controllers/contactController.js");
const valideTokenHandler = require("../middleware/validateTokenHandler.js");

router.use(valideTokenHandler);

router.route("/").get(getAllContacts).post(createContact);

router.route("/:id").get(getContact).put(updateContact).delete(deleteContact);

module.exports = router;