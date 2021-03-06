/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.repository;

import com.da.pojos.Post;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface BlogRepository {
    List<Object[]> getPosts(String title, int page);
    List<Post> getPosts(String title);
    List<Post> getPosts();
    Post getPostById(int id);
    boolean addPost(Post post);
    long countPosts();
    boolean deletePost(int id);
}
