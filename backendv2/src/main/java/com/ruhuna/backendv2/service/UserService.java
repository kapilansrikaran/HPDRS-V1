package com.ruhuna.backendv2.service;


import com.ruhuna.backendv2.model.User;
import com.ruhuna.backendv2.web.dto.UserRegistrationDto;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService{
	User save(UserRegistrationDto registrationDto);
}
