/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.controllers;

import com.da.pojos.Post;
import com.da.service.BlogService;
import com.da.service.CategoryService;
import com.da.service.TagService;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Admin
 */
@Controller
@ControllerAdvice
public class BlogController {
    @Autowired
    private BlogService blogService;
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private TagService tagService;
    
    @GetMapping("/blogs")
    public String blogView(Model model, @RequestParam(value = "title", required = false, defaultValue = " ") String title,
            @RequestParam(required = false) Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        model.addAttribute("posts", this.blogService.getPosts(title, page));
        model.addAttribute("counter", this.blogService.countPosts());
        model.addAttribute("categories", this.categoryService.getCategories());
        model.addAttribute("tags", this.tagService.getTags());
        
        return "blog";
    }
    
    
    // ------------------------ Controller admin ------------------------
    
    @GetMapping("/admin/blog-management")
    public String blogManagementView(Model model, @RequestParam(value = "blogTitle",
            required = false, defaultValue = "") String blogTitle) {
        model.addAttribute("posts", this.blogService.getPosts(blogTitle));
        model.addAttribute("cates", this.categoryService.getCategories());
        return "blog-management";
    }
    
    @PostMapping("/admin/blog-management")
    public String addPost(Model model, @ModelAttribute(value="addPost") @Valid Post addPost, BindingResult result,
            @RequestParam(value = "blogTitle", required = false, defaultValue = "") String blogTitle){
        String errMsg ="";
        String successMsg = "";
        if(!result.hasErrors()){
            if(this.blogService.addPost(addPost) == true) {
                successMsg = "Th??m th??nh c??ng!";
                model.addAttribute("successMsg", successMsg);
                model.addAttribute("posts", this.blogService.getPosts(blogTitle));
                model.addAttribute("cates", this.categoryService.getCategories());
                return "blog-management";
            }
            else
                errMsg = "L???i! Th??m th???t b???i!";     
        }
        else
            errMsg = "L???i! Th??ng tin nh???p kh??ng h???p l???!";
        model.addAttribute("errMsg", errMsg);
        return "blog-management";
    }
}
