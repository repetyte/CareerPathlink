<?php
include 'db.php';

$sql = "SELECT * FROM employed_lists";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>" . $row["emp_id"] . "</td>
                <td>" . $row["full_name"] . "</td>
                <td>" . $row["age"] . "</td>
                <td>" . $row["address"] . "</td>
                <td>" . $row["contact_no"] . "</td>
                <td>" . $row["course"] . "</td>
                <td>" . $row["date_grad"] . "</td>
                <td>" . $row["job_name"] . "</td>
                <td>" . $row["job_industry"] . "</td>
                <td>" . $row["salary"] . "</td>
                <td>" . $row["date_hired"] . "</td>
                <td>
                    <button onclick='editRecord(" . $row["emp_id"] . ")'>Update</button>
                    <button onclick='deleteRecord(" . $row["emp_id"] . ")'>Delete</button>
                </td>
            </tr>";
    }
} else {
    echo "<tr><td colspan='12'>No records found</td></tr>";
}

$conn->close();
?>
