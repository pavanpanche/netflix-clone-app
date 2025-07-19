package com.example.netflix.backend.models;


import jakarta.persistence.*;
import lombok.*;

@Data
@Entity
@Table (name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String email;

    private String password;

    private String fullName;

    @Enumerated(EnumType.STRING)
    @Column (nullable =false)
    private Role role;    // admin or user

}
