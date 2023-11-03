package com.ruhuna.uhpdcs.dto;

public class UserRegistrationRequest {
    private String username;
    private String password;
    private int roleId;

    public UserRegistrationRequest() {
    }

    public UserRegistrationRequest(String username, String password, int roleId) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
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

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
