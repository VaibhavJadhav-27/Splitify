import {Router} from "express";
import { createGroup, addMemberToGroup } from "../controllers/group.controller.js";
import {auth} from "../middleware/auth.js";


const router  =  Router()


//routes
router.route('/addGroup').post(auth, createGroup);
router.route('/addMembers').post(auth, addMemberToGroup);




//export routes
export default router