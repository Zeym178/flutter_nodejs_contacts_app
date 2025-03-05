const express = require("express");
const router = express.Router();
const {
    registerUser,
    loginUser,
    currentUser
} = require("../controllers/userController.js");
const valideTokenHandler = require("../middleware/validateTokenHandler.js");

router.post("/register", registerUser);
router.post("/login", loginUser);
router.get("/current", valideTokenHandler, currentUser);

module.exports = router;