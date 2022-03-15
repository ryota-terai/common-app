/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.entity.ObserverResult;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author r-terai
 */
@Local
public interface ObserverEJBLocal {

    public List<ObserverResult> getResults();
}
