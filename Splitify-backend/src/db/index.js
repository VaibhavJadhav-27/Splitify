import { DB_NAME } from "../constants.js";
import mongoose from "mongoose";

const connectDB =  async() => {
    try{
        debugger;
        const connectionInstance = await mongoose.connect(`${process.env.MONGODB_URI}/${DB_NAME}`)
        console.log(`\n MongoDB connected !! DB HOST: ${connectionInstance.connection.host}`);
    }
    catch(error){
        console.log("MONGO DB connection failed", error);
        process.exit(1)
    }
}


export default connectDB