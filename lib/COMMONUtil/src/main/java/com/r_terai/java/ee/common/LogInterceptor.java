/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common;

import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Util;
import java.lang.reflect.Method;
import javax.interceptor.AroundInvoke;
import javax.interceptor.AroundTimeout;
import javax.interceptor.Interceptor;
import javax.interceptor.InvocationContext;

/**
 *
 * @author r-terai
 */
@Interceptor
public class LogInterceptor {

    private static final Logger logger = new Logger(LogInterceptor.class.getName());

    public LogInterceptor() {
    }

    @AroundInvoke
    public Object intercept(InvocationContext ctx) throws Exception {
        String application = Util.getApplicationName();
        String module = Util.getModuleName();
        Class cls = ctx.getMethod().getDeclaringClass();
        Method method = ctx.getMethod();

//        logger.log(Logger.Level.OFF, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.FATAL, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.ERROR, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.WARN, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
        logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.DEBUG, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.TRACE, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());
//        logger.log(Logger.Level.ALL, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());

        Object object = ctx.proceed();
        return object;
    }

    @AroundTimeout
    public Object interceptTimeout(InvocationContext ctx) throws Exception {
        String application = Util.getApplicationName();
        String module = Util.getModuleName();
        Class cls = ctx.getMethod().getDeclaringClass();
        Method method = ctx.getMethod();

        logger.log(Logger.Level.INFO, "Application={};Module={};Class={};Method={}", application, module, cls.getName(), method.getName());

        Object object = ctx.proceed();
        return object;
    }
}
