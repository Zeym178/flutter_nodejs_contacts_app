const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        require: [true, "this field is madatory"]
    },
    email: {
        type: String,
        require: [true, "this field is madatory"]
    },
    password: {
        type: String,
        require: [true, "this field is mandatory"]
    }
}, {
    timestamps: true,
}
);

module.exports = mongoose.model("User", userSchema);