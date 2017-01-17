//
//  Item.swift
//  Homepwner
//
//  Created by David on 12/29/16.
//  Copyright © 2016 DSmith. All rights reserved.
//
import Foundation

class Item : NSObject, NSCoding {
    // MARK: Properties
    private var name: String!
    private var valueInDollars: Float!
    private var serialNumber: String?
    private let dateCreated: NSDate!
    private let itemKey: String!
    
    // MARK: Constants
    private let NAME_KEY: String! = "name"
    private let VALUE_KEY: String! = "valueInDollars"
    private let SERIAL_NUMBER_KEY: String! = "serialNumber"
    private let DATE_CREATED_KEY: String! = "dateCreated"
    private let ITEM_KEY_KEY: String! = "itemKey"
    
    // MARK: Formatters
    private let numberFormatter: NumberFormatter! = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private let dateFormatter: DateFormatter! = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: Ctors
    // Default Ctor
    init(name: String, valueInDollars: Float, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = UUID().uuidString
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
    
    // Required Ctor fior DeArchiving
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: NAME_KEY) as! String
        self.valueInDollars = aDecoder.decodeFloat(forKey: VALUE_KEY)
        self.dateCreated = aDecoder.decodeObject(forKey: DATE_CREATED_KEY) as! NSDate
        self.serialNumber = aDecoder.decodeObject(forKey: SERIAL_NUMBER_KEY) as? String
        self.itemKey = aDecoder.decodeObject(forKey: ITEM_KEY_KEY) as! String
        
        super.init()
    }
    
    // MARK: Getters
    open func getName() -> String! {
        return name
    }
    
    open func getValue() -> String! {
        return numberFormatter.string(from: valueInDollars as NSNumber)!
    }
    
    open func getSerialNumber() -> String? {
        return serialNumber
    }
    
    open func getDateCreated() -> String! {
        return dateFormatter.string(from: dateCreated as Date)
    }
    
    open func getItemKey() -> String! {
        return itemKey
    }
    
    // MARK: Setters
    open func setName(name: String?) -> Void {
        if name == nil {
            self.name = ""
        } else {
          self.name = name!
        }
    }
    
    open func setValue(value: String?) -> Void {
        if let valueText = numberFormatter.number(from: value!) {
            self.valueInDollars = valueText as Float
        } else {
            self.valueInDollars = 0
        }
    }
    
    open func setSerialNumber(serialNumber: String?) {
        if serialNumber == nil {
            self.serialNumber = ""
        } else {
            self.serialNumber = serialNumber
        }
    }
    
    // MARK: Archiving
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: NAME_KEY)
        aCoder.encode(valueInDollars, forKey: VALUE_KEY)
        aCoder.encode(serialNumber, forKey: SERIAL_NUMBER_KEY)
        aCoder.encode(dateCreated, forKey: DATE_CREATED_KEY)
        aCoder.encode(itemKey, forKey: ITEM_KEY_KEY)
    }
}
