/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.ObserverItem;
import com.r_terai.java.ee.common.entity.ObserverResult;
import com.r_terai.java.ee.common.entity.ObserverTarget;
import com.r_terai.java.ee.common.entity.util.COMMONEntityUtil;
import com.r_terai.java.util.Logger;
import java.util.List;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author r-terai
 */
@Stateless
@LocalBean
@TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
public class ObserverEJB implements ObserverEJBLocal {

    @PersistenceContext(unitName = "COMMONEntity")
    private EntityManager em;

    private static final Logger logger = new Logger(ObserverEJB.class.getName());

    @Override
    public List<ObserverResult> getResults() {
        return COMMONEntityUtil.ObserverResultUtil.getAll(em);
    }

    @Override
    public ObserverTarget record(ObserverItem item) {
        return COMMONEntityUtil.ObserverTargetUtil.persist(em, item.getApplication(), item.getModule(), item.getClass1(), item.getMethod(), item.getStatus(), item.getMessage());
    }

}
