/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.da.service;

import com.da.pojos.Rating;
import java.util.List;

/**
 *
 * @author CaoNgocCuong
 */
public interface RatingCommentTourService {
    Rating addCommentTour(String comment, int tourId, String username);
    List<Rating> getCommentsTour(int tourId, int page);
    long counterCommentTour(int tourId);
}
