import {asyncHandler} from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import {ApiResponse } from "../utils/ApiResponse.js";
import { Status } from "../models/status.model.js"; 

const addStatus = asyncHandler(async (req, res) => {
    const {status, description} = req.body;

    if ([status, description].some((field) => field?.trim() === "")) {
        throw new ApiError(400, "All fields are required");
    }

    const newStatus = await Status.create({
        status,
        description
    });

    if (!newStatus) {
        throw new ApiError(500, "Something went wrong while adding the status");
    } else {
        return res.status(201).json(
            new ApiResponse(200, newStatus, "Status added successfully")
        );
    }
});

const addStatusList = asyncHandler(async (req, res) => {
    const statusList = req.body.statusList;

    if (!Array.isArray(statusList) || statusList.length === 0) {
        throw new ApiError(400, "Status list is required and must be an array");
    }

    const createdStatuses = await Status.insertMany(statusList);

    if (!createdStatuses || createdStatuses.length === 0) {
        throw new ApiError(500, "Something went wrong while adding the statuses");
    } else {
        return res.status(201).json(
            new ApiResponse(200, createdStatuses, "Statuses added successfully")
        );
    }
});

const updateStatus = asyncHandler(async (req, res) => {
    const { status, description } = req.body;

    if ([status, description].some((field) => field?.trim() === "")) {
        throw new ApiError(400, "All fields are required");
    }

    const statusId = await Status.findOne({ status : status }).select('_id');

    const updatedStatus = await Status.findByIdAndUpdate(
        statusId,
        { status, description },
        { new: true }
    );

    if (!updatedStatus) {
        throw new ApiError(404, "Status not found");
    } else {
        return res.status(200).json(
            new ApiResponse(200, updatedStatus, "Status updated successfully")
        );
    }
});

export { addStatus , addStatusList, updateStatus };   