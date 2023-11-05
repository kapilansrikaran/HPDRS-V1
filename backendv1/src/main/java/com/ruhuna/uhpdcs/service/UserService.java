package com.ruhuna.uhpdcs.service;

import com.ruhuna.uhpdcs.model.Role;
import com.ruhuna.uhpdcs.model.User;
import com.ruhuna.uhpdcs.repository.RoleRepository;
import com.ruhuna.uhpdcs.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User registerUser(String username, String password, int roleId) {
        // Check if the user already exists
        if (userRepository.findByUsername(username) != null) {
            throw new RuntimeException("Username already exists.");
        }

        // Find the role by roleName
        Role role = roleRepository.findByRoleId(roleId);

        if (role == null) {
            throw new RuntimeException("Role not found.");
        }

        // Encode the password
        String encodedPassword = passwordEncoder.encode(password);

        // Create a new user
        User newUser = new User(username, encodedPassword, role);

        return userRepository.save(newUser);
    }

    public User loginUser(String username, String password) {
        User user = userRepository.findByUsername(username);

        if (user == null) {
            throw new RuntimeException("User not found.");
        }

        if (!passwordEncoder.matches(password, user.getUserPassword())) {
            throw new RuntimeException("Incorrect password.");
        }

        return user;
    }
}



