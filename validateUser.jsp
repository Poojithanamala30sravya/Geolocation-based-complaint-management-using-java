
<%@page contentType="text/html" pageEncoding="UTF-8" import="dao.Database,authentication.login,java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
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
            login log=new login(uid,pwd);
            if(log.validateUser())
            {
                String username=log.getUsername();
                session.setAttribute("username",username);
             response.sendRedirect("welcome.jsp");
            }
            else
            {
             response.sendRedirect("index.html");
            }
       
    %>
    </body>
</html>
