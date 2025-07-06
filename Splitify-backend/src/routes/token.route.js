import {Router} from "express";
import { createToken } from "../controllers/tokengeneration.controller.js";


const router  =  Router()


//routes
router.route('/createToken').post(createToken);




//export routes
export default router