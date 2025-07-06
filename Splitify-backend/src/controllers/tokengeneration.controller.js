import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { generateToken } from "../utils/token.js";

const createToken = async (req, res) => {
    // get user details from frontend
    // validation - not empty
    // check if user already exists: username, email
    // create user object - create entry in db
    // check for user creation
    // return res

    const {userId} = req.body;

    if (!userId) {
        throw new ApiError(400, "User ID is required");
    }

    const token = generateToken(userId);

    if (!token) {
        throw new ApiError(500, "Something went wrong while generating the token");
    } else {
        return res.status(201).json(
            new ApiResponse(200, {token}, "Token generated successfully")
        );
    }
};


export { createToken };