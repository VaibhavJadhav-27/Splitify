import express from "express"
import cors from "cors"



//declaring app
const app = express()
app.use(express.json());


//routes imports
import userRoutes from "./routes/users.route.js";
import groupRoutes from "./routes/group.route.js";
import tokenRoutes from "./routes/token.route.js";
import statusRoutes from "./routes/status.route.js";

//routes declaration
app.use("/api/v1/users", userRoutes);
app.use("/api/v1/group", groupRoutes);
app.use("/api/v1/token", tokenRoutes);
app.use("/api/v1/status", statusRoutes);


//export app
export { app }