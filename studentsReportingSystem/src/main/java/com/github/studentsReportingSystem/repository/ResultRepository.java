package com.github.studentsReportingSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.github.studentsReportingSystem.entities.Result;

public interface ResultRepository extends JpaRepository<Result, Integer> {
    
}
