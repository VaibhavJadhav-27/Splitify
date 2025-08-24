import { Users } from "../models/users.model.js";
import {asyncHandler} from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { generateToken } from "../utils/token.js";
import logger from "../utils/logger.js";

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

const loginUser = asyncHandler( async(req, res) => {
    const {emailid} = req.body;
    if ([emailid].some((field) => field?.trim() === "")) 
    {
        throw new ApiError(400, "All fields are required")
    }

    // const userExist =  await Users.findOne({
    //     $or : [{email}]
    // })

    // if(!userExist){
    //     throw new ApiError(409, "user does not exists")
    // }
    logger.info(` Attempting to log in user with email: ${emailid}`);
    const user = await Users.findOne({email: emailid.trim()});
    logger.info(` [${user._id}] :- User found: ${user}`);
    const token = generateToken(user._id);
    if(!user){
        logger.error(` [${user._id}] :- Something went wrong while logging in the user ${user.firstname}`);
        throw new ApiError(500, "Something went wrong while logging in the user")
    }
    else{
        logger.info(` [${user._id}] :- User logged in successfully ${user.firstname}`);
        return res.status(200).json(
            new ApiResponse(200,{user, token}, "User logged in successfully")
        )
    }

});

export {registerUser, loginUser}