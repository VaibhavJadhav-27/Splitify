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
    
    const {groupName, description} = req.body;

    if ([groupName].some((field) => field?.trim() === "")) 
    {
        throw new ApiError(400, "Group name is required");
    }

    const groupExist =  await Group.findOne({groupName: groupName.trim()});

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
        createdBy: user._id,
        members: []
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


const addMemberToGroup = asyncHandler( async(req, res) => {
    const {groupId, memberIds } = req.body;
    if (!groupId || !memberIds || memberIds.length === 0) {
        throw new ApiError(400, "Group ID and member IDs are required");
    }

    const group = await Group.findById(groupId);
    if (!group) {
        throw new ApiError(404, "Group not found");
    }

    const members = await Users.find({ _id: { $in: memberIds } });
    if (members.length !== memberIds.length) {
        throw new ApiError(404, "One or more members not found");
    }
    // Ensure members are unique and not already in the group
    const uniqueMemberIds = Array.from(new Set([...group.members.map(m => m.toString()), ...memberIds]));
    group.members = uniqueMemberIds;

    const updatedGroup = await group.save();
    if (!updatedGroup) {
        throw new ApiError(500, "Something went wrong while adding members to the group");
    }
    else {
        return res.status(200).json(
            new ApiResponse(200, updatedGroup, "Members added to group successfully")
        );
    }
});

export {createGroup, addMemberToGroup};