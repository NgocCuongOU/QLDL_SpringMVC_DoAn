/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.service;

import com.da.pojos.User;
import java.util.List;
import org.springframework.security.core.userdetails.UserDetailsService;
/**
 *
 * @author Admin
 */

public interface UserService extends UserDetailsService {
    boolean addUser(User user);
    List<User> getUsers(String username);
}
