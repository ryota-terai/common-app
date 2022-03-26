/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common;

/**
 *
 * @author r-terai
 */
public class ObserverItem {

    private String application;
    private String module;
    private String class1;
    private String method;
    private int status;
    private String message;

    public ObserverItem() {
    }

    public ObserverItem(String application, String module, String class1, String method, int status, String message) {
        this.application = application;
        this.module = module;
        this.class1 = class1;
        this.method = method;
        this.status = status;
        this.message = message;
    }

    public String getApplication() {
        return application;
    }

    public void setApplication(String application) {
        this.application = application;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getClass1() {
        return class1;
    }

    public void setClass1(String class1) {
        this.class1 = class1;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
