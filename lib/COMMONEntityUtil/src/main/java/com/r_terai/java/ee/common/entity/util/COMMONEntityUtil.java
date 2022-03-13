/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.entity.util;

import com.r_terai.java.ee.common.entity.ObserverSetting;
import com.r_terai.java.ee.common.entity.ObserverTarget;
import com.r_terai.java.ee.common.entity.TimerSetting;
import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Util;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import javax.persistence.EntityManager;

/**
 *
 * @author r-terai
 */
public class COMMONEntityUtil {

    private static final Logger logger = new Logger(COMMONEntityUtil.class.getName());

    public static class ObserverTargetUtil {

        private static void persist(EntityManager em, String application, String module, String _class, String method) {
            ObserverTarget target = new ObserverTarget();
            target.setApplication(application);
            target.setModule(module);
            target.setClass1(_class);
            target.setMethod(method);
            target.setUpdateTime(new Date());
            em.persist(target);
        }

        public static List<ObserverTarget> getOrderByUpdateTimeDesc(EntityManager em, String application, String module, String _class, String method) {
            List<ObserverTarget> targets = em.createNativeQuery("SELECT * FROM OBSERVER_TARGET WHERE APPLICATION = ?1 AND MODULE = ?2 AND CLASS = ?3 AND METHOD = ?4 ORDER BY UPDATE_TIME DESC", ObserverTarget.class).setParameter(1, application).setParameter(2, module).setParameter(3, _class).setParameter(4, method).getResultList();
            return targets;
        }

        public static void kick(EntityManager em) throws NamingException {
            String application = Util.getApplicationName();
            String module = Util.getModuleName();
            StackTraceElement[] elems = Thread.currentThread().getStackTrace();
            String className = elems[2].getClassName();
            String methodName = elems[2].getMethodName();
            persist(em, application, module, className, methodName);
            logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={}", application, module, className, methodName);
        }
    }

    public static class ObserverSettingUtil {

        public static List<ObserverSetting> get(EntityManager em) {
            List<ObserverSetting> settings = em.createNamedQuery("ObserverSetting.findByEnable", ObserverSetting.class)
                    .setParameter("enable", (short) 1)
                    .getResultList();
            return settings;
        }

    }

    public static class TimerSettingUtil {

        public static TimerSetting get(EntityManager em, String application, String module, String className) {
            TimerSetting setting = (TimerSetting) em.createNativeQuery("SELECT * FROM TIMER_SETTING WHERE APPLICATION = ?1 AND MODULE = ?2 AND CLASS = ?3", TimerSetting.class)
                    .setParameter(1, application)
                    .setParameter(2, module)
                    .setParameter(3, className)
                    .getSingleResult();
            return setting;
        }

    }

}
