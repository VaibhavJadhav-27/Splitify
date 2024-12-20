import mongoose, {Schema} from "mongoose";

const statusSchema = mongoose.Schema({
    status : {
        type: String,
        required: true
    },
    description : {
        type: String,
        required: true
    }
});


export const Status = mongoose.model("Status", statusSchema)