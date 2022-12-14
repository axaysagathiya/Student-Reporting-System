package com.github.studentsReportingSystem.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import com.github.studentsReportingSystem.entities.Student;

public interface StudentRepository extends JpaRepository<Student, Integer> {
    Student findById(int id);
}
