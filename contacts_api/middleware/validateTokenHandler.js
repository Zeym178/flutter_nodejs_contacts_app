const express = require("express");
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");

const valideTokenHandler = asyncHandler(async(req, res, next) =>{
    let token;
    const userHeader = req.headers.Authorization || req.headers.authorization;
    if(userHeader && userHeader.startsWith("Bearer")) {
        token = userHeader.split(" ")[1];
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (error, decoded) => {
            if(error) {
                res.status(401);
                throw new Error("User Unathorized");
            }
            req.user = decoded.user;
            next();
        });
        if(!token) {
            res.status(401);
            throw new Error("User Unathorized or there's not token");
        }
    } else {
        res.status(401);
        throw new Error("There's not token included ");
    }
});

module.exports = valideTokenHandler;