import {Router} from "express";
import { createGroup } from "../controllers/group.controller.js";
import {auth} from "../middleware/auth.js";


const router  =  Router()


//routes
router.route('/addGroup').post(auth, createGroup);




//export routes
export default router