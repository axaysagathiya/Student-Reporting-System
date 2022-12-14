<jsp:include page="navbar.jsp" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students</title>
</head>

<body class="">

    <br>
    <div id="msg" class="container"></div>
    <br>


    <!-- Code to add Student - start -->
    <div class="container border border-white rounded p-3 bg-secondary text-white">
        <form action="/addStudent" method="post" id="add_student_form">
            <fieldset>
                <legend>Add Student :</legend>

                <div class="input-group mb-3">
                    <input required name="name" type="text" class="form-control" placeholder="full name of student"
                        aria-label="full name of student" aria-describedby="basic-addon2" id="newStudent">
                    <div class="input-group-append">
                        <button class="btn btn-dark" type="button" id="submit_add_student"
                            onclick="addStudent()">Submit</button>
                    </div>
                </div>

            </fieldset>
        </form>
    </div>
    <!-- Code to add Student - finish -->

    <br>
    <hr>
    <br>

    <!-- Code to add Marks - start -->
    <div class="container border border-white rounded p-3 bg-secondary text-white">
        <form action="" id="add_marks_form">
            <fieldset>
                <legend>Add Marks</legend>

                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="student_list">Student : </label>
                    </div>
                    <select required name="student_list" id="student_list" class="custom-select">
                         <!-- options will load from database by Ajax  -->
                    </select>
                </div>


                <div class="row">
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="Semester">Semester</label>
                            </div>
                            <select required name="Semester" id="semester" class="custom-select">
                                <option value="" disabled selected>Select Semester</option>
                                <option value="1">Sem 1</option>
                                <option value="2">Sem 2</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="subject">subject</label>
                            </div>
                            <select required name="subject" id="subject" class="custom-select">
                                <option value="" disabled selected>Select subject</option>
                                <option value="english">English</option>
                                <option value="maths">Maths</option>
                                <option value="science">Science</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1">Marks</span>
                            </div>
                            <input required type="number" id='marks' class="form-control" placeholder="Marks" aria-label="Marks"
                                aria-describedby="basic-addon1">
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-dark float-right" onclick="addMarks()">Submit</button>
            </fieldset>
        </form>
    </div>
    <!-- Code to add Marks - start -->


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>


    <script>

    // code to load in student name drop down list in 'add marks' section - start
        $(document).ready(getAllStudents());
        function getAllStudents() {
            $.ajax({
                url: 'students',
                method: 'GET',
                async: false,
                dataType: 'JSON',
                complete: function (data) {
                    console.log(data.responseJSON);
                    student_options = document.getElementById('student_list').innerHTML;
                    student_options = '<option value="" disabled selected>Select Student</option>'
                    for (student of data.responseJSON) {
                        student_options += "<option value=" + student.id + ">" + student.name + "</option>"
                    }
                    document.getElementById('student_list').innerHTML = student_options;
                }
            });
        }
    // code to load in student name drop down list in 'add marks' section - end

        function addStudent() {

            // validation - name must be provided to add in a system
            if(name == '') {
                document.getElementById('msg').innerHTML =
                            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                            '<strong>Student name</strong> can not be empty.'
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                return;
            }

            name = document.getElementById('newStudent').value;
            $.ajax({
                url: 'addStudent',
                method: 'POST',
                async: false,
                dataType: 'JSON',
                data: { 'name': name },
                complete: function (data) {
                    console.log("data added ? => ", data.responseJSON)
                    let status
                    if (data.responseJSON == true) {

                        document.getElementById('msg').innerHTML =
                            '<div class="alert alert-success alert-dismissible fade show" role="alert"> <strong>' +
                            name + '</strong> added successfully to the system.' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                        getAllStudents();
                        document.getElementById("add_students_form").reset();

                    } else {
                        document.getElementById('msg').innerHTML =
                            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                            'Could not add <strong>' + name + '</strong> Please try again later.'
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                    }
                }
            });

        }

        function addMarks() {
            student_list = document.getElementById('student_list').value
            semester = document.getElementById('semester').value
            subject = document.getElementById('subject').value
            marks = document.getElementById('marks').value

            console.log('student_list : ' + student_list)
            console.log('semester : ' + semester)
            console.log('subject : ' + subject)
            console.log('marks : ' + marks)

                // validation - all field must be filled.
            if(student_list == ''
                || semester == ''
                || subject == ''
                || marks == ''
            ) {
                document.getElementById('msg').innerHTML =
                            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                           'All fields <strong>must be filled</strong> to insert marks of student.' +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                return;
            }

            // validation - marks must be between 0 to 100.
            MarksRegEx = new RegExp(/^\d{1,2}(?:\.\d{1,2})?$|^(100)$|^(100.0)$|^(100.00)$/);
            if(! MarksRegEx.test(marks.trim())) {
                document.getElementById('msg').innerHTML =
                            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                           '<strong>Invalid Marks.</strong>.' +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                return;
            }

            $.ajax({
                url: 'addMarks',
                method: 'POST',
                async: false,
                dataType: 'JSON',
                data: { 
                    'studentId': student_list,
                    'sem' : semester,
                    'subject' : subject,
                    'marks' : marks
                },
                complete: function (data) {
                    console.log("data added ? => ", data.responseJSON)
                    let status
                    if (data.responseJSON == true) {

                        document.getElementById('msg').innerHTML =
                            '<div class="alert alert-success alert-dismissible fade show" role="alert">' +
                            'Marks added successfully to the system.' +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                        getAllStudents();
                        document.getElementById("add_marks_form").reset();

                    } else {
                        document.getElementById('msg').innerHTML =
                            '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                            'Could not add marks Please try again later.'
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>';
                    }
                }
            });
        }
    </script>

</body>

</html>