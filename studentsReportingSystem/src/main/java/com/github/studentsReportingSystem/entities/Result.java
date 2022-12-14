package com.github.studentsReportingSystem.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Result {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private double english;
    private double maths;
    private double science;

    public Result() {}

    public Result(double english, double maths, double science) {
        this.english = english;
        this.maths = maths;
        this.science = science;
    }

    public void setEnglishMarks(double english) {
        this.english = english;
    }
    public void setMathsMarks(double maths) {
        this.maths = maths;
    }
    public void setScienceMarks(double science) {
        this.science = science;
    }

    public double getEnglishMarks() {
        return this.english;
    }
    public double getMathsMarks() {
        return this.maths;
    }
    public double getScienceMarks() {
        return this.science;
    }

    @Override
    public String toString() {
        return String.format("Result[english = %s, maths = %s, science = %s]", english, maths, science);
    }
}
