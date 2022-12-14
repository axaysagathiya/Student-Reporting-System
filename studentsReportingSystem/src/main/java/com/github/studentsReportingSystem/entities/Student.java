package com.github.studentsReportingSystem.entities;

import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;


@Entity
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String name;

    @OneToOne(cascade = {CascadeType.ALL})
    private Result sem1Result;

    @OneToOne(cascade = {CascadeType.ALL})
    private Result sem2Result;
    
    public Student() {
    }
    public Student(String name) {
        super();
        this.name = name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public int getId() {
        return this.id;
    }

    public void setSem1Result(Result res) {
        this.sem1Result = res;
    }

    public Result getSem1Result() {
        return this.sem1Result;
    }

    public void setSem2Result(Result res) {
        this.sem2Result = res;
    }

    public Result getSem2Result() {
        return this.sem2Result;
    }

    @Override
    public String toString() {
        return String.format("Student[name = %s, sem1Result = %s, sem2Result = %s]", name, sem1Result,sem2Result);
    }
}

