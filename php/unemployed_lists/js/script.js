// Get the modal
var createModal = document.getElementById("createModal");
var updateModal = document.getElementById("updateModal");

// Get the button that opens the modal
var createBtn = document.getElementById("createBtn");

// Get the <span> element that closes the modal
var spanCreate = createModal.getElementsByClassName("close")[0];
var spanUpdate = updateModal.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
createBtn.onclick = function() {
    createModal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
spanCreate.onclick = function() {
    createModal.style.display = "none";
}

spanUpdate.onclick = function() {
    updateModal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == createModal) {
        createModal.style.display = "none";
    }
    if (event.target == updateModal) {
        updateModal.style.display = "none";
    }
}

// Function to populate the table
function loadTable() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "fetch_unemployed.php", true);
    xhr.onload = function() {
        if (this.status == 200) {
            document.querySelector('#unemployedTable tbody').innerHTML = this.responseText;
        }
    };
    xhr.send();
}

// Function to create a record
function createRecord() {
    var formData = new FormData(document.getElementById("createForm"));
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "create_unemployed.php", true);
    xhr.onload = function() {
        if (this.status == 200) {
            createModal.style.display = "none";
            loadTable();
        }
    };
    xhr.send(formData);
}

// Function to populate update form and open modal
function editRecord(id) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "get_unemployed.php?id=" + id, true);
    xhr.onload = function() {
        if (this.status == 200) {
            var unemployed = JSON.parse(this.responseText);
            document.getElementById("update_id").value = unemployed.id;
            document.getElementById("update_previous_job").value = unemployed.previous_job;
            document.getElementById("update_full_name").value = unemployed.full_name;
            document.getElementById("update_age").value = unemployed.age;
            document.getElementById("update_address").value = unemployed.address;
            document.getElementById("update_course").value = unemployed.course;
            document.getElementById("update_date_grad").value = unemployed.date_grad;
            document.getElementById("update_reason_unemp").value = unemployed.reason_unemp;
            document.getElementById("update_next_target_job").value = unemployed.next_target_job;
            updateModal.style.display = "block";
        }
    };
    xhr.send();
}

// Function to update a record
function updateRecord() {
    var formData = new FormData(document.getElementById("updateForm"));
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "update_unemployed.php", true);
    xhr.onload = function() {
        if (this.status == 200) {
            updateModal.style.display = "none";
            loadTable();
        }
    };
    xhr.send(formData);
}

// Function to delete a record
function deleteRecord(id) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "delete_unemployed.php", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onload = function() {
        if (this.status == 200) {
            loadTable();
        }
    };
    xhr.send("id=" + id);
}

// Function to search the table
function searchTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("unemployedTable");
    tr = table.getElementsByTagName("tr");
    for (i = 1; i < tr.length; i++) {
        tr[i].style.display = "none";
        td = tr[i].getElementsByTagName("td");
        for (var j = 0; j < td.length; j++) {
            if (td[j]) {
                txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                    break;
                }
            }
        }
    }
}

// Load the table on page load
window.onload = loadTable;
