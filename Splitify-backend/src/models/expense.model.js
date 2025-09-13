import mongoose, {Schema} from "mongoose";

const expenseSchema = new Schema({
    // ExpenseID is usually auto-generated in MongoDB as _id
    description : {
        type: String,
        required: true,
    },
    amount : {
        type: Number,
        required: true,
    },
    createddate : {
        type: Date,
        default: Date.now,
    },
    category : {
        type: String,
        required: true,
    },
    paidby : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users', // References the User model
        required: true,
    },
    groupId : {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Groups', // References the Group model    
        required: true,
    },
    participants : [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'ExpenseParticipants', // References the Participant model
        }
    ],
    userShare: { type: Number }, // amount for the current user
    splitOption: { type: String, enum: ["equal", "shares", "exact"], default: "equal" },
    location: { type: String },
    notes: { type: String },
},
{
    timestamps: true // Automatically adds createdAt and updatedAt fields
});


export const Expense = mongoose.model("Expense", expenseSchema)