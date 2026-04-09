package com.example.server.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.server.repository.SearchHistoryRepository;
import com.example.server.model.SearchHistory;
import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class HistoryController {

    @Autowired
    private SearchHistoryRepository searchHistoryRepository;

    @GetMapping("/history")
    public List<SearchHistory> getHistory() {
        return searchHistoryRepository.findAll();
    }
}