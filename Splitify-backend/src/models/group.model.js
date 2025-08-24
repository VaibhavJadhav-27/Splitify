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
    groupImage: {
      type: String,
      trim: true, // Removes whitespace
      default: '',
    }, // Default value is an empty string},
    groupType: {
      type: String,
      required: true,
      enum: ['Trip', 'Home','Family','Friend', 'Couple', 'Event', 'Others'], // Only allow these values
    },
    members: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users', // References the User model// Makes the field mandatory
      },
    ],
  },
  {
    timestamps: true, // Automatically adds createdAt and updatedAt fields
  });


export const Group = mongoose.model("Group", groupSchema)