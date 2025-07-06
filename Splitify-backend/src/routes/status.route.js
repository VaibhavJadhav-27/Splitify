import {Router} from "express";
import { addStatus , addStatusList} from "../controllers/status.controller.js";
import {auth} from "../middleware/auth.js";

const router  =  Router()


//routes
router.route('/addStatus').post(auth, addStatus);
router.route('/addStatusList').post(auth, addStatusList);
// router.route('/getStatus').get(auth, getStatus);
// router.route('/updateStatus/:id').put(auth, updateStatus);
// router.route('/deleteStatus/:id').delete(auth, deleteStatus);




//export routes
export default router