const express = require("express");
const erroHandler = require("./middleware/errorHandler.js");
const connectDB = require("./config/dbConnection.js");
const dotenv = require("dotenv").config();

connectDB();
const app = express();

const port = process.env.PORT;

app.use(express.json());
app.use("/api/contacts", require("./routes/contactroutes.js"));
app.use("/api/users", require("./routes/usersrouters.js"));
app.use(erroHandler);

app.listen(port, () => {
    console.log(`Server running in port: ${port}`);
});