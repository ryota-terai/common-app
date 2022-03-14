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
@Table(name = "OBSERVER_TARGET")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ObserverTarget.findAll", query = "SELECT o FROM ObserverTarget o"),
    @NamedQuery(name = "ObserverTarget.findById", query = "SELECT o FROM ObserverTarget o WHERE o.id = :id"),
    @NamedQuery(name = "ObserverTarget.findByApplication", query = "SELECT o FROM ObserverTarget o WHERE o.application = :application"),
    @NamedQuery(name = "ObserverTarget.findByModule", query = "SELECT o FROM ObserverTarget o WHERE o.module = :module"),
    @NamedQuery(name = "ObserverTarget.findByMethod", query = "SELECT o FROM ObserverTarget o WHERE o.method = :method"),
    @NamedQuery(name = "ObserverTarget.findByUpdateTime", query = "SELECT o FROM ObserverTarget o WHERE o.updateTime = :updateTime")})
public class ObserverTarget implements Serializable {

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
    @Column(name = "METHOD")
    private String method;
    @Lob
    @Column(name = "STATUS")
    private String status;
    @Basic(optional = false)
    @Column(name = "UPDATE_TIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;

    public ObserverTarget() {
    }

    public ObserverTarget(Integer id) {
        this.id = id;
    }

    public ObserverTarget(Integer id, String application, String module, String class1, String method, Date updateTime) {
        this.id = id;
        this.application = application;
        this.module = module;
        this.class1 = class1;
        this.method = method;
        this.updateTime = updateTime;
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

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        if (!(object instanceof ObserverTarget)) {
            return false;
        }
        ObserverTarget other = (ObserverTarget) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.r_terai.java.ee.common.entity.ObserverTarget[ id=" + id + " ]";
    }
    
}
