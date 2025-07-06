import { Group } from "../models/group.model.js";
import {asyncHandler} from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { Users } from "../models/users.model.js";


const createGroup = asyncHandler( async(req, res) => {
    // get group details from frontend
    // validation - not empty
    // check if group already exists: groupName
    // create group object - create entry in db
    // check for group creation
    // return res
debugger;
    const {groupName, description} = req.body;

    if ([groupName].some((field) => field?.trim() === "")) 
    {
        throw new ApiError(400, "Group name is required");
    }

    const groupExist =  await Group.findOne({ groupName: { $eq: groupName } });

    if(groupExist){
        throw new ApiError(409, "Group already exists");
    }

    const user = await Users.findById(req.user._id);
    if(!user){
        throw new ApiError(404, "User not found");
    }

    const group = await Group.create({
        groupName,
        description,
        createdBy: user._id
    });

    if(!group){
        throw new ApiError(500, "Something went wrong while creating the group");
    }
    else{
        return res.status(201).json(
            new ApiResponse(200, group, "Group created successfully")
        )
    }
});


export {createGroup};