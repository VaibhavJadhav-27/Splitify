import jwt from "jsonwebtoken";
import { Users } from "../models/users.model.js";
import { ApiError } from "../utils/ApiError.js";

export const auth = async (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return next(new ApiError(401, "No token provided"));
    }

    const token = authHeader.split(" ")[1];
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const user = await Users.findById(decoded.id);
        if (!user) {
            return next(new ApiError(401, "User not found"));
        }
        req.user = user;
        next();
    } catch (err) {
        return next(new ApiError(401, "Invalid or expired token"));
    }
};