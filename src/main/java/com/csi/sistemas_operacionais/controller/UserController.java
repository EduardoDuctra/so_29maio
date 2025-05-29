package com.csi.sistemas_operacionais.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public String listUsers(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        model.addAttribute("userForm", new User());
        return "users";
    }

    @PostMapping
    public String addUser(@ModelAttribute("userForm") User user) {
        userRepository.save(user);
        return "redirect:/users";
    }
}
