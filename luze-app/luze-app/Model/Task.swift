//
//  Task.swift
//  luze-app
//
//  Created by Bryan Guntoro on 18/5/21.
//

// This User Class is to be stored under UserDefaults
import Foundation

var tasklist = [Task]()

public class Task: NSObject, NSCoding{
    
    private var _taskDescription: String?
    var taskDescription: String? {
        get {
            return _taskDescription
        }
        set {
            _taskDescription = newValue
        }
    }
    
    private var _startTime: Date?
    var startTime: Date? {
        get {
            return _startTime
        } set {
            _startTime = newValue
        }
    }
    
    private var _duration: Int?
    var duration: Int? {
        get {
            return _duration
        } set {
            _duration = newValue
        }
    }
    
    private var _imgIcon: Int?
    var imgIcon: Int? {
        get {
            return _imgIcon
        } set {
            _imgIcon = newValue
        }
    }
    
    private var _completed: Bool?
    var completed: Bool?
    {
        get{
           return _completed
        }
        set{
            _completed = newValue
        }
    }
    
   
    
    init(_ taskDescription: String, _ startTime: Date, _ duration: Int, _ imgIcon: Int, _ completed : Bool) {
        _taskDescription = taskDescription
        _startTime = startTime
        _duration = duration
        _imgIcon = imgIcon
        _completed = completed
    }
    
    public required convenience init(coder aDecoder: NSCoder) {
        let taskDescription = aDecoder.decodeObject(forKey: "taskDescription") as! String
        let startTime = aDecoder.decodeObject(forKey: "startTime") as! Date
        let duration = aDecoder.decodeObject(forKey: "duration") as! Int
        let imgIcon = aDecoder.decodeObject(forKey: "imgIcon") as! Int
        let completed = aDecoder.decodeObject(forKey: "completed") as! Bool
        self.init(taskDescription, startTime,duration, imgIcon, completed)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(taskDescription, forKey: "taskDescription")
        aCoder.encode(startTime, forKey: "startTime")
        aCoder.encode(duration, forKey: "duration")
        aCoder.encode(imgIcon, forKey: "imgIcon")
        aCoder.encode(completed, forKey: "completed")
    }
    
    /*func tasksForDate(date:Date)->[Task]
    {
        var daysTasks = [Task]()
        for task in tasklist
        {
            if(Calendar.current.isDate(task.startTime!, inSameDayAs:date))
            {
                daysTasks.append(task)
            }
        }
        return daysTasks 
    }*/
}

