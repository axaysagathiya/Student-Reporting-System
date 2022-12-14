<jsp:include page="navbar.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body >
    <div class="container">
    <br><strong>Average Percentage of whole class in recent semester: </strong> ${avg_per_in_recent_sem}
    <hr>
    <br><strong>Top 2 Consistent Students across all semesters :</strong>
    <br>1. ${topStudents[0]}
    <br>2. ${topStudents[1]}
    <br><br>

    <hr><br>
    <div>
        <div id="msg" class="container"></div>
        <h4>Select student and subject to find average marks of student in a subject.</h4> 
        <div class="row">
            <div class="col-4">
                <select required name="student_list" id="student_list" class="custom-select">
                    <!-- options will load from database by Ajax  -->
               </select>
            </div>
            <div class="col-4">
                <select required name="subject" id="subject" class="custom-select">
                    <option value="" disabled selected>Select subject</option>
                    <option value="english">English</option>
                    <option value="maths">Maths</option>
                    <option value="science">Science</option>
                </select>
            </div>
            <div class="col-1">
                <button class="btn btn-dark" onclick="find_avg_in_sub()">Calculate</button>
            </div>
        </div>

        <br>
        <p id="avg_in_sub"></p>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
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

    function find_avg_in_sub() {
        let student = document.getElementById('student_list').value;
        let subject = document.getElementById('subject').value;

        console.log('student : '+student);
        console.log('subject : '+subject);

        if(student == "" || subject == "") {
            document.getElementById('msg').innerHTML =
                    '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
                        'student name and subject <strong>must be selected</strong> to find average marks of student in a subject.' +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                        '</button>' +
                    '</div>';
                return;
        }

        $.ajax({
                url: 'avgMarksInSub',
                method: 'GET',
                async: false,
                dataType: 'JSON',
                data: {
                    "studentId" : student,
                    "subject" : subject
                },
                complete: function (data) {
                    console.log(data.responseJSON);
                    document.getElementById('avg_in_sub').innerHTML = "<strong>Average marks : </strong>" + data.responseJSON;
                }
            });
    }
    </script>

</body>
</html>