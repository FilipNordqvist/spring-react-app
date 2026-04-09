package com.example.server.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class RecipeService {

    private final RestTemplate restTemplate = new RestTemplate();

    public String getRecipe() {
        String url = "https://www.themealdb.com/api/json/v1/1/random.php";
        return restTemplate.getForObject(url, String.class);
    }
}