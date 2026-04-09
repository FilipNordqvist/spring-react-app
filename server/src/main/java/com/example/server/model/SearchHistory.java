package com.example.server.model;

import java.time.LocalDateTime;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class SearchHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String city;
    private LocalDateTime searchedAt;

    public void setId(Long id){
        this.id = id;
    }
        
    public Long getId(){
        return id;
    }

    public void setCity(String city){
        this.city=city;
    }

    public String getCity(){
        return city;
    }

    public void setSearchedAt(LocalDateTime searchedAt){
        this.searchedAt = searchedAt;
    }

    public LocalDateTime getSearchedAt(){
        return searchedAt;
    }



    
}
