
<%@page contentType="text/html" pageEncoding="UTF-8" import="dao.Database,authentication.admin,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
            int uid=Integer.parseInt(request.getParameter("UserId"));
            String pwd=request.getParameter("Password");
            admin ad=new admin(uid,pwd);
            if(ad.validateUser())
            {
                String username=ad.getUsername();
                session.setAttribute("username",username);
             response.sendRedirect("admin.jsp");
            }
            else
            {
             response.sendRedirect("admin.html");
            }
       
    %>
    </body>
</html>
