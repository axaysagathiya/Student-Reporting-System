package com.github.studentsReportingSystem.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.studentsReportingSystem.repository.StudentRepository;
import com.github.studentsReportingSystem.entities.Result;
import com.github.studentsReportingSystem.entities.Student;

@Component
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public boolean addStudent(Student student) {
        Student st = studentRepository.save(student);
        if(st == null) {
            return false;
        }
        return true;
    }

    public Student getStudent(int id) {
        return studentRepository.findById(id);
    }

    public boolean addMarks(int studentId, int sem, String subject, double marks) {

        Student student = getStudent(studentId);

        Result result = new Result();
        if(sem == 1) {
            result = student.getSem1Result() == null ? new Result() : student.getSem1Result();
        } else if(sem == 2) {
            result = student.getSem2Result() == null ? new Result() : student.getSem2Result();
        }

        switch(subject) {
            case "english":
                result.setEnglishMarks(marks);
                break;
            case "maths":
                result.setMathsMarks(marks);
                break;
            case "science":
                result.setScienceMarks(marks);
                break;
        }

        if(sem == 1) {
            student.setSem1Result(result);
        } else if(sem == 2) {
            student.setSem2Result(result);
        }

        Student st = studentRepository.save(student);
        if(st == null) {
            return false;
        }
        return true;
    }

    public double avgPerInRecentSem(int sem) {
        List<Student> students = getAllStudents();
        double sumOfAllPercents = 0;
        int stdCount = 0;
        Result res = new Result();

        for (Student std : students) {

            if(sem == 1) {
                res = std.getSem1Result();
            } else if(sem == 2) {
                res = std.getSem2Result();
            }

            if(res == null) {
                continue;
            }
            
            stdCount++;
            double english = res.getEnglishMarks();
            double maths = res.getMathsMarks();
            double science = res.getScienceMarks();
            
            sumOfAllPercents += (english + maths + science) / 3;
        }
        return (sumOfAllPercents/stdCount);
    }

    // public ModelAndView getReports() {
        
    //     mv.addObject("avg_per_in_recent_sem",avgPerInRecentSem(1));
    //     return mv;
    // }

    public double findAvgMarksInSub(int studentId, String subject) {
        Student std = studentRepository.findById(studentId);
        double avgInSub = 0;
        switch(subject) {
            case "english":
                avgInSub = (std.getSem1Result().getEnglishMarks() + std.getSem2Result().getEnglishMarks())/2;
                break;
            case "maths":
                avgInSub = (std.getSem1Result().getMathsMarks() + std.getSem2Result().getMathsMarks())/2;
                break;
            case "science":
                avgInSub = (std.getSem1Result().getScienceMarks() + std.getSem2Result().getScienceMarks())/2;
                break;
        }
        return avgInSub;
    }

    public List<String> findTop2Student() {
        List<Student> allStudent = getAllStudents();
        double avg=0, sem1Avg=0, sem2Avg=0, maxAvg1=0, maxAvg2=0;
        Student  maxAvg1Std=new Student(),  maxAvg2Std=new Student();
        for(Student std : allStudent) {
            sem1Avg = (std.getSem1Result().getEnglishMarks()+std.getSem1Result().getMathsMarks()+std.getSem1Result().getScienceMarks())/3;
            sem2Avg = (std.getSem2Result().getEnglishMarks()+std.getSem2Result().getMathsMarks()+std.getSem2Result().getScienceMarks())/3;

            avg = (sem1Avg+sem2Avg)/2;
            if(avg > maxAvg1 && avg > maxAvg2) {
                maxAvg2 = maxAvg1; maxAvg2Std = maxAvg1Std;
                maxAvg1 = avg; maxAvg1Std = std;
            } else if(avg < maxAvg1 && avg > maxAvg2) {
                maxAvg2 = avg; maxAvg2Std = std;
            }
        }

        List<String> topStudents = new ArrayList<String>();
        topStudents.add(maxAvg1Std.getName());
        topStudents.add(maxAvg2Std.getName());

        return topStudents;
    }
}
