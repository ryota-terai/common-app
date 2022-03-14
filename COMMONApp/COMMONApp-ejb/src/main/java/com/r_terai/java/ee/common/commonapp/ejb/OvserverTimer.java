/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.entity.ObserverSetting;
import com.r_terai.java.ee.common.entity.ObserverTarget;
import com.r_terai.java.ee.common.entity.util.COMMONEntityUtil;
import com.r_terai.java.util.Logger.Level;
import java.util.Date;
import java.util.List;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.naming.NamingException;

/**
 *
 * @author r-terai
 */
@Startup
@Singleton
public class OvserverTimer extends TimerEJB {

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
        Date now = new Date();
        for (ObserverSetting setting : settings) {
            if (setting.getUpdateTime() == null || now.getTime() - setting.getIntervalTime() > setting.getUpdateTime().getTime()) {
                List<ObserverTarget> targets = COMMONEntityUtil.ObserverTargetUtil.getOrderByUpdateTimeDesc(em, setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod());
                boolean first = true;
                for (ObserverTarget target : targets) {
                    if (first) {
                        if (now.getTime() - target.getUpdateTime().getTime() > setting.getTimeout()) {
                            logger.log(Level.ERROR, setting.toString() + " is timeout");
                        }
                        first = false;
                    } else {
                        em.remove(target);
                    }
                }
                setting.setUpdateTime(new Date());
                em.merge(setting);
            }
        }
    }

}
