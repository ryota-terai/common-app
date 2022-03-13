/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.entity.ObserverSetting;
import com.r_terai.java.ee.common.entity.ObserverTarget;
import com.r_terai.java.ee.common.entity.TimerSetting;
import com.r_terai.java.ee.common.entity.util.COMMONEntityUtil;
import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Logger.Level;
import com.r_terai.java.util.Util;
import java.util.Date;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.Singleton;
import javax.ejb.Startup;
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
@Startup
@Singleton
public class OvserverTimer {

    @Resource
    TimerService timer;

    @PersistenceContext(unitName = "COMMONEntity")
    private EntityManager em;

    private static final Logger logger = new Logger(OvserverTimer.class.getName());

    @PostConstruct
    public void initialize() {
        try {
            String application = Util.getApplicationName();
            String module = Util.getModuleName();

            TimerSetting setting = COMMONEntityUtil.TimerSettingUtil.get(em, application, module, this.getClass().getName());

            TimerConfig timerConfig = new TimerConfig();
            timerConfig.setInfo(this.getClass().getName());
            timerConfig.setPersistent(false);

            if (setting.getInterval() > 0) {
                timer.createIntervalTimer(setting.getTimeout(), setting.getInterval(), timerConfig);
            } else {
                timer.createSingleActionTimer(setting.getTimeout(), timerConfig);
            }
        } catch (NamingException | NoResultException ex) {
            logger.log(Level.SEVERE, null, ex);
        }
    }

    @Timeout
    public void timeout(Timer timer) {
        try {
            observe();
            COMMONEntityUtil.ObserverTargetUtil.kick(em);
        } catch (NamingException ex) {
            logger.log(Level.SEVERE, null, ex);
        }

    }

    private void observe() {
        List<ObserverSetting> settings = COMMONEntityUtil.ObserverSettingUtil.get(em);

        for (ObserverSetting setting : settings) {
            List<ObserverTarget> targets = COMMONEntityUtil.ObserverTargetUtil.getOrderByUpdateTimeDesc(em, setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod());
            boolean first = true;
            for (ObserverTarget target : targets) {
                if (first) {
                    Date now = new Date();
                    if (now.getTime() - target.getUpdateTime().getTime() > setting.getTimeout()) {
                        logger.log(Level.ERROR, setting.toString() + " is timeout");
                    }
                    first = false;
                } else {
                    em.remove(target);
                }
            }
        }
    }

}
