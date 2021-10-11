<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%
    QTravelWS ws = new QTravelWS();
    DBCursor results = ws.findObject("cities", "id", request.getParameter("citySelected"));
    ws.deleteObject("cities", results.next());
    response.sendRedirect("index.jsp");    
%>