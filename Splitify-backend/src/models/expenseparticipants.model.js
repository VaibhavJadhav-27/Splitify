import mongoose, {Schema} from "mongoose";

const expenseParticipantsSchema = new Schema({
    userId : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users', // References the User model
        required: true,
    },
    amount : {
        type: Number,
        required: true,
        default: 0,
    }
});

export const ExpenseParticipants = mongoose.model("ExpenseParticipants", expenseParticipantsSchema);