<%@page import="com.mycompany.qtravel.QTravelWS"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%
    QTravelWS ws = new QTravelWS();
    String criteria = request.getParameter("criteria");
    String change = request.getParameter("change");
    DBCursor matchs = ws.findObject("tourists", "identity", session.getAttribute("sd").toString());
    if(criteria != null){
        if(!matchs.hasNext()){
            response.sendRedirect("index.jsp");
        }else{
            DBObject choosen = matchs.next();
            ws.updateObject("tourists", choosen, criteria, change);
        }
    }
    response.sendRedirect("index.jsp");
%>