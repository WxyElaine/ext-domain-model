//
//  PersonTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//
//  Name: Xinyi Wang
//  Class: INFO 449
//  Homework: ext-domain-model

import XCTest

class PersonTests: XCTestCase {
    
    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)

        XCTAssert(ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
  
    func testAgeRestrictions() {
        let matt = Person(firstName: "Matthew", lastName: "Neward", age: 15)
    
        matt.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(matt.job == nil)

        matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(matt.spouse == nil)
    }
  
    func testAdultAgeRestrictions() {
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)
    
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        XCTAssert(mike.job != nil)
    
        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        XCTAssert(mike.spouse != nil)
    }
    
    // person description test
    func testPersonDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        
        let mike = Person(firstName: "Michael", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        mike.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
        
        XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
        XCTAssert(mike.description == "[Person: firstName:Michael lastName:Neward age:22 job:Burger-Flipper spouse:Bambi Jones]")
    }
  
}

class FamilyTests : XCTestCase {
    
    func testFamily() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)

        let family = Family(spouse1: ted, spouse2: charlotte)

        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 1000)
    }
  
    func testFamilyWithKids() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
    
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
    
        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
    
        let family = Family(spouse1: ted, spouse2: charlotte)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)
    
        let familyIncome = family.householdIncome()
        XCTAssert(familyIncome == 12000)
    }
    
    // family description test
    func testFamilyDescription() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        ted.job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        
        let charlotte = Person(firstName: "Charlotte", lastName: "Neward", age: 45)
        
        let mike = Person(firstName: "Mike", lastName: "Neward", age: 22)
        mike.job = Job(title: "Burger-Flipper", type: Job.JobType.Hourly(5.5))
        
        let matt = Person(firstName: "Matt", lastName: "Neward", age: 16)
        
        let family = Family(spouse1: ted, spouse2: charlotte)
        let _ = family.haveChild(mike)
        let _ = family.haveChild(matt)
        
        XCTAssert(family.description == "{Family Members: \n[Person: firstName:Ted lastName:Neward age:45 job:Guest Lecturer spouse:Charlotte Neward]\n[Person: firstName:Charlotte lastName:Neward age:45 job:nil spouse:Ted Neward]\n[Person: firstName:Mike lastName:Neward age:22 job:Burger-Flipper spouse:nil]\n[Person: firstName:Matt lastName:Neward age:16 job:nil spouse:nil]\n\nHousehold Income: 12000}")
    }
  
}
