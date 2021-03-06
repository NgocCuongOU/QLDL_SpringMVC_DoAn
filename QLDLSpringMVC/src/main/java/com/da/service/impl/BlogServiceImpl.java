/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.service.impl;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.da.pojos.Post;
import com.da.repository.BlogRepository;
import com.da.service.BlogService;
import java.io.IOException;
import static java.lang.Boolean.TRUE;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Admin
 */
@Service
public class BlogServiceImpl implements BlogService{

    @Autowired
    private BlogRepository blogRepository;
    @Autowired
    private Cloudinary cloudinary;
    
    @Override
    public List<Object[]> getPosts(String title, int page) {
        
        return this.blogRepository.getPosts(title, page);
    }

    @Override
    public long countPosts() {
        return this.blogRepository.countPosts();
    }

    @Override
    public List<Post> getPosts(String title) {
        return this.blogRepository.getPosts(title);
    }

    @Override
    public boolean addPost(Post post) {
       try {
            if(!post.getFile().isEmpty() && post.getFile() != null){
                Map r = this.cloudinary.uploader().upload(post.getFile().getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                post.setPhoto((String) r.get("secure_url"));
            }
            else
                post.setPhoto(this.blogRepository.getPostById(post.getId()).getPhoto());
            if(this.blogRepository.getPostById(post.getId()) == null)
                post.setDate(new Date());
            else
                post.setDate(this.blogRepository.getPostById(post.getId()).getDate());
            return this.blogRepository.addPost(post);
       } catch (IOException ex) {
            System.err.println("===ADD===" + ex.getMessage());
            ex.printStackTrace();
       }  
       
       return false;
    }

    @Override
    public Post getPostById(int id) {
        return this.blogRepository.getPostById(id);
    }

    @Override
    public List<Post> getPosts() {
        return this.blogRepository.getPosts();
    }

    @Override
    public boolean deletePost(int id) {
        return this.blogRepository.deletePost(id);
    }
    
}
