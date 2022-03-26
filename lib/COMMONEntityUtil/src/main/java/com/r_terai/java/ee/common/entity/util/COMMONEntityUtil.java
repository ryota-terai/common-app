/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.entity.util;

import com.r_terai.java.ee.common.entity.ObserverResult;
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

    static final Logger logger = new Logger(COMMONEntityUtil.class.getName());

    public static class ObserverTargetUtil {

        public static ObserverTarget persist(EntityManager em, String application, String module, String _class, String method, int status, String message) {
            ObserverTarget target = new ObserverTarget();
            target.setApplication(application);
            target.setModule(module);
            target.setClass1(_class);
            target.setMethod(method);
            target.setStatus(status);
            target.setMessage(message);
            target.setUpdateTime(new Date());
            em.persist(target);
            em.flush();
            return target;
        }

        public static List<ObserverTarget> getOrderByUpdateTimeDesc(EntityManager em, String application, String module, String _class, String method) {
            List<ObserverTarget> targets = em.createNativeQuery("SELECT * FROM OBSERVER_TARGET WHERE APPLICATION = ?1 AND MODULE = ?2 AND CLASS = ?3 AND METHOD = ?4 ORDER BY UPDATE_TIME DESC", ObserverTarget.class)
                    .setParameter(1, application)
                    .setParameter(2, module)
                    .setParameter(3, _class)
                    .setParameter(4, method)
                    .getResultList();
            return targets;
        }

        public static void kick(EntityManager em, int status, String message, boolean removeOldLog) throws NamingException {
            String application = Util.getApplicationName();
            String module = Util.getModuleName();
            StackTraceElement[] elems = Thread.currentThread().getStackTrace();
            String className = elems[2].getClassName();
            String methodName = elems[2].getMethodName();
            
            kick(em, application, module, className, methodName, status, message, removeOldLog);
        }

        public static void kick(EntityManager em, String application, String module, String className, String methodName, int status, String message, boolean removeOldLog) throws NamingException {
            persist(em, application, module, className, methodName, status, message);
            logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={}", application, module, className, methodName);
            if (removeOldLog) {
                removeOldLog(em, application, module, className, methodName);
            }

        }

        public static void removeOldLog(EntityManager em, String application, String module, String _class, String method) {
            List<ObserverTarget> targets = getOrderByUpdateTimeDesc(em, application, module, _class, method);
            boolean first = true;
            for (ObserverTarget target : targets) {
                if (first) {
                    first = false;
                } else {
                    em.remove(target);
                }
            }
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

    public static class ObserverResultUtil {

        private static ObserverResult persist(EntityManager em, String application, String module, String _class, String method, int status, String message) {
            ObserverResult result = new ObserverResult();
            result.setApplication(application);
            result.setModule(module);
            result.setClass1(_class);
            result.setMethod(method);
            result.setStatus(status);
            result.setMessage(message);
            result.setUpdateTime(new Date());
            em.persist(result);
            em.flush();
            return result;
        }

        private static List<ObserverResult> getOrderByUpdateTimeDesc(EntityManager em, String application, String module, String _class, String method) {
            List<ObserverResult> results = em.createNativeQuery("SELECT * FROM OBSERVER_RESULT WHERE APPLICATION = ?1 AND MODULE = ?2 AND CLASS = ?3 AND METHOD = ?4 ORDER BY UPDATE_TIME DESC", ObserverResult.class)
                    .setParameter(1, application)
                    .setParameter(2, module)
                    .setParameter(3, _class)
                    .setParameter(4, method)
                    .getResultList();
            return results;
        }

        private static void removeOldLog(EntityManager em, String application, String module, String _class, String method) {
            List<ObserverResult> results = getOrderByUpdateTimeDesc(em, application, module, _class, method);
            boolean first = true;
            for (ObserverResult result : results) {
                if (first) {
                    first = false;
                } else {
                    em.remove(result);
                }
            }
        }

        public static void record(EntityManager em, ObserverSetting setting, int status, String message) {
            persist(em, setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod(), status, message);
//            logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={}", setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod());
            removeOldLog(em, setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod());
        }

        public static List<ObserverResult> getAll(EntityManager em) {
            List<ObserverResult> settings = em.createNamedQuery("ObserverResult.findAll", ObserverResult.class)
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
