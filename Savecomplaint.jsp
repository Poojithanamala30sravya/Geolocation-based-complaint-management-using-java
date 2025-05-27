<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="complaint.Complaint" %>
<%
   try{ Complaint complaint = new Complaint();
    int complaintId = complaint.generateComplaintId();
    out.println("Your Complaint ID is: " + complaintId);
    String subject="",latitude="",longitude="";
   
   // if (issaved) {
        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            String savePath = "C:\\Users\\venugopal\\OneDrive\\Desktop\\complaintimages\\";

            try {
                List<FileItem> items = upload.parseRequest(request);
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        String originalFileName = new File(item.getName()).getName();

                        String[] nameParts = originalFileName.split("\\.");
                        String fileExtension = nameParts.length > 1 ? "." + nameParts[nameParts.length - 1] : "";

                        String newFileName = "complaint_" + complaintId + fileExtension;
                        String filePath = savePath + File.separator + newFileName;

                        File storeFile = new File(filePath);
                        item.write(storeFile);

                        out.println("File uploaded as: " + newFileName + " to: " + filePath + "<br>");
                    } else {
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString();
                        out.println(fieldName + ": " + fieldValue + "<br>");
                        if(fieldName.equalsIgnoreCase("subject"))
                          subject = fieldValue;
                        if(fieldName.equalsIgnoreCase("latitude"))
                          latitude = fieldValue;
                        if(fieldName.equalsIgnoreCase("longitude"))
                          longitude = fieldValue;
                         
                    }
                }
                
                 boolean issaved = complaint.saveComplaint(complaintId, subject, Double.parseDouble(latitude), Double.parseDouble(longitude));
                 
                 if(!issaved){
                  out.println("Error in saving complaint in database");
                 }
   
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            out.println("The form is not multipart.");
        }
   // } else {
      //  out.println("Complaint could not be saved");
    //}
   }
   catch(Exception e){
   out.println(e.getMessage());
   }
%>
