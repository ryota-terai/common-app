/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.r_terai.java.ee.common.commonapp.rest;

import com.r_terai.java.util.Logger;
import javax.annotation.Resource;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.enterprise.context.RequestScoped;
import javax.transaction.UserTransaction;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Path;

/**
 * REST Web Service
 *
 * @author r-terai
 */
@RequestScoped
@TransactionManagement(TransactionManagementType.BEAN)
@Path("rest")
public class GenericResource {

    @Context
    private UriInfo context;

    @Resource
    UserTransaction tx;

//    @EJB(name = "PostInformationGeoJsonBean")
//    PostInformationGeoJsonEJB postInformationGeoJsonBean;
//
//    @EJB(name = "ShelterInformationEJB")
//    PointInformationEJB shelterInformationGeoJsonBean;

    private static final Logger LOG = Logger.getLogger(GenericResource.class.getName());

    /**
     * Creates a new instance of GenericResource
     */
    public GenericResource() {
    }

//    /**
//     * Retrieves representation of an instance of
//     * ghp2021.ghp2021app.rest.GenericResource
//     *
//     * @return an instance of java.lang.String
//     */
//    @GET
//    @Path(value = "/disasterInfo")
//    @Produces(MediaType.APPLICATION_JSON)
//    public String getDisasterInfo() {
//        FeatureCollection geoJson = null;
//        try {
//            tx.begin();
//            geoJson = postInformationGeoJsonBean.getDisasterInformationGeoJson();
//
//            tx.commit();
//        } catch (HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | NotSupportedException | SystemException | RollbackException ex) {
//            try {
//                tx.rollback();
//                LOG.log(Level.SEVERE, null, ex);
//                return null;
//            } catch (IllegalStateException | SecurityException | SystemException ex1) {
//                LOG.log(Level.SEVERE, null, ex);
//                return null;
//            }
//        }
//        return geoJson != null ? geoJson.toJson() : null;
//    }
//
//    @GET
//    @Path(value = "/shelterInfo")
//    @Produces(MediaType.APPLICATION_JSON)
//    public String getShelterInfo(@QueryParam("areaCode") final String administrativeAreaCode,
//            @QueryParam("P20_007") final boolean p20_007,
//            @QueryParam("P20_008") final boolean p20_008,
//            @QueryParam("P20_009") final boolean p20_009,
//            @QueryParam("P20_010") final boolean p20_010,
//            @QueryParam("P20_011") final boolean p20_011,
//            @QueryParam("open") final Boolean open) {
//        FeatureCollection geoJson = null;
//        try {
//            tx.begin();
//            List<ShelterInformationView> shelters = shelterInformationGeoJsonBean.search(administrativeAreaCode, "shelter", p20_007, p20_008, p20_009, p20_010, p20_011, open);
//
//            geoJson = convertToGeoJSON(shelters);
//            tx.commit();
//        } catch (HeuristicMixedException | HeuristicRollbackException | SecurityException | IllegalStateException | NotSupportedException | SystemException | RollbackException ex) {
//            try {
//                tx.rollback();
//                LOG.log(Level.SEVERE, null, ex);
//                return null;
//            } catch (IllegalStateException | SecurityException | SystemException ex1) {
//                LOG.log(Level.SEVERE, null, ex1);
//                return null;
//            }
//        }
//        return geoJson != null ? geoJson.toJson() : null;
//    }
//
//    private FeatureCollection convertToGeoJSON(List<ShelterInformationView> shelters) {
//        FeatureCollection geoJson;
//        List<Feature> features = new ArrayList();
//        for (ShelterInformationView shelter : shelters) {
//            Point point = Point.fromLngLat(shelter.getX(), shelter.getY());
//            Feature feature = Feature.fromGeometry(point);
//            feature.addStringProperty("P20_001", shelter.getP20001());
//            feature.addStringProperty("P20_002", shelter.getP20002());
//            feature.addStringProperty("P20_003", shelter.getP20003());
//            feature.addStringProperty("P20_004", shelter.getP20004());
//            feature.addNumberProperty("P20_005", shelter.getP20005());
//            feature.addNumberProperty("P20_006", shelter.getP20006());
//            feature.addNumberProperty("P20_007", shelter.getP20007());
//            feature.addNumberProperty("P20_008", shelter.getP20008());
//            feature.addNumberProperty("P20_009", shelter.getP20009());
//            feature.addNumberProperty("P20_010", shelter.getP20010());
//            feature.addNumberProperty("P20_011", shelter.getP20011());
//            feature.addNumberProperty("P20_012", shelter.getP20012());
//            feature.addBooleanProperty("open", shelter.getOpen() != null ? shelter.getOpen() != 0 : false);
//            feature.addStringProperty("comment", shelter.getComment());
//
//            features.add(feature);
//        }
//        geoJson = FeatureCollection.fromFeatures(features);
//        return geoJson;
//    }
}
