<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%
    QTravelWS ws = new QTravelWS();

    String name = request.getParameter("name");
    String population = request.getParameter("population");
    String touristPlace = request.getParameter("touristPlace");
    String hotel = request.getParameter("hotel");

    ws.insertCity(name, Integer.parseInt(population), touristPlace, hotel);
    response.sendRedirect("index.jsp");
%>