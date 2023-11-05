package com.ruhuna.uhpdcs.model;


import jakarta.persistence.*;

import java.security.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "username", unique = true, nullable = false, length = 50)
    private String username;

    @Column(name = "user_password", nullable = false, length = 200)
    private String userPassword;

    // You can add more fields such as first name, last name, email, registration date, etc.

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id", nullable = false)
    private Role roleId;

    // Constructors

    public User() {
        // Default constructor
    }

    public User(String username, String userPassword, Role roleId) {
        this.username = username;
        this.userPassword = userPassword;
        this.roleId = roleId;
    }

    // Getters and setters

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public Role getRole() {
        return roleId;
    }

    public void setRole(Role role) {
        this.roleId = roleId;
    }

    // Other getters and setters for additional fields

    // Equals and hashCode (useful for comparing user objects)

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(userId, user.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId);
    }


}
