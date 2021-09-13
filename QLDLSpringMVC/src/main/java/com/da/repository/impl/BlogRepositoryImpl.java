/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.repository.impl;

import com.da.pojos.Post;
import com.da.repository.BlogRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Admin
 */
@Repository
@Transactional
public class BlogRepositoryImpl implements BlogRepository{

    @Autowired
    private LocalSessionFactoryBean sessionFactory;
    
    @Override
    public List<Post> getPosts(String title, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Post> query = builder.createQuery(Post.class);
        Root root = query.from(Post.class);
        query = query.select(root);
        
        if(!title.isEmpty() && title != null){
            Predicate p = builder.like(root.get("title").as(String.class), String.format("%%%s%%", title));
            query = query.where(p);
        }
        
        Query q = session.createQuery(query);
        
        int max = 5;
        q.setMaxResults(max);
        q.setFirstResult((page - 1) * max);
        
        
        return q.getResultList();
    }

    @Override
    public long countPosts() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query query = session.createQuery("SELECT COUNT(*) FROM Post");
        
        return Long.parseLong(query.getSingleResult().toString());
    }

    
}
