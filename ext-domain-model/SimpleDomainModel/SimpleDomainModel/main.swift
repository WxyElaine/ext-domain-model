//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//
//  Name: Xinyi Wang
//  Class: INFO 449
//  Homework: ext-domain-model

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

// Protocols
protocol CustomStringConvertible {
    var description: String { get }
}

protocol Mathematics {
    func add(_ : Money) -> Money
    func subtract(_ : Money) -> Money
}

// Extension
extension Double {
    var USD: Money {
        return Money(amount: Int(self), currency: "USD")
    }
    
    var GBP: Money {
        return Money(amount: Int(self), currency: "GBP")
    }
    
    var EUR: Money {
        return Money(amount: Int(self), currency: "EUR")
    }
    
    var YEN: Money {
        return Money(amount: Int(self), currency: "YEN")
    }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String
    
    public init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    var description: String {
        get { return "\(currency) \(amount)" }
    }
    
    public func convert(_ to: String) -> Money {
        if self.currency == "USD" {
            return Money(amount: exchangeFromUSD(to, self.amount), currency: to)
        } else if to == "USD" {
            return Money(amount: exchangeToUSD(self.currency, self.amount), currency: to)
        } else {
            return Money(amount: 0, currency: to)
        }
    }
    
    public func add(_ to: Money) -> Money {
        var newAmount = to.amount
        if self.currency == to.currency {
            newAmount += self.amount
        } else {
            newAmount = exchangeToUSD(to.currency, to.amount)
            newAmount += exchangeToUSD(self.currency, self.amount)
            let result = newAmount
            newAmount = exchangeFromUSD(to.currency, result)
        }
        return Money(amount: newAmount, currency: to.currency)
    }
    
    public func subtract(_ from: Money) -> Money {
        var newAmount = from.amount
        if self.currency == from.currency {
            newAmount -= self.amount
        } else {
            newAmount = exchangeToUSD(from.currency, from.amount)
            newAmount -= exchangeToUSD(self.currency, self.amount)
            newAmount = exchangeFromUSD(from.currency, newAmount)
        }
        return Money(amount: newAmount, currency: from.currency)
    }
    
    private func exchangeFromUSD(_ to: String, _ originAmount: Int) -> Int {
        switch to {
        case "GBP":
            return Int(Double(originAmount) * 0.50)
        case "EUR":
            return Int(Double(originAmount) * 1.50)
        case "CAN":
            return Int(Double(originAmount) * 1.25)
        case "USD":
            return originAmount
        default:
            return 0
        }
    }
    
    private func exchangeToUSD(_ from: String, _ originAmount: Int) -> Int {
        switch from {
        case "GBP":
            return Int(Double(originAmount) / 0.50)
        case "EUR":
            return Int(Double(originAmount) / 1.50)
        case "CAN":
            return Int(Double(originAmount) / 1.25)
        case "USD":
            return originAmount
        default:
            return 0
        }
    }
}

////////////////////////////////////
// Job
//
open class Job: CustomStringConvertible {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    var description: String {
        get {
            switch type {
            case .Hourly(let amount):
                return "Job: \(title), $\(amount)/hour"
            case .Salary(let amount):
                return "Job: \(title), $\(amount)/year"
            }
        }
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Salary(let amount):
            return amount
        case .Hourly(let amount):
            return Int(Double(hours) * amount)
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let amount):
            self.type = Job.JobType.Hourly(amount + amt)
        case .Salary(let amount):
            self.type = Job.JobType.Salary(amount + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person: CustomStringConvertible {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if self.age >= 16 {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if self.age >= 18 {
                _spouse = value
            }
        }
    }
    
    var description: String {
        return toString()
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        var jobOpt = "nil"
        if self.age >= 16 && job != nil {
            jobOpt = job!.title
        }
        var spouseOpt = "nil"
        if self.age >= 18 && spouse != nil {
            spouseOpt = "\(spouse!.firstName) \(spouse!.lastName)"
        }
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(jobOpt) spouse:\(spouseOpt)]"
    }
}

////////////////////////////////////
// Family
//
open class Family: CustomStringConvertible {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil && spouse1.age >= 18 && spouse2.age >= 18 {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
    
    var description: String {
        get {
            var familyDescription = "{Family Members: \n"
            for element in members {
                familyDescription += "\(element.description)\n"
            }
            return "\(familyDescription)\nHousehold Income: \(householdIncome())}"
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        if members.index(where: { $0.age > 21 }) != nil {
            members.append(child)
            return true
        } else {
            return false
        }
    }
    
    open func householdIncome() -> Int {
        var sum = 0
        for element in members {
            if element.age >= 16 && element.job != nil {
                sum += element.job!.calculateIncome(2000)
            }
        }
        return sum
    }
}
