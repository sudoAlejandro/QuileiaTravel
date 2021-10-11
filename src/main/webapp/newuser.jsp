<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%
    QTravelWS ws = new QTravelWS();

    String name = request.getParameter("fname");
    String birthDate = request.getParameter("birthDate");
    String docNum = request.getParameter("docNum");
    String docType = request.getParameter("docType");
    String freq = request.getParameter("freq");
    String budget = request.getParameter("budget");
    String destiny = request.getParameter("destiny");
    Boolean card = Boolean.parseBoolean(request.getParameter("card"));
    String travelDate = request.getParameter("travelDate");
    
    if(ws.sobrecupo(request.getParameter("destiny"), request.getParameter("travelDate"))){
        response.sendRedirect("index.jsp");
    }else{
        ws.insertTourist(name, birthDate, docNum, docType, Integer.parseInt(freq), Double.parseDouble(budget), destiny, card, travelDate);
        response.sendRedirect("index.jsp");
    }    
%>
