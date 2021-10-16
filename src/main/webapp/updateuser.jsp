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
                    <th>Nombre</th>
                    <th>Nacimiento</th>
                    <th>Identificación</th>
                    <th>Tipo de id</th>
                    <th>Frecuencia</th>
                    <th>Presupuesto</th>
                    <th>Destino</th>
                    <th>Tarjeta</th>
                </thead>
                <%
                    QTravelWS ws = new QTravelWS();
                    final String searchDoc = request.getParameter("searchDoc");
                    DBCursor results = ws.findObject("tourists", "identity", searchDoc);
                    
                    if(results != null){
                        while(results.hasNext()){
                            DBObject tourist = results.next();
                            out.print("<tr>");
                            out.println("<td>"+tourist.get("name")+"</td>");
                            out.println("<td>"+tourist.get("lname")+"</td>");
                            out.println("<td>"+tourist.get("birthday")+"</td>");   
                            out.println("<td>"+tourist.get("identity")+"</td>");
                            out.println("<td>"+tourist.get("identityType")+"</td>");
                            out.println("<td>"+tourist.get("frequency")+"</td>");
                            out.println("<td>"+tourist.get("budget")+"</td>");
                            out.println("<td>"+tourist.get("destination")+"</td>");
                            out.println("<td>"+tourist.get("creditCard")+"</td>");
                            out.print("</tr>");
                        }
                    }else{
                        response.sendRedirect("index.jsp");
                    }
                %>
            </table>
            <h4>¿Qué desea modificar?</h4>
            <form method="POST" action="updateuser2.jsp">
                <select id="criteria" name="criteria" value="">
                    <option value=""></option>
                    <option value="name">Nombre</option>
                    <option value="lname">Apellido</option>
                    <option value="birthday">Fecha de nacimiento</option>
                    <option value="identity">Identificación</option>
                    <option value="identityType">Tipo de documento</option>
                    <option value="frequency">Frecuencia</option>
                    <option value="budget">Presupuesto</option>
                    <option value="destination">Destino</option>
                    <option value="creditCard">Tarjeta de crédito</option>
                </select><br>
                <h5>Nuevo valor</h5>
                <input type="text" id="change" name="change">
                <input type="submit" value="Modificar">
                             
            </form>
            <%
                session.setAttribute("sd", searchDoc);
            %>
        </div>
    </body>
</html>