//
//  User.swift
//  luze-app
//
//  Created by Bryan Guntoro on 5/5/21.
//


// This User Class is to be stored under UserDefaults
import Foundation


public class User: NSObject, NSCoding{
    private var _name: String?
    var name: String? {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    
    private var _dateOfBirth: String?
    var dateOfBirth: String? {
        get {
            return _dateOfBirth
        } set {
            _dateOfBirth = newValue
        }
    }
    
    private var _sleepTime: String?
    var sleepTime: String? {
        get {
            return _sleepTime
        } set {
            _sleepTime = newValue
        }
    }
    
    private var _wakeTime: String?
    var wakeTime: String? {
        get {
            return _wakeTime
        } set {
            _wakeTime = newValue
        }
    }
    
    
    init(_ name: String, _ dateOfBirth: String, _ sleepTime: String, _ wakeTime: String) {
        _name = name
        _dateOfBirth = dateOfBirth
        _sleepTime = sleepTime
        _wakeTime = wakeTime
    }
    
    public required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let dateOfBirth = aDecoder.decodeObject(forKey: "dateOfBirth") as! String
        let sleepTime = aDecoder.decodeObject(forKey: "sleepTime") as! String
        let wakeTime = aDecoder.decodeObject(forKey: "wakeTime") as! String
        self.init(name, dateOfBirth, sleepTime, wakeTime)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateOfBirth, forKey: "dateOfBirth")
        aCoder.encode(wakeTime, forKey: "wakeTime")
        aCoder.encode(sleepTime, forKey: "sleepTime")
    }
    
    
}
