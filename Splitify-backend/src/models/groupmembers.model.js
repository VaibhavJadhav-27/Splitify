import mongoose, {Schema} from "mongoose";

const groupMembersSchema = new mongoose.Schema({
    groupID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Group', // References the Group model
      required: true, // Makes the field mandatory
    },
    userID: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Users', // References the User model
      required: true, // Makes the field mandatory
    },
    joinDate: {
      type: Date,
      default: Date.now, // Automatically sets the current date
    },
  });


// Composite Index: Ensures uniqueness of groupID + userID combination
groupMembersSchema.index({ groupID: 1, userID: 1 }, { unique: true });


export const GroupMembers  = mongoose.model("GroupMembers", groupMembersSchema)