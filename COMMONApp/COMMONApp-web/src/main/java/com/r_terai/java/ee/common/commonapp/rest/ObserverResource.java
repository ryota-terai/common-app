/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.rest;

import com.r_terai.java.ee.common.ObserverItem;
import com.r_terai.java.ee.common.commonapp.ejb.ObserverEJBLocal;
import com.r_terai.java.ee.common.entity.ObserverResult;
import com.r_terai.java.ee.common.entity.ObserverTarget;
import com.r_terai.java.util.Logger;
import com.r_terai.java.util.Logger.Level;
import java.net.URI;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.enterprise.context.RequestScoped;
import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.NotSupportedException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author r-terai
 */
@RequestScoped
@TransactionManagement(TransactionManagementType.BEAN)
@Path("observer")
public class ObserverResource {

    @Context
    private UriInfo context;

    @Resource
    UserTransaction tx;

    @EJB(name = "ObserverEJB")
    ObserverEJBLocal observerEJB;

    private static final Logger LOG = Logger.getLogger(ObserverResource.class.getName());

    /**
     * Creates a new instance of GenericResource
     */
    public ObserverResource() {
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ObserverResult> getResults() {
        List<ObserverResult> result = null;
        try {
            tx.begin();
            result = observerEJB.getResults();
            tx.commit();
        } catch (HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | NotSupportedException | SystemException | RollbackException ex) {
            try {
                tx.rollback();
                LOG.log(Level.SEVERE, null, ex);
                return null;
            } catch (IllegalStateException | SecurityException | SystemException ex1) {
                LOG.log(Level.SEVERE, null, ex1);
                return null;
            }
        }
        return result;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postObserverItem(ObserverItem item) {
        ObserverTarget target;
        try {
            tx.begin();
            target = observerEJB.record(item);
            tx.commit();
        } catch (HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | NotSupportedException | SystemException | RollbackException ex) {
            try {
                tx.rollback();
                LOG.log(Level.SEVERE, null, ex);
                return Response.serverError().build();
            } catch (IllegalStateException | SecurityException | SystemException ex1) {
                LOG.log(Level.SEVERE, null, ex1);
                return Response.serverError().build();
            }
        }
        return Response.created(URI.create("/rest/observer/" + target.getId())).build();
    }
}
