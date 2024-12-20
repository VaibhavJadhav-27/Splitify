import mongoose, {Schema} from "mongoose";

const usersSchema = new mongoose.Schema({
    firstname: {
      type: String,
      required: true, // Makes the field mandatory
      trim: true, // Removes whitespace
    },
    lastname: {
        type: String,
        required: true, // Makes the field mandatory
        trim: true, // Removes whitespace
      },
    email: {
      type: String,
      required: true,
      unique: true, // Ensures email uniqueness
      trim: true,
      lowercase: true, // Converts email to lowercase
    },
    phone: {
      type: String,
      required: true,
      unique: true,
      match: /^[0-9]{10}$/, // Validates a 10-digit phone number
    },
    password: {
      type: String,
      required: true,
      minlength: 8, // Sets minimum password length
      default: 'defaultpassword'
    },
    createdAt: {
      type: Date,
      default: Date.now, // Automatically sets the current date
    },
    updatedAt: {
      type: Date,
      default: Date.now, // Automatically sets the current date
    },
  });


export const Users = mongoose.model("Users", usersSchema)