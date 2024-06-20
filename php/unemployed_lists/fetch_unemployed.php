<?php
include 'db.php';

$sql = "SELECT * FROM unemployed_lists";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>" . $row["previous_job"] . "</td>
                <td>" . $row["full_name"] . "</td>
                <td>" . $row["age"] . "</td>
                <td>" . $row["address"] . "</td>
                <td>" . $row["course"] . "</td>
                <td>" . $row["date_grad"] . "</td>
                <td>" . $row["reason_unemp"] . "</td>
                <td>" . $row["next_target_job"] . "</td>
                <td>
                    <button onclick='editRecord(" . $row["previous_job"] . ")'>Update</button>
                    <button onclick='deleteRecord(" . $row["previous_job"] . ")'>Delete</button>
                </td>
            </tr>";
    }
} else {
    echo "<tr><td colspan='9'>No records found</td></tr>";
}

$conn->close();
?>
