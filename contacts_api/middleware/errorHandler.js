const { constants } = require("../constants.js");
const erroHandler = (error, req, res, next) => {
    const statusCode = res.statusCode ? res.statusCode : constants.SERVER_ERROR;
    switch (statusCode) {
        case constants.VALIDATION_ERROR:
            res.json({
                title: "Validation Failed",
                error: error.message,
                stackTracer: error.stack
            });
            break;
        case constants.FORBIDDEN:
            res.json({
                title: "Forbidden",
                error: error.message,
                stackTracer: error.stack
            });
            break;
        case constants.UNAUTHORIZED:
            res.json({
                title: "Unauthorized",
                error: error.message,
                stackTracer: error.stack
            });
            break;
        case constants.NOT_FOUND:
            res.json({
                title: "Not Found",
                error: error.message,
                stackTracer: error.stack
            });
            break;
        case constants.SERVER_ERROR:
            res.json({
                title: "Server error",
                error: error.message,
                stackTracer: error.stack
            });
            break;
        default:
            console.log("No error, All good");
            break;
    }
}

module.exports = erroHandler;