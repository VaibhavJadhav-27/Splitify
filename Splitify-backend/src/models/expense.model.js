import mongoose, {Schema} from "mongoose";

const expenseSchema = new Schema({
    // ExpenseID is usually auto-generated in MongoDB as _id
    groupID: {
        type: Schema.Types.ObjectId, // Foreign key referencing Group collection
        ref: 'Group',                 // Name of the Group model
        required: true
    },
    description: {
        type: String,
        required: true
    },
    amount: {
        type: Schema.Types.Decimal128, // Decimal type for amounts
        required: true
    },
    createdBy: {
        type: Schema.Types.ObjectId, // Foreign key referencing User collection
        ref: 'Users',                 // Name of the User model
        required: true
    }
},
{
    timestamps: true // Automatically adds createdAt and updatedAt fields
});


export const Expense = mongoose.model("Expense", expenseSchema)