/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.repository.impl;

import com.da.pojos.User;
import com.da.repository.UserRepository;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Admin
 */
@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository{
    @Autowired
    private LocalSessionFactoryBean sessionFactory;

    @Override
    public boolean addUser(User user) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if(user.getId() > 0)
                session.update(user);
            else
                session.save(user);
            return true;
        } catch (HibernateException e) {
            System.err.println("==Add user error==" + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> getUsers(String username) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query.select(root);
        if(!username.isEmpty()){
            Predicate p = builder.equal(root.get("username").as(String.class), username.trim());
            query = query.where(p); 
        }
        
//        Predicate pr = builder.equal(root.get("userRole").as(String.class), "ROLE_EMPLOYEE");
//        query = query.where(pr);
        Query q = session.createQuery(query);
        return q.getResultList();
    }
    
    @Override
    public List<User> getUsersByFullName(String fullName) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query.select(root);
        if(!fullName.isEmpty()){
            Predicate p = builder.like(root.get("fullName").as(String.class), String.format("%%%s%%", fullName));
            query = query.where(p); 
        }
        
        
        Query q = session.createQuery(query);
        return q.getResultList();
    }
    
    @Override
    public User getUsersByUsername(String username) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query.select(root);
        if(!username.isEmpty()){
            Predicate p = builder.equal(root.get("username").as(String.class), username.trim());
            query = query.where(p); 
        }
        
        
        Query q = session.createQuery(query);
        return (User) q.getSingleResult();
    }

    @Override
    public boolean addEmployeeUser(User employee) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if(employee.getId() > 0)
                session.update(employee);
            else{
                session.save(employee);
            }
            return true;
        } catch (HibernateException e) {
            System.err.println("==Add employee error==" + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User getUserById(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        
        return session.get(User.class, id);
    }

    @Override
    public long countUserWithRole(String role) {
        Session s = this.sessionFactory.getObject().getCurrentSession();
        
        Query query = s.createQuery("SELECT count(u.id) FROM User u WHERE u.userRole = :role");
        
        query.setParameter("role", role);
        
        return Long.parseLong(query.getSingleResult().toString());
    }

    @Override
    public boolean deleteUser(int id) {
        try {
            Session session = this.sessionFactory.getObject().getCurrentSession();
            User u = session.get(User.class, id);
            session.delete(u);
            
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        
        return false;
    }
}
