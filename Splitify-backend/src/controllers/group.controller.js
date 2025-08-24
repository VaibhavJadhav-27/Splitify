import { Group } from "../models/group.model.js";
import {asyncHandler} from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { Users } from "../models/users.model.js";
import logger from "../utils/logger.js";


const createGroup = asyncHandler( async(req, res) => {
    // get group details from frontend
    // validation - not empty
    // check if group already exists: groupName
    // create group object - create entry in db
    // check for group creation
    // return res
    const {GroupName, Description, GroupType, Image} = req.body;

    logger.info(` [${req.user._id}] :- Creating group with name: ${GroupName}`);

    if ([GroupName].some((field) => field?.trim() === "")) 
    {
        logger.error(` [${req.user._id}] :- Group name is required`);
        throw new ApiError(400, "Group name is required");
    }

    const groupExist =  await Group.findOne({groupName: GroupName.trim()});

    if(groupExist){
        logger.error(` [${req.user._id}] :- Group already exists with name: ${GroupName}`);
        throw new ApiError(409, "Group already exists");
    }

    const user = await Users.findById(req.user._id);
    if(!user){
        throw new ApiError(404, "User not found");
    }

    const groupData = {
        GroupName,
        Description,
        createdBy: user._id,
        groupType: GroupType,
        members: []
    };

    // Only add groupImage if string is provided
    if (Image && Image.trim() !== "") {
    groupData.groupImage = Image.trim();
    }

    const group = await Group.create(groupData);

    if(!group){
        throw new ApiError(500, "Something went wrong while creating the group");
    }
    else{
        logger.info(` [${req.user._id}] :- Group created successfully`);
        return res.status(201).json(
            new ApiResponse(200, group, "Group created successfully")
        )
    }
});


const addMemberToGroup = asyncHandler( async(req, res) => {
    const {groupId, memberIds } = req.body;
    logger.info(` [${req.user._id}] :- tring to add members to group with ID: ${groupId}`);

    if (!groupId || !memberIds || memberIds.length === 0) {
        throw new ApiError(400, "Group ID and member IDs are required");
    }

    const group = await Group.findById(groupId);
    if (!group) {
        logger.error(` [${req.user._id}] :- Group not found with ID: ${groupId}`);
        throw new ApiError(404, "Group not found");
    }

    const members = await Users.find({ _id: { $in: memberIds } });
    if (members.length !== memberIds.length) {
        logger.error(` [${req.user._id}] :- One or more members not found for group: ${group.groupName}`);
        throw new ApiError(404, "One or more members not found");
    }
    // Ensure members are unique and not already in the group
    const uniqueMemberIds = Array.from(new Set([...group.members.map(m => m.toString()), ...memberIds]));
    group.members = uniqueMemberIds;

    const updatedGroup = await group.save();
    if (!updatedGroup) {
        logger.error(` [${req.user._id}] :- Something went wrong while adding members to the group: ${group.groupName}`);
        throw new ApiError(500, "Something went wrong while adding members to the group");
    }
    else {
        logger.info(` [${req.user._id}] :- Members added to group: ${updatedGroup.groupName} successfully`);

        return res.status(200).json(
            new ApiResponse(200, updatedGroup, "Members added to group successfully")
        );
    }
});

export {createGroup, addMemberToGroup};