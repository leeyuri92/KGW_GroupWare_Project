package com.best.kgw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping("/")
public class DashboardController {
    @GetMapping("/")
    public String DashboardForm(){

        return "forward:/dashboard/dashboardForm.jsp";
    }
}