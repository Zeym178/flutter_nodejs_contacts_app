const asyncHandler = require("express-async-handler");
const Contact = require("../models/contactModel.js");
const { constants } = require("../constants");
//@desc get all contacts
//@route GET /api/contacts
//@access private
const getAllContacts = asyncHandler(async (req, res) => {
    const contact = await Contact.find({user_id: req.user.id});
    res.status(200).json(contact);
    // res.json({ message: "Get all contacts " });
});

//@desc get a contact
//@route GET /api/contacts/:id
//@access private
const getContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findById(req.params.id);
    if (!contact) {
        res.status(constants.NOT_FOUND);
        throw new Error("Contact not found");
    }

    if(contact.user_id.toString() != req.user.id) {
        res.status(403);
        throw new Error("The contacts it's not yours");
    }
    res.status(200).json(contact);
});

//@desc create a contact
//@route POST /api/contacts
//@access private
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
            phone,
            user_id: req.user.id
        }
    );
    res.status(201).json(contact);
});

//@desc update a contact
//@route PUT /api/contacts/:id
//@access private
const updateContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findById(req.params.id);
    if (!contact) {
        res.status(contact.NOT_FOUND);
        throw new Error("Contact not found");
    }

    if(contact.user_id.toString() != req.user.id) {
        res.status(403);
        throw new Error("The contacts it's not yours");
    }

    const updatedContact = await Contact.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true }
    );
    res.status(200).json(updatedContact);
});

//@desc delete a contact
//@route DELETE /api/contacts/:id
//@access private
const deleteContact = asyncHandler(async (req, res) => {
    const contact = await Contact.findById(req.params.id);
    if (!contact) {
        res.status(constants.NOT_FOUND);
        throw new Error("Contact not found !");
    }

    if(contact.user_id.toString() != req.user.id) {
        res.status(403);
        throw new Error("The contacts it's not yours");
    }

    await contact.deleteOne({_id: req.params.id});

    res.status(200).json(contact);
});

module.exports = {
    getAllContacts,
    getContact,
    createContact,
    updateContact,
    deleteContact,
};