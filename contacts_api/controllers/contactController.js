const asyncHandler = require("express-async-handler");
const Contact = require("../models/contactModel.js");
const { constants } = require("../constants");
//@desc get all contacts
//@route GET /api/contacts
//@access public
const getAllContacts = asyncHandler(async (req, res) => {
    const contact = await Contact.find();
    res.json(contact);
    // res.json({ message: "Get all contacts " });
});

//@desc get a contact
//@route GET /api/contacts/:id
//@access public
const getContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findById(req.params.id);
    if (!contact) {
        res.status(constants.NOT_FOUND);
        throw new Error("Contact not found");
    }
    res.json(contact);
});

//@desc create a contact
//@route POST /api/contacts
//@access public
const createContact = asyncHandler(async (req, res) => {
    console.log(req.body);
    const { name, email, phone } = req.body;
    if (!name || !email || !phone) {
        res.status(400);
        throw new Error("All parameters are needed !");
    }
    const contact = await Contact.create(
        {
            name,
            email,
            phone
        }
    );
    res.json(contact);
});

//@desc update a contact
//@route PUT /api/contacts/:id
//@access public
const updateContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findById(req.params.id);
    if (!contact) {
        res.status(contact.NOT_FOUND);
        throw new Error("Contact not found");
    }
    const updatedContact = await Contact.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
    );
    res.json(updatedContact);
});

//@desc delete a contact
//@route DELETE /api/contacts/:id
//@access public
const deleteContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findByIdAndDelete(req.params.id);
    if (!contact) {
        res.status(constants.NOT_FOUND);
        throw new Error("Contact not found !");
    }
    res.json(contact);
});

module.exports = {
    getAllContacts,
    getContact,
    createContact,
    updateContact,
    deleteContact,
};