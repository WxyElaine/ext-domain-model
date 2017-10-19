//
//  MoneyTests.swift
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

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
    let tenUSD = Money(amount: 10, currency: "USD")
    let twelveUSD = Money(amount: 12, currency: "USD")
    let fiveGBP = Money(amount: 5, currency: "GBP")
    let fifteenEUR = Money(amount: 15, currency: "EUR")
    let fifteenCAN = Money(amount: 15, currency: "CAN")
  
    func testCanICreateMoney() {
        let oneUSD = Money(amount: 1, currency: "USD")
        XCTAssert(oneUSD.amount == 1)
        XCTAssert(oneUSD.currency == "USD")
    
        let tenGBP = Money(amount: 10, currency: "GBP")
        XCTAssert(tenGBP.amount == 10)
        XCTAssert(tenGBP.currency == "GBP")
    }
  
    func testUSDtoGBP() {
        let gbp = tenUSD.convert("GBP")
        XCTAssert(gbp.currency == "GBP")
        XCTAssert(gbp.amount == 5)
    }
    func testUSDtoEUR() {
        let eur = tenUSD.convert("EUR")
        XCTAssert(eur.currency == "EUR")
        XCTAssert(eur.amount == 15)
    }
    func testUSDtoCAN() {
        let can = twelveUSD.convert("CAN")
        XCTAssert(can.currency == "CAN")
        XCTAssert(can.amount == 15)
    }
    func testGBPtoUSD() {
        let usd = fiveGBP.convert("USD")
        XCTAssert(usd.currency == "USD")
        XCTAssert(usd.amount == 10)
    }
    func testEURtoUSD() {
        let usd = fifteenEUR.convert("USD")
        XCTAssert(usd.currency == "USD")
        XCTAssert(usd.amount == 10)
    }
    func testCANtoUSD() {
        let usd = fifteenCAN.convert("USD")
        XCTAssert(usd.currency == "USD")
        XCTAssert(usd.amount == 12)
    }
  
    func testUSDtoEURtoUSD() {
        let eur = tenUSD.convert("EUR")
        let usd = eur.convert("USD")
        XCTAssert(tenUSD.amount == usd.amount)
        XCTAssert(tenUSD.currency == usd.currency)
    }
    func testUSDtoGBPtoUSD() {
        let gbp = tenUSD.convert("GBP")
        let usd = gbp.convert("USD")
        XCTAssert(tenUSD.amount == usd.amount)
        XCTAssert(tenUSD.currency == usd.currency)
    }
    func testUSDtoCANtoUSD() {
        let can = twelveUSD.convert("CAN")
        let usd = can.convert("USD")
        XCTAssert(twelveUSD.amount == usd.amount)
        XCTAssert(twelveUSD.currency == usd.currency)
    }
    
    // money description test
    func testMoneyDesciption() {
        XCTAssert(tenUSD.description == "USD 10")
        XCTAssert(twelveUSD.description == "USD 12")
        XCTAssert(fiveGBP.description == "GBP 5")
        XCTAssert(fifteenEUR.description == "EUR 15")
        XCTAssert(fifteenCAN.description == "CAN 15")
    }
    
    // add function test
    func testAddUSDtoUSD() {
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    func testAddGBPtoGBP() {
        let total = fiveGBP.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    func testAddEURtoEUR() {
        let total = fifteenEUR.add(fifteenEUR)
        XCTAssert(total.amount == 30)
        XCTAssert(total.currency == "EUR")
    }
    func testAddCANtoCAN() {
        let total = fifteenCAN.add(fifteenCAN)
        XCTAssert(total.amount == 30)
        XCTAssert(total.currency == "CAN")
    }
    
    func testAddUSDtoGBP() {
        let total = tenUSD.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    func testAddUSDtoEUR() {
        let total = tenUSD.add(fifteenEUR)
        XCTAssert(total.amount == 30)
        XCTAssert(total.currency == "EUR")
    }
    func testAddUSDtoCAN() {
        let total = tenUSD.add(fifteenCAN)
        XCTAssert(total.amount == 27)
        XCTAssert(total.currency == "CAN")
    }
    
    func testAddGBPtoUSD() {
        let total = fiveGBP.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    func testAddGBPtoEUR() {
        let total = fiveGBP.add(fifteenEUR)
        XCTAssert(total.amount == 30)
        XCTAssert(total.currency == "EUR")
    }
    func testAddGBPtoCAN() {
        let total = fiveGBP.add(fifteenCAN)
        XCTAssert(total.amount == 27)
        XCTAssert(total.currency == "CAN")
    }
    
    func testAddEURtoUSD() {
        let total = fifteenEUR.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == "USD")
    }
    func testAddEURtoGBP() {
        let total = fifteenEUR.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
    }
    func testAddEURtoCAN() {
        let total = fifteenEUR.add(fifteenCAN)
        XCTAssert(total.amount == 27)
        XCTAssert(total.currency == "CAN")
    }
    
    func testAddCANtoUSD() {
        let total = fifteenCAN.add(tenUSD)
        XCTAssert(total.amount == 22)
        XCTAssert(total.currency == "USD")
    }
    func testAddCANtoGBP() {
        let total = fifteenCAN.add(fiveGBP)
        XCTAssert(total.amount == 11)
        XCTAssert(total.currency == "GBP")
    }
    func testAddCANtoEUR() {
        let total = fifteenCAN.add(fifteenEUR)
        XCTAssert(total.amount == 33)
        XCTAssert(total.currency == "EUR")
    }
    
    // subtract function test
    func testSubtractUSDfromUSD() {
        let total = tenUSD.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    func testSubtractGBPfromGBP() {
        let total = fiveGBP.subtract(fiveGBP)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "GBP")
    }
    func testSubtractEURfromEUR() {
        let total = fifteenEUR.subtract(fifteenEUR)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "EUR")
    }
    func testSubtractCANfromCAN() {
        let total = fifteenCAN.subtract(fifteenCAN)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "CAN")
    }
    
    func testSubtractUSDfromGBP() {
        let total = tenUSD.subtract(fiveGBP)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "GBP")
    }
    func testSubtractUSDfromEUR() {
        let total = tenUSD.subtract(fifteenEUR)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "EUR")
    }
    func testSubtractUSDfromCAN() {
        let total = tenUSD.subtract(fifteenCAN)
        XCTAssert(total.amount == 2)
        XCTAssert(total.currency == "CAN")
    }
    
    func testSubtractGBPfromUSD() {
        let total = fiveGBP.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    func testSubtractGBPfromEUR() {
        let total = fiveGBP.subtract(fifteenEUR)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "EUR")
    }
    func testSubtractGBPfromCAN() {
        let total = fiveGBP.subtract(fifteenCAN)
        XCTAssert(total.amount == 2)
        XCTAssert(total.currency == "CAN")
    }
    
    func testSubtractEURfromUSD() {
        let total = fifteenEUR.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    func testSubtractEURfromGBP() {
        let total = fifteenEUR.subtract(fiveGBP)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "GBP")
    }
    func testSubtractEURfromCAN() {
        let total = fifteenEUR.subtract(fifteenCAN)
        XCTAssert(total.amount == 2)
        XCTAssert(total.currency == "CAN")
    }
    
    func testSubtractCANfromUSD() {
        let total = fifteenCAN.subtract(tenUSD)
        XCTAssert(total.amount == -2)
        XCTAssert(total.currency == "USD")
    }
    func testSubtractCANfromGBP() {
        let total = fifteenCAN.subtract(fiveGBP)
        XCTAssert(total.amount == -1)
        XCTAssert(total.currency == "GBP")
    }
    func testSubtractCANfromEUR() {
        let total = fifteenCAN.subtract(fifteenEUR)
        XCTAssert(total.amount == -3)
        XCTAssert(total.currency == "EUR")
    }
    
    // extension test
    func testDoubleExtension() {
        XCTAssert(2.0.USD.description == "USD 2")
        XCTAssert(3.0.GBP.description == "GBP 3")
        XCTAssert(4.4.EUR.description == "EUR 4")
        XCTAssert(10.9.YEN.description == "YEN 10")
    }
}

