package com.example.server;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;


@SpringBootApplication
@RestController
public class ServerApplication {

	private final RestTemplate restTemplate = new RestTemplate();

	public static void main(String[] args) {
		SpringApplication.run(ServerApplication.class, args);
	}

	@CrossOrigin(origins = "*")
	@GetMapping("/home")
	public String home() {
		return "Spring Boot MVP";
	}

	@Value("${weather.api.key}")
	private String apiKey;
	

	@CrossOrigin(origins = "*")
	@GetMapping("/weather")
	public String getWeather(@RequestParam(defaultValue = "Staffanstorp") String city) {

		String url = "https://api.openweathermap.org/data/2.5/weather?q="
				+ city
				+ "&appid="
				+ apiKey
				+ "&units=metric&lang=sv";

		return restTemplate.getForObject(url, String.class);
	}

	@CrossOrigin(origins = "*")
	@GetMapping("/recipe")
	public String getRecipe() {
		String url = "https://www.themealdb.com/api/json/v1/1/random.php";
		return restTemplate.getForObject(url, String.class);
	}
}