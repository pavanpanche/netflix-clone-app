package com.example.netflix.backend.mapper;

import com.example.netflix.backend.dto.UserDTO;
import com.example.netflix.backend.models.User;

public class UserMapper {

    public static UserDTO toDTO(User user) {
        if (user == null) return null;

        return new UserDTO(
                user.getId(),
                user.getEmail(),
                user.getFullName(),
                user.getRole()
        );
    }

    public static User toModel(UserDTO dto) {
        if (dto == null) return null;

        User user = new User();
        user.setId(dto.getId());
        user.setEmail(dto.getEmail());
        user.setFullName(dto.getFullName());
        user.setRole(dto.getRole());
        return user;
    }
}
