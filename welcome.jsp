<%@page contentType="text/html" pageEncoding="UTF-8" import="dao.Database,authentication.login,complaint.Complaint "%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complaint Submission</title>
    
    <style>
        /* Basic page styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Center the content */
        .container {
            width: 80%;
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Box styling for form */
        .box {
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .box h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* Form inputs */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input[type="text"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            border-radius: 4px;
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Hidden fields for latitude and longitude */
        .hidden-fields {
            display: none;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="box">
        <h2>Give Your Complaint Details</h2>
      
        <%
            String username = (String) session.getAttribute("username");
        %>       
        <h1>Welcome, <%= username %>!</h1>     
        <br/>
        <br/>
        
        <!-- Google Maps iframe -->
        <iframe 
            width="300" 
            height="170" 
            frameborder="0" 
            scrolling="no" 
            marginheight="0" 
            marginwidth="0" 
            id="myiframe"
            src="https://maps.google.com/maps?q=0,0&hl=es&z=14&amp;output=embed">
        </iframe>

        <form action="Savecomplaint.jsp" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="subject">Subject of Complaint</label>
                <input type="text" id="subject" name="subject" required>
            </div>

            <!-- Hidden fields for latitude and longitude -->
            <div class="hidden-fields">
                <input type="text" id="latitude" name="latitude">
                <input type="text" id="longitude" name="longitude">
            </div>

            <div class="form-group">
                <label for="complaintImage">Upload Image of Complaint</label>
                <input type="file" id="complaintImage" name="complaintImage" accept="image/*" required>
            </div>

            <div class="form-group">
                <input type="submit" value="Submit Complaint">
            </div>
        </form>
    </div>
</div>

<script>
    // Get current location and populate hidden latitude and longitude fields
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            // Extract latitude and longitude
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;

            // Update hidden fields
            document.getElementById('latitude').value = latitude;
            document.getElementById('longitude').value = longitude;

            // Update iframe src
            var iframeSrc = 'https://maps.google.com/maps?q=' + latitude + ',' + longitude + '&hl=es&z=14&output=embed';
            document.getElementById('myiframe').src = iframeSrc;
        }, function(error) {
            alert("Error: Unable to retrieve location.");
        });
    } else {
        alert("Geolocation is not supported by this browser.");
    }
</script>

</body>
</html>
