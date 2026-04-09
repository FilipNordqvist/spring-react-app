package com.example.server.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.server.model.SearchHistory;
import com.example.server.repository.SearchHistoryRepository;

@Service
public class WeatherService {

    @Autowired
      private SearchHistoryRepository searchHistoryRepository;

      @Value("${weather.api.key}")
      private String apiKey;

      private final RestTemplate restTemplate = new RestTemplate();

      public String getWeather(String city) {
          // Spara till DB
          SearchHistory history = new SearchHistory();
          history.setCity(city);
          history.setSearchedAt(LocalDateTime.now());
          searchHistoryRepository.save(history);

          // Hämta väder
          String url = "https://api.openweathermap.org/data/2.5/weather?q="
                  + city + "&appid=" + apiKey + "&units=metric&lang=sv";
          return restTemplate.getForObject(url, String.class);
      }
}
