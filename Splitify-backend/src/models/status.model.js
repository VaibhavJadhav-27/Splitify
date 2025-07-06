import mongoose, {Schema} from "mongoose";

const statusSchema = mongoose.Schema({
    status : {
        type: String,
        required: true,
        unique: true, // Ensures status uniqueness
    },
    description : {
        type: String,
        required: true,
        trim : true, // Removes whitespace
    }
},
{
    timestamps: true // Automatically adds createdAt and updatedAt fields
});


export const Status = mongoose.model("Status", statusSchema)