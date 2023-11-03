package com.ruhuna.uhpdcs.dto;
//  DTO (Data Transfer Object) classes used to represent the data expected in the request body.
public class UserLoginRequest {
    private String username;
    private String password;

    public UserLoginRequest() {
    }

    public UserLoginRequest(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // Getters and setters

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

