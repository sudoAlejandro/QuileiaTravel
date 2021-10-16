<%-- 
    Document   : index
    Created on : Oct 8, 2021, 12:44:31 AM
    Author     : Alejandro Ríos
--%>

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
            <h1 id="Titulo">Quileia Travel!</h1>
            <% 
                QTravelWS ws = new QTravelWS();
            %>
            <form>
                <input type="radio" id="tour" name="election" value="tourists">
                <label for="tour">Turistas</label>
                <input type="radio" id="city" name="election" value="cities">
                <label for="city">Ciudades</label><br>
                <button type="submit" onclick="consultar()" style="margin:1rem;">Consultar</button>
            </form>
            <table class="table">
            <%
                String val = request.getParameter("election");
                Boolean titles = false;
                if (val != null){
                    DBCursor cursor = ws.seeAll(val);
                    while(cursor.hasNext()){
                        if(val.equals("tourists")){
                            if(!titles){
                                //String st = "<tr style=\"background-color: #95A5A6;\">";
                                out.print("<thead>");
                                out.print("<tr class=\"tableHeader\">");
                                out.println("<th>Nombres</th>");
                                out.println("<th>Apellidos</th>");
                                out.println("<th>Nacimiento</th>");
                                out.println("<th>Identificación</th>");
                                out.println("<th>tipo de id</th>");
                                out.println("<th>frecuencia</th>");
                                out.println("<th>presupuesto</th>");
                                out.println("<th>destino</th>");
                                out.println("<th>Tarjeta de Crédito</th>");
                                out.print("</tr>");
                                out.print("</thead>");
                                titles = true;
                            }
                            DBObject tourist = cursor.next();
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
                        if(val.equals("cities")){
                            if(!titles){
                                out.print("<tr>");
                                out.println("<th>id</th>");
                                out.println("<th>Ciudad</th>");
                                out.println("<th>Población</th>");
                                out.println("<th>Sitio turístico</th>");
                                out.println("<th>Hotel</th>");
                                out.print("</tr>");
                                titles = true;
                            }
                            DBObject city = cursor.next();
                            out.print("<tr>");
                            out.println("<td>"+city.get("id")+"</td>");
                            out.println("<td>"+city.get("name")+"</td>");
                            out.println("<td>"+city.get("population")+"</td>");
                            out.println("<td>"+city.get("touristPlace")+"</td>");
                            out.println("<td>"+city.get("hotel")+"</td>");
                            out.print("</tr>");
                        }
                    }
                }
            %>
            </table>   
            <button id="addt" onclick="userRegis()">Agregar Turista</button>
            <button id="updt" onclick="userUpdate()">Actualizar Turista</button>
            <button id="delt" onclick="userDelete()">Eliminar Turista</button>
            <button id="addc" onclick="cityRegis()">Agregar Ciudad</button>
            <button id="updc" onclick="cityUpdate()">Editar Ciudad</button>
            <button id="delc" onclick="cityDelete()">Eliminar Ciudad</button>
            <%
                DBCursor cursorTuristas = ws.seeAll("tourists");
                DBCursor cursorCiudades = ws.seeAll("cities");
                if(cursorCiudades.size() == 0){
                    out.print("<script>"
                            + "document.getElementById(\"addt\").disabled = true;"
                            + "document.getElementById(\"updt\").disabled = true;"
                            + "document.getElementById(\"delt\").disabled = true;"
                            + "document.getElementById(\"updc\").disabled = true;"
                            + "document.getElementById(\"delc\").disabled = true;"
                            
                            + "</script>");
                }
                if(cursorTuristas.size() == 0){
                    out.print("<script>"
                            + "document.getElementById(\"updt\").disabled = true;"
                            + "document.getElementById(\"delt\").disabled = true;"                            
                            + "</script>");
                }
            %>
        </div>
        <div id="touristRegister" class="box">
            <br><br>
            <form method="POST" action="newuser.jsp">
                <label for="fname">Nombre*:  </label>
                <input type="text" id="fname" name="fname" style="width: 15rem; margin-right: 2rem" required>
                <label for"lname">Apellido*:  </label>
                <input type="text" id="lname" name="lname" style="width: 15rem; margin-right: 2rem" required><br><br>
                <label for="birthDate">Fecha de nacimiento*:  </label>
                <input type="date" id="birthDate" name="birthDate" value="1997-01-27" min="1900-01-01" max="2021-01-01"><br><br>
                <label for="docNum">Número de documento*:  </label>
                <input type="text" id="docNum" name="docNum" style="width: 11rem; margin-right: 2rem" required>
                <label for="docType">Tipo de documento*:  </label>
                <input type="text" id="docType" name="docType" style="width: 10rem" required><br><br>
                <label for="freq">Número de viajes al mes*:  </label>
                <input type="number" id="freq" name="freq" value="0" min="0" max="100" style="margin-right: 2rem" required>
                <label for="budget">Presupuesto*:  </label>
                <input type="number" step="any" id="budget" name="budget" value="0" style="margin-right: 1rem" required>
                <label for="destiny">Destino*:  </label>
                <select id="destiny" name="destiny" required>
                    <%
                        while(cursorCiudades.hasNext()){
                            DBObject actual = cursorCiudades.next();
                            out.print("<option value=\""+actual.get("name")+"\">"+actual.get("name")+"</option>");
                        }
                    %>
                </select><br><br>
                <label for="card">Tarjeta de Crédito*:  </label>
                <select id="card" name="card" style="margin-right: 2rem">
                    <option value="true">Sí</option>
                    <option value="false">No</option>
                </select>
                <label for="travelDate">Fecha de viaje*:  </label>
                <input type="date" id="travelDate" name="travelDate" value="2022-01-01" min="2021-01-01" max="2030-12-31" style="margin-right: 2rem" required>
                <input type="submit" value="Registrar turista">
            </form>
        </div>
        <div id="updateT" class="box">
            <form method="POST" action="updateuser.jsp">
                <label for="searchDoc">Número de documento*:  </label>
                <input type="text" id="searchDoc" name="searchDoc" style="width: 15rem" required>
                <input type="submit" value="Buscar turistas">
            </form>            
        </div>
        <div id="addCity" class="box">
            <form method="POST" action="newcity.jsp">
                <label for="name">Nombre de la ciudad*:  </label>
                <input type="text" id="name" name="name" style="margin-right: 2rem" required>
                <label for="population">Población*:  </label>
                <input type="number" id="population" name="population" required><br><br>
                <label for="touristPlace">Lugar Turístico*:  </label>
                <input type="text" id="touristPlace" name="touristPlace" style="margin-right: 2rem" required>
                <label for="hotel">Hotel*:  </label>
                <input type="text" id="hotel" name="hotel" required><br><br>
                <input type="submit" value="Agregar">
            </form>
        </div>
        <div id="updateC" class="box">
            <form method="POST" action="updatecity.jsp">
                <label for="searchCity">ID de Ciudad*:  </label>
                <input type="text" id="searchCity" name="searchCity" style="width: 15rem" required>
                <input type="submit" value="Buscar ciudad">
            </form>            
        </div>
        <div id="delT" class="box">
            <form method="POST" action="deluser.jsp">
                <label for="touristSelected">Identifición del turista*:  </label>
                <input type="text" id="touristSelected" name="touristSelected" style="width: 15rem" required>
                <input type="submit" value="Eliminar turista">
            </form>            
        </div>
        <div id="delC" class="box">
            <form method="POST" action="delcity.jsp">
                <label for="citySelected">Id de la ciudad*:  </label>
                <input type="text" id="citySelected" name="citySelected" style="width: 15rem" required>
                <input type="submit" value="Eliminar ciudad">
            </form>            
        </div>
        <script>
            function consultar() {
                document.getElementByClass("table").style.display = "flex";      
            }
            function search() {
                document.getElementById("updateT").style.display = "flex";
            }
            function userRegis() {
                document.getElementById("touristRegister").style.display = "flex";
                document.getElementById("updateT").style.display = "none";
                document.getElementById("updateC").style.display = "none";
                document.getElementById("delT").style.display = "none";
                document.getElementById("delC").style.display = "none";
                document.getElementById("addCity").style.display = "none";
            }
            function userUpdate() {
                document.getElementById("updateT").style.display = "flex";
                document.getElementById("touristRegister").style.display = "none";
                document.getElementById("updateC").style.display = "none";
                document.getElementById("delT").style.display = "none";
                document.getElementById("delC").style.display = "none";
                document.getElementById("addCity").style.display = "none";
            }
            function cityRegis() {
                document.getElementById("addCity").style.display = "flex";
                document.getElementById("touristRegister").style.display = "none";
                document.getElementById("updateC").style.display = "none";
                document.getElementById("delT").style.display = "none";
                document.getElementById("delC").style.display = "none";
                document.getElementById("updateT").style.display = "none";
            }
            function cityUpdate() {
                document.getElementById("updateC").style.display = "flex";
                document.getElementById("addCity").style.display = "none";
                document.getElementById("touristRegister").style.display = "none";
                document.getElementById("delT").style.display = "none";
                document.getElementById("delC").style.display = "none";
                document.getElementById("updateT").style.display = "none";
            }
            function userDelete() {
                document.getElementById("delT").style.display = "flex";
                document.getElementById("updateC").style.display = "none";
                document.getElementById("addCity").style.display = "none";
                document.getElementById("touristRegister").style.display = "none";                
                document.getElementById("delC").style.display = "none";
                document.getElementById("updateT").style.display = "none";
            }
            function cityDelete() {
                document.getElementById("delC").style.display = "flex";
                document.getElementById("updateC").style.display = "none";
                document.getElementById("addCity").style.display = "none";
                document.getElementById("touristRegister").style.display = "none";
                document.getElementById("delT").style.display = "none";                
                document.getElementById("updateT").style.display = "none";
            }
        </script>
    </body>
</html>
