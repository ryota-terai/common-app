/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.ejb;

import com.r_terai.java.ee.common.ObserverInterceptor;
import com.r_terai.java.ee.common.TimerEJB;
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
import javax.interceptor.Interceptors;

/**
 *
 * @author r-terai
 */
@Startup
@Singleton
public class ObserverTimer extends TimerEJB {

    @Timeout
    @Override
//    @Interceptors(LogInterceptor.class)
    @Interceptors(ObserverInterceptor.class)
    public void timeout(Timer timer) {
        observe();
    }

    private void observe() {
        List<ObserverSetting> settings = COMMONEntityUtil.ObserverSettingUtil.get(em);
        Date now = new Date();
        for (ObserverSetting setting : settings) {
            if (setting.getUpdateTime() == null || (now.getTime() - setting.getUpdateTime().getTime()) >= setting.getIntervalTime()) {
                List<ObserverTarget> targets = COMMONEntityUtil.ObserverTargetUtil.getOrderByUpdateTimeDesc(em, setting.getApplication(), setting.getModule(), setting.getClass1(), setting.getMethod());
                if (!targets.isEmpty()) {
                    boolean first = true;
                    for (ObserverTarget target : targets) {
                        if (first) {
                            if ((now.getTime() - target.getUpdateTime().getTime()) > setting.getTimeout()) {
                                logger.log(Level.ERROR, setting.toString() + " is timeout");
                                COMMONEntityUtil.ObserverResultUtil.record(em, setting, 408, "time out");
                            } else {
                                COMMONEntityUtil.ObserverResultUtil.record(em, setting, target.getStatus(), target.getMessage());
                            }
                            first = false;
                        }
                    }
                    setting.setUpdateTime(now);
                    em.merge(setting);
                } else {
                    COMMONEntityUtil.ObserverResultUtil.record(em, setting, 404, "Not found");
                    setting.setUpdateTime(now);
                    em.merge(setting);
                }
            }
        }
    }

}
