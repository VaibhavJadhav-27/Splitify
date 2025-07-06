import { Users } from "../models/users.model.js";
import {asyncHandler} from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { generateToken } from "../utils/token.js";

const registerUser = asyncHandler( async(req, res) => {
    // get user details from frontend
    // validation - not empty
    // check if user already exists: username, email
    // create user object - create entry in db
    // check for user creation
    // return res

    const {firstname, lastname, email, phone, password} = req.body

    if ([firstname, lastname, email, phone].some((field) => field?.trim() === "")) 
    {
        throw new ApiError(400, "All fields are required")
    }

    const userExist =  await Users.findOne({
        $or : [{email}, {phone}]
    })

    if(userExist){
        throw new ApiError(409, "user already exists")
    }

    const user = Users.create({
        firstname,
        lastname,
        email,
        phone
    });

    const token = generateToken(user._id);

    const createdUser = await Users.findById(user._id).select(firstname);
    if(!createdUser){
        throw new ApiError(500, "Something went wrong while registering the user")
    }
    else{
        return res.status(201).json(
            new ApiResponse(200,{user, token}, "User registered successfully")
        )
    }
})


export {registerUser}