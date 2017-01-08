//
//  Item.swift
//  Homepwner
//
//  Created by David on 12/29/16.
//  Copyright © 2016 DSmith. All rights reserved.
//
import Foundation

class Item : NSObject {
    private let name : String!
    private let valueInDollars : Float!
    private let serialNumber : String?
    private let dateCreated : NSDate!
    private let numberFormatter : NumberFormatter! = NumberFormatter()
    
    // Default Ctor
    init(name: String, valueInDollars: Float, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = NSLocale.current
        super.init()
    }
    
    // Convenience Ctor
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spoon", "Mac"]
            
            let randomAdjective = adjectives[Int(arc4random_uniform(UInt32(adjectives.count)))]
            let randomNoun = nouns[Int(arc4random_uniform(UInt32(nouns.count)))]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Float(arc4random_uniform(100))
            let randomSerial = NSUUID.init().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerial)
            
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
    
    // Getters
    open func getName() -> String {
        return name
    }
    
    open func getValue() -> String {
        return numberFormatter.string(from: valueInDollars as NSNumber)!
    }
    
    open func getSerialNumber() -> String? {
        return serialNumber
    }
    
    open func getDateCreated() -> NSDate {
        return dateCreated
    }
}
