<%@ page import="dao.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <%
        String username = (String) session.getAttribute("username");
    %>       
    <h1>Welcome, <%= username %>!</h1>     
    <br/>
    <br/>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .pending {
            background-color: red;
            color: white;
        }
        .solved {
            background-color: green;
            color: white;
        }
    </style>
</head>
<body>
    <h3>Registered Complaints:</h3>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Fetch complaint data
            conn = Database.getConnection();
            String fetchQuery = "SELECT COMPLAINT_ID, SUBJECT, LATITUDE, LONGITUDE, COMPLAINT_STATUS FROM COMPLAINT_DETAILS";
            pstmt = conn.prepareStatement(fetchQuery);
            rs = pstmt.executeQuery();
    %>

    <form method="post" action="UpdateStatus.jsp">
        <table>
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Subject</th>
                    <th>Latitude</th>
                    <th>Longitude</th>
                    <th>Complaint Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        int complaintId = rs.getInt("COMPLAINT_ID");
                        String subject = rs.getString("SUBJECT");
                        double latitude = rs.getDouble("LATITUDE");
                        double longitude = rs.getDouble("LONGITUDE");
                        String complaintStatus = rs.getString("COMPLAINT_STATUS");
                %>
                <tr>
                    <td><%= complaintId %></td>
                    <td><%= subject %></td>
                    <td><%= latitude %></td>
                    <td><%= longitude %></td>
                    <td>
                        <select name="status_<%= complaintId %>">
                            <option value="Solved" class="solved" <%= "Solved".equalsIgnoreCase(complaintStatus) ? "selected" : "" %>>Solved</option>
                            <option value="Pending" class="pending" <%= "Pending".equalsIgnoreCase(complaintStatus) ? "selected" : "" %>>Pending</option>
                        </select>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <br>
        <button type="submit">Update Status</button>
    </form>

    <%
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>
</body>
</html>
