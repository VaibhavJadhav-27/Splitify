import {Router} from "express";
import { registerUser } from "../controllers/users.controller.js";


const router  =  Router()


//routes
router.route('/register').post(registerUser);




//export routes
export default router