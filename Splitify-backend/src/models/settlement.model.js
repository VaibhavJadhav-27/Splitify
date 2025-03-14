import mongoose, {Schema} from "mongoose";

const settlementSchema = new Schema({
    // SettlementID is auto-generated by MongoDB (_id)
    groupID: {
        type: Schema.Types.ObjectId,  // Foreign key referencing Group collection
        ref: 'Group',                 // Reference to the Group model
        required: true
    },
    fromUserID: {
        type: Schema.Types.ObjectId,  // Foreign key referencing User collection (User who is sending money)
        ref: 'Users',                  // Reference to the User model
        required: true
    },
    toUserID: {
        type: Schema.Types.ObjectId,  // Foreign key referencing User collection (User who is receiving money)
        ref: 'Users',                  // Reference to the User model
        required: true
    },
    amount: {
        type: Schema.Types.Decimal128, // Decimal type for monetary values
        required: true
    },
    settlementDate: {
        type: Date,                    // Date when the settlement is done
        default: Date.now              // Default to the current date
    }
}, {
    timestamps: true // Automatically adds createdAt and updatedAt fields
});



export const Settlement =  mongoose.model("Settlement", settlementSchema)