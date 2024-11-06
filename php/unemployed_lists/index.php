<!DOCTYPE html>
<html>
<head>
    <title>Unemployed Tracking System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<div class="container">
    <h2>Unemployed Tracking System</h2>
    <div class="buttons">
        <button id="createBtn">Create</button>
    </div>
    <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for names..">
    <table class="crud-table" id="unemployedTable">
        <thead>
            <tr>
                <th>Previous Job</th>
                <th>Full Name</th>
                <th>Age</th>
                <th>Address</th>
                <th>Course</th>
                <th>Date of Graduation</th>
                <th>Reason for Unemployment</th>
                <th>Next Target Job</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Dynamic Content Here -->
        </tbody>
    </table>
</div>

<!-- Create Modal -->
<div id="createModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Create Record</h2>
        <form id="createForm">
            <label for="previous_job">Previous Job:</label><br>
            <input type="text" id="previous_job" name="previous_job"><br>
            <label for="full_name">Full Name:</label><br>
            <input type="text" id="full_name" name="full_name"><br>
            <label for="age">Age:</label><br>
            <input type="text" id="age" name="age"><br>
            <label for="address">Address:</label><br>
            <input type="text" id="address" name="address"><br>
            <label for="course">Course:</label><br>
            <input type="text" id="course" name="course"><br>
            <label for="date_grad">Date of Graduation:</label><br>
            <input type="date" id="date_grad" name="date_grad"><br>
            <label for="reason_unemp">Reason for Unemployment:</label><br>
            <input type="text" id="reason_unemp" name="reason_unemp"><br>
            <label for="next_target_job">Next Target Job:</label><br>
            <input type="text" id="next_target_job" name="next_target_job"><br><br>
            <button type="button" onclick="createRecord()">Create</button>
        </form>
    </div>
</div>

<!-- Update Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Update Record</h2>
        <form id="updateForm">
            <input type="hidden" id="update_id" name="id">
            <label for="update_previous_job">Previous Job:</label><br>
            <input type="text" id="update_previous_job" name="previous_job"><br>
            <label for="update_full_name">Full Name:</label><br>
            <input type="text" id="update_full_name" name="full_name"><br>
            <label for="update_age">Age:</label><br>
            <input type="text" id="update_age" name="age"><br>
            <label for="update_address">Address:</label><br>
            <input type="text" id="update_address" name="address"><br>
            <label for="update_course">Course:</label><br>
            <input type="text" id="update_course" name="course"><br>
            <label for="update_date_grad">Date of Graduation:</label><br>
            <input type="date" id="update_date_grad" name="date_grad"><br>
            <label for="update_reason_unemp">Reason for Unemployment:</label><br>
            <input type="text" id="update_reason_unemp" name="reason_unemp"><br>
            <label for="update_next_target_job">Next Target Job:</label><br>
            <input type="text" id="update_next_target_job" name="next_target_job"><br><br>
            <button type="button" onclick="updateRecord()">Update</button>
        </form>
    </div>
</div>

<script src="js/script.js"></script>
</body>
</html>
