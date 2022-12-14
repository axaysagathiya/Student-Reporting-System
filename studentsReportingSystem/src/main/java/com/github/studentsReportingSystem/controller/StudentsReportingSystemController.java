package com.github.studentsReportingSystem.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.studentsReportingSystem.entities.Student;
import com.github.studentsReportingSystem.service.StudentService;

@Controller
public class StudentsReportingSystemController {

    @Autowired
    private StudentService studentService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String greet() {
        return "home";
    }

    @RequestMapping(value = "/reports", method = RequestMethod.GET)
    public ModelAndView reports() {
        ModelAndView mv = new ModelAndView("/reports");
        mv.addObject("avg_per_in_recent_sem",studentService.avgPerInRecentSem(1));
        mv.addObject("topStudents", studentService.findTop2Student());
        
        return mv;
    }

    @RequestMapping(value = "/avgMarksInSub", method = RequestMethod.GET)
    @ResponseBody
    public double findAvgMarksInSub(int studentId, String subject) {
        return studentService.findAvgMarksInSub(studentId,subject);
    }

    @RequestMapping(value = "/students", method = RequestMethod.GET)
    @ResponseBody
    public List<Student> getAllStudents() {
        List<Student> allStudents = studentService.getAllStudents();
        return allStudents;
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.GET)
    public String addStudent() {
        return "addStudent";
    }

    @RequestMapping(value = "/addStudent", method = RequestMethod.POST)
    @ResponseBody
    public boolean adStudent(@RequestParam String name) {
        if (name.isEmpty()) {
            return false;
        }
        boolean ok = studentService.addStudent(new Student(name));
        return ok;
    }

    @RequestMapping(value = "/addMarks", method = RequestMethod.POST)
    @ResponseBody
    public boolean addMarks(@RequestParam int studentId, @RequestParam int sem, @RequestParam String subject,
            @RequestParam double marks) {
        return studentService.addMarks(studentId, sem, subject, marks);
    }

    @RequestMapping(value = "/avgPerOfClass", method = RequestMethod.GET)
    @ResponseBody
    public double avgPerInRecentSem() {
        int recentSem = 1;
        return studentService.avgPerInRecentSem(recentSem);
    }
}
