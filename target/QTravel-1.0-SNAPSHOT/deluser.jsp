<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%
    QTravelWS ws = new QTravelWS();
    DBCursor results = ws.findObject("tourists", "identity", request.getParameter("touristSelected"));
    ws.deleteObject("tourists", results.next());
    response.sendRedirect("index.jsp");    
%>