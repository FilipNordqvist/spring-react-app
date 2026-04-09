package com.example.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.server.service.WeatherService;

@RestController
@CrossOrigin(origins = "*")
public class WeatherController {
  
    @Autowired
    private WeatherService weatherService;

    @GetMapping("/weather")
    public String getWeather(@RequestParam(defaultValue = "Staffanstorp") String city) {
        return weatherService.getWeather(city);
    }
}