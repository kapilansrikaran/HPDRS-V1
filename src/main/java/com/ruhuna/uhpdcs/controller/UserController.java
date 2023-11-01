package com.ruhuna.uhpdcs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
    @RequestMapping()
    public void hello(){
        System.out.println("hello");
    }
}
