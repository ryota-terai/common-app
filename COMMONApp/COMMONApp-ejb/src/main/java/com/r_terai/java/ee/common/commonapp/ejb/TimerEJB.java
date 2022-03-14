/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.entity.TimerSetting;
import com.r_terai.java.ee.common.entity.util.COMMONEntityUtil;
import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Util;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerConfig;
import javax.ejb.TimerService;
import javax.naming.NamingException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 *
 * @author r-terai
 */
public abstract class TimerEJB {

    @Resource
    protected TimerService timer;

    @PersistenceContext(unitName = "COMMONEntity")
    protected EntityManager em;

    protected static Logger logger;

    @PostConstruct
    public void initialize() {
        logger = new Logger(this.getClass().getName());
        try {
            String application = Util.getApplicationName();
            String module = Util.getModuleName();

            logger.log(Logger.Level.INFO, "Application={};Module={};Class={};", application, module, this.getClass().getName());
            TimerSetting setting = COMMONEntityUtil.TimerSettingUtil.get(em, application, module, this.getClass().getName());

            TimerConfig timerConfig = new TimerConfig();
            timerConfig.setInfo(this.getClass().getName());
            timerConfig.setPersistent(false);

            if (setting.getIntervalTime() > 0) {
                timer.createIntervalTimer(setting.getTimeout(), setting.getIntervalTime(), timerConfig);
            } else {
                timer.createSingleActionTimer(setting.getTimeout(), timerConfig);
            }
        } catch (NamingException | NoResultException ex) {
            logger.log(Logger.Level.SEVERE, null, ex);
        }
    }

    @Timeout
    public abstract void timeout(Timer timer);

}
