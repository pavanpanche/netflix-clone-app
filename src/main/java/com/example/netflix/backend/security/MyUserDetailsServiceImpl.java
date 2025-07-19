package com.example.netflix.backend.security;
import com.example.netflix.backend.models.User;
import com.example.netflix.backend.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class MyUserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Autowired
    public MyUserDetailsServiceImpl(UserRepository userRepository) {
        this.userRepository =userRepository;

    }
    /**
     * Called by Spring Security to load a user during authentication.
     * Here we look up by email, then wrap in our MyUserDetails.
     */
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("No User found this email : " + email)
         );
     return new MyUserDetails(user);

    }
}
