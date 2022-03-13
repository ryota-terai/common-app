/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author r-terai
 */
@Entity
@Table(name = "TIMER_SETTING")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TimerSetting.findAll", query = "SELECT t FROM TimerSetting t"),
    @NamedQuery(name = "TimerSetting.findById", query = "SELECT t FROM TimerSetting t WHERE t.id = :id"),
    @NamedQuery(name = "TimerSetting.findByApplication", query = "SELECT t FROM TimerSetting t WHERE t.application = :application"),
    @NamedQuery(name = "TimerSetting.findByModule", query = "SELECT t FROM TimerSetting t WHERE t.module = :module"),
    @NamedQuery(name = "TimerSetting.findByTimeout", query = "SELECT t FROM TimerSetting t WHERE t.timeout = :timeout"),
    @NamedQuery(name = "TimerSetting.findByInterval", query = "SELECT t FROM TimerSetting t WHERE t.interval = :interval")})
public class TimerSetting implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "APPLICATION")
    private String application;
    @Basic(optional = false)
    @Column(name = "MODULE")
    private String module;
    @Basic(optional = false)
    @Lob
    @Column(name = "CLASS")
    private String class1;
    @Basic(optional = false)
    @Column(name = "TIMEOUT")
    private int timeout;
    @Basic(optional = false)
    @Column(name = "INTERVAL")
    private int interval;

    public TimerSetting() {
    }

    public TimerSetting(Integer id) {
        this.id = id;
    }

    public TimerSetting(Integer id, String application, String module, String class1, int timeout, int interval) {
        this.id = id;
        this.application = application;
        this.module = module;
        this.class1 = class1;
        this.timeout = timeout;
        this.interval = interval;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public int getInterval() {
        return interval;
    }

    public void setInterval(int interval) {
        this.interval = interval;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TimerSetting)) {
            return false;
        }
        TimerSetting other = (TimerSetting) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.r_terai.java.commonentity.TimerSetting[ id=" + id + " ]";
    }
    
}
