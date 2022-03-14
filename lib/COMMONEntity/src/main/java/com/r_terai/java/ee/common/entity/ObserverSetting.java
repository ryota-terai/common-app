/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.entity;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author r-terai
 */
@Entity
@Table(name = "OBSERVER_SETTING")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ObserverSetting.findAll", query = "SELECT o FROM ObserverSetting o"),
    @NamedQuery(name = "ObserverSetting.findById", query = "SELECT o FROM ObserverSetting o WHERE o.id = :id"),
    @NamedQuery(name = "ObserverSetting.findByEnable", query = "SELECT o FROM ObserverSetting o WHERE o.enable = :enable"),
    @NamedQuery(name = "ObserverSetting.findByApplication", query = "SELECT o FROM ObserverSetting o WHERE o.application = :application"),
    @NamedQuery(name = "ObserverSetting.findByModule", query = "SELECT o FROM ObserverSetting o WHERE o.module = :module"),
    @NamedQuery(name = "ObserverSetting.findByMethod", query = "SELECT o FROM ObserverSetting o WHERE o.method = :method"),
    @NamedQuery(name = "ObserverSetting.findByTimeout", query = "SELECT o FROM ObserverSetting o WHERE o.timeout = :timeout"),
    @NamedQuery(name = "ObserverSetting.findByIntervalTime", query = "SELECT o FROM ObserverSetting o WHERE o.intervalTime = :intervalTime"),
    @NamedQuery(name = "ObserverSetting.findByUpdateTime", query = "SELECT o FROM ObserverSetting o WHERE o.updateTime = :updateTime")})
public class ObserverSetting implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "ENABLE")
    private short enable;
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
    @Column(name = "METHOD")
    private String method;
    @Basic(optional = false)
    @Column(name = "TIMEOUT")
    private int timeout;
    @Basic(optional = false)
    @Column(name = "INTERVAL_TIME")
    private int intervalTime;
    @Column(name = "UPDATE_TIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    public ObserverSetting() {
    }

    public ObserverSetting(Integer id) {
        this.id = id;
    }

    public ObserverSetting(Integer id, short enable, String application, String module, String class1, String method, int timeout, int intervalTime) {
        this.id = id;
        this.enable = enable;
        this.application = application;
        this.module = module;
        this.class1 = class1;
        this.method = method;
        this.timeout = timeout;
        this.intervalTime = intervalTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public short getEnable() {
        return enable;
    }

    public void setEnable(short enable) {
        this.enable = enable;
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

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public int getIntervalTime() {
        return intervalTime;
    }

    public void setIntervalTime(int intervalTime) {
        this.intervalTime = intervalTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
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
        if (!(object instanceof ObserverSetting)) {
            return false;
        }
        ObserverSetting other = (ObserverSetting) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.r_terai.java.ee.common.entity.ObserverSetting[ id=" + id + " ]";
    }
    
}
