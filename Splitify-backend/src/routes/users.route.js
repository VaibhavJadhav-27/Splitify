import {Router} from "express";
import { registerUser, loginUser } from "../controllers/users.controller.js";


const router  =  Router()


//routes
router.route('/register').post(registerUser);
router.route('/login').post(loginUser);




//export routes
export default router