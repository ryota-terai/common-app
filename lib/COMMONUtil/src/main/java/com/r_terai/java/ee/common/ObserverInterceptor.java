/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common;

import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Util;
import java.lang.reflect.Method;
import java.util.Date;
import javax.interceptor.AroundInvoke;
import javax.interceptor.AroundTimeout;
import javax.interceptor.Interceptor;
import javax.interceptor.InvocationContext;
import javax.ws.rs.core.Response;

/**
 *
 * @author r-terai
 */
@Interceptor
public class ObserverInterceptor {

    private static final Logger logger = new Logger(ObserverInterceptor.class.getName());

    public ObserverInterceptor() {
    }

    @AroundInvoke
    public Object intercept(InvocationContext ctx) throws Exception {
        String application = Util.getApplicationName();
        String module = Util.getModuleName();
        Class cls = ctx.getMethod().getDeclaringClass();
        Method method = ctx.getMethod();

        ObserverResultClient client = new ObserverResultClient();
        ObserverItem item = new ObserverItem(application, module, cls.getName(), method.getName(), 200, (new Date()).toString());
        Response response = client.postObserverItem(item);
        logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={};response={}", application, module, cls.getName(), method.getName(), response.getStatus());
        client.close();

        Object object = ctx.proceed();
        return object;
    }

    @AroundTimeout
    public Object interceptTimeout(InvocationContext ctx) throws Exception {
        String application = Util.getApplicationName();
        String module = Util.getModuleName();
        Class cls = ctx.getMethod().getDeclaringClass();
        Method method = ctx.getMethod();

        ObserverResultClient client = new ObserverResultClient();
        ObserverItem item = new ObserverItem(application, module, cls.getName(), method.getName(), 200, (new Date()).toString());
        Response response = client.postObserverItem(item);
        logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={};response={}", application, module, cls.getName(), method.getName(), response.getStatus());
        client.close();

        Object object = ctx.proceed();
        return object;
    }

}
