<%@ page import="dao.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Updated Complaint Status</title>
</head>
<body>

    <h2>Update Complaint Status</h2>

    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = Database.getConnection();

            if (request.getMethod().equalsIgnoreCase("POST")) {
                for (String key : request.getParameterMap().keySet()) {
                    if (key.startsWith("status_")) {
                        String complaintIdStr = key.split("_")[1];
                        int complaintId = Integer.parseInt(complaintIdStr);
                        String status = request.getParameter(key);

                        // Update status in database
                        String updateQuery = "UPDATE COMPLAINT_DETAILS SET COMPLAINT_STATUS = ? WHERE COMPLAINT_ID = ?";
                        pstmt = conn.prepareStatement(updateQuery);
                        pstmt.setString(1, status);
                        pstmt.setInt(2, complaintId);
                        
                        int rowsUpdated = pstmt.executeUpdate();
                        if (rowsUpdated > 0) {
                         out.println("Complaint ID: " + complaintId + ", Status updated to " + status + "<br>");
                        } else {
                            out.println("Failed to update status for Complaint ID " + complaintId + "<br>");
                        }
                    }
                }
            }
            
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>

    <a href="admin.jsp">Back to Admin Panel</a>
</body>
</html>
