package com.example.server.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@CrossOrigin(origins="*")
public class HomeController {
    @GetMapping("/home")
    public String home() {
        return "Spring Boot + DB? MVP";
    }
    
    
}
