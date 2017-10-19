//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//
//  Name: Xinyi Wang
//  Class: INFO 449
//  Homework: ext-domain-model

import XCTest

import SimpleDomainModel

class JobTests: XCTestCase {
  
    func testCreateSalaryJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
    }

    func testCreateHourlyJob() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
    }
  
    func testSalariedRaise() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.calculateIncome(50) == 1000)
    
        job.raise(1000)
        XCTAssert(job.calculateIncome(50) == 2000)
    }
  
    func testHourlyRaise() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.calculateIncome(10) == 150)
    
        job.raise(1.0)
        XCTAssert(job.calculateIncome(10) == 160)
    }
    
    // job description test
    func testSalaryJobDescription() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(job.description == "Job: Guest Lecturer, $1000/year")
    }
    
    func testHourlyJobDescription() {
        let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
        XCTAssert(job.description == "Job: Janitor, $15.0/hour")
    }
  
}
