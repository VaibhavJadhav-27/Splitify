import express from "express"
import cors from "cors"
import { apiLimiter } from "./middleware/rate_limiter.js";



//declaring app
const app = express()

// Tell express to trust reverse proxies (like Render, Nginx, etc.)
app.set("trust proxy", 1); // 1 = trust first proxy (safe default)

//middlewares
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  //allowedHeaders: ["Content-Type", "Authorization"],
  credentials: true
}));
app.use(express.json());

//Apply rate limiting middleware
app.use(apiLimiter);


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