package com.mycompany.qtravel;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Alejandro Ríos
 */
//Web Service, clase principal que contiene las funciones
@WebService(serviceName = "QTravelWS")
public class QTravelWS {
    //Este método se utiliza para conectarse a la base de datos mediante el puerto 27017 (puerto por defecto)
    @WebMethod(operationName = "connect")
    public DB connection() {
        MongoClient mongo = new MongoClient("localhost", 27017);
        DB db = (DB) mongo.getDB("QuileiaTravelDB");
        return db;
    }
    //Método para añadir turista
    @WebMethod(operationName = "addT")
    public String insertTourist(@WebParam(name = "name") String name,@WebParam(name = "lname") String lname, @WebParam(name = "birthday") String birthday, @WebParam(name = "identity") String identity, @WebParam(name = "identityType") String identityType, @WebParam(name = "frequency") Integer frequency, @WebParam(name = "budget") Double budget, @WebParam(name = "destination") String destination, @WebParam(name = "creditCard") Boolean creditCard, @WebParam(name = "travelDate") String travelDate) {
        DB db = connection();
        DBCollection table = db.getCollection("tourists");
        BasicDBObject document = new BasicDBObject();
        document.put("name",name);
        document.put("lname", lname);
        document.put("birthday", birthday);
        document.put("identity",identity);
        document.put("identityType",identityType);
        document.put("frequency",frequency);
        document.put("budget",budget);
        document.put("destination",destination);
        document.put("creditCard",creditCard);
        document.put("travelDate",travelDate);
        table.insert(document);
        return "Inserción de turista exitosa";
    }
    //Método para añadir ciudad
    @WebMethod(operationName = "addC")
    public String insertCity(@WebParam(name = "name") String name, @WebParam(name = "population") Integer population, @WebParam(name = "touristPlace") String touristPlace, @WebParam(name = "hotel") String hotel) {
        DB db = connection();
        DBCollection table = db.getCollection("cities");
        BasicDBObject document = new BasicDBObject();
        document.put("id", greatestId());
        //document.put("id", seeAll("cities").size()+1);
        document.put("name",name);
        document.put("population",population);
        document.put("touristPlace",touristPlace);
        document.put("hotel",hotel);
        table.insert(document);    
        return "Inserción de ciudad exitosa";
    }
    //Método para detectar el siguiente ID de la ciudad
    @WebMethod(operationName = "greatestID")
    public int greatestId() {
        DBCursor cities = seeAll("cities");
        if(!cities.hasNext()) {
            return 1;
        }
        for(int i=0; i<cities.size()-1;i++){
            cities.next();
        }
        return (int) cities.next().get("id")+1;
    }
    //Método para ver la tabla completa (turistas o ciudades)
    @WebMethod(operationName = "seeAll")
    public DBCursor seeAll(@WebParam(name = "tableName") String tableName) {
        DB db = connection();
        DBCollection table = db.getCollection(tableName);
        DBCursor cursor = table.find();
        return cursor;
    }
    //Método para encontrar un documento en cualquiera de las tablas
    @WebMethod(operationName = "findObject")
    public DBCursor findObject(@WebParam(name = "tableName") String tableName, @WebParam(name = "criteria") String criteria, @WebParam(name = "filt") String filt) {
        DB db = connection();
        DBCollection table = db.getCollection(tableName);
        if(criteria.equals("id")){
            DBObject matchs = new BasicDBObject(criteria, Integer.parseInt(filt));
            DBCursor result = table.find(matchs);
            return result;
        }else{
            DBObject matchs = new BasicDBObject(criteria, filt);
            DBCursor result = table.find(matchs);
            return result;
        }        
    }
    //Método para actualizar o editar un documento
    @WebMethod(operationName = "updateObject")
    public void updateObject(@WebParam(name = "tableName") String tableName, @WebParam(name = "document") DBObject document, @WebParam(name = "property") String property, @WebParam(name = "value") String value) {
        DB db = connection();
        DBCollection table = db.getCollection(tableName);
        BasicDBObject changes = new BasicDBObject();
        changes.append("$set", new BasicDBObject().append(property, value));
        table.updateMulti(document, changes);
    }
    //Método para eliminar un objeto
    @WebMethod(operationName = "deleteObject")
    public void deleteObject(@WebParam(name = "tableName") String tableName, @WebParam(name = "document") DBObject document) {
        DB db = connection();
        DBCollection table = db.getCollection(tableName);
        table.remove(document);
    }
    //Método para determinar si más de 5 turistas reservaron la misma fecha de viaje a la misma ciudad
    @WebMethod(operationName = "sobrecupo")
    public Boolean sobrecupo(@WebParam(name = "city") String city, @WebParam(name = "travelDate") String travelDate) {
        DB db = connection();
        DBCollection touristTable = db.getCollection("tourists");
        BasicDBObject filtro = new BasicDBObject();
        filtro.put("destination", city);
        filtro.put("travelDate", travelDate);
        DBCursor results = touristTable.find(filtro);
        return results.size() > 1;
    }
}