import mongoose, {Schema} from "mongoose";

const groupSchema = new mongoose.Schema({
    groupName: {
      type: String,
      required: true, // Makes the field mandatory
      trim: true, // Removes whitespace
    },
    description: {
      type: String,
      trim: true, // Removes whitespace
      default: '', // Default value is an empty string
    },
    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Users', // References the User model
      required: true,
    },
    // members: [
    //   {
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: 'Users', // References the User model
    //   },
    // ],
    createdAt: {
      type: Date,
      default: Date.now, // Automatically sets the current date
    },
    updatedAt: {
      type: Date,
      default: Date.now, // Automatically sets the current date
    },
  });


export const Group = mongoose.model("Group", groupSchema)