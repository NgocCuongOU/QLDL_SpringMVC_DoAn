/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.service;

import com.da.pojos.Category;
import java.util.List;

/**
 *
 * @author CaoNgocCuong
 */
public interface CategoryService {
    List<Category> getCategories();
    List<Object> countPostInCate();
}
