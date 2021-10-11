<%@page import="com.mongodb.BasicDBObject"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%@page import="com.mongodb.DBCursor"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="style.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="main">
            <h3>Coincidencias encontradas</h3>
            
            <table class="table">
                <thead>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Población</th>
                    <th>Lugar turístico</th>
                    <th>Hotel</th>
                </thead>
                <%
                    QTravelWS ws = new QTravelWS();
                    final String searchCity = request.getParameter("searchCity");
                    DBCursor results = ws.findObject("cities", "id", searchCity);
                    while(results.hasNext()){
                        DBObject city = results.next();
                        out.print("<tr>");
                        out.println("<td>"+city.get("id")+"</td>");
                        out.println("<td>"+city.get("name")+"</td>");   
                        out.println("<td>"+city.get("population")+"</td>");
                        out.println("<td>"+city.get("touristicPlace")+"</td>");
                        out.println("<td>"+city.get("hotel")+"</td>");
                        out.print("</tr>");
                    }
                %>
            </table>
            <h4>¿Qué desea modificar?</h4>
            <form method="POST" action="updatecity2.jsp">
                <select id="criteria" name="criteria" value="">
                    <option value=""></option>
                    <option value="id">ID</option>
                    <option value="name">Nombre</option>
                    <option value="population">Población</option>
                    <option value="touristicPlace">Lugar turístico</option>
                    <option value="hotel">Hotel</option>
                </select><br>
                <h5>Nuevo valor</h5>
                <input type="text" id="change" name="change">
                <input type="submit" value="Modificar">
                             
            </form>
            <%
                session.setAttribute("sc", searchCity);
            %>
        </div>
    </body>
</html>