const asyncHandler = require("express-async-handler");
const User = require("../models/userModel.js");
const { constants } = require("../constants");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
//@desc register an user
//@route POST /api/users/register
//@access public
const registerUser = asyncHandler(async (req, res) => {
    const { name, email, password } = req.body;
    if (!name || !email || !password) {
        res.status(constants.VALIDATION_ERROR);
        throw new Error("All fields are mandatory !");
    }
    const validateUser = await User.findOne({ email });
    if (validateUser) {
        res.status(constants.VALIDATION_ERROR);
        throw new Error("Email already registered !");
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = await User.create({
        name,
        email,
        password: hashedPassword,
    });
    if (newUser) {
        res.status(201).json({ _id: newUser.id, name: name, email: email });
    } else {
        res.status(400);
        throw new Error("The data is not valid!");
    }
});

//@desc login user
//@route POST /api/users/login
//@access public
const loginUser = asyncHandler(async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error("All field are madatory !");
    }
    const user = (await User.findOne({ email }));
    if (user && await bcrypt.compare(password, user.password)) {
        const loginToken = await jwt.sign({
            user: {
                name: user.name,
                email: user.email,
                id: user.id,
            }
        },
            process.env.ACCESS_TOKEN_SECRET,
            {
                expiresIn: "1m",
            }
        );
        res.status(200).json({ loginToken });
    } else {
        res.status(401);
        throw new Error("The credentials are not valid !");
    }
});

//@desc get user
//@route GET /api/users/current
//@access private 
const currentUser = asyncHandler(async (req, res) => {
    res.json({ user: req.user });
});

module.exports = {
    registerUser,
    loginUser,
    currentUser
};