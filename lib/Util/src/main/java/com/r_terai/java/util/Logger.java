/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.util;

import org.apache.logging.log4j.LogManager;

/**
 *
 * @author r-terai
 */
public class Logger {

    private org.apache.logging.log4j.Logger logger;

    public enum Level {
        OFF,
        FATAL, SEVERE,
        ERROR,
        WARN,
        INFO,
        DEBUG,
        TRACE,
        ALL
    };

    public Logger(String string) {
        logger = LogManager.getLogger(string);
    }

    public static Logger getLogger(String string) {
        return new Logger(string);
    }

    public void log(Level level, String log) {
        logger.log(convertToLog4jLevel(level), log);
    }

    public void log(Level level, String log, Object... params) {
        logger.log(convertToLog4jLevel(level), log, params);
    }

    public void log(Level level, String log, Throwable throwable) {
        logger.log(convertToLog4jLevel(level), log, throwable);
    }

    private static org.apache.logging.log4j.Level convertToLog4jLevel(Level level) {
        switch (level) {
            case OFF:
                return org.apache.logging.log4j.Level.OFF;
            case FATAL:
            case SEVERE:
                return org.apache.logging.log4j.Level.FATAL;
            case ERROR:
                return org.apache.logging.log4j.Level.ERROR;
            case WARN:
                return org.apache.logging.log4j.Level.WARN;
            case INFO:
                return org.apache.logging.log4j.Level.INFO;
            case DEBUG:
                return org.apache.logging.log4j.Level.DEBUG;
            case TRACE:
                return org.apache.logging.log4j.Level.TRACE;
            case ALL:
                return org.apache.logging.log4j.Level.ALL;
            default:
                return org.apache.logging.log4j.Level.ALL;
        }
    }
}
