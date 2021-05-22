//
//  Helper.swift - Global Method that can be used in all View Controllers
//  luze0app
//
//  Created by Bryan Guntoro on 28/4/21.
//

import Foundation
import SwiftUI

extension String {

    // Check if there is a key in UserDefault
    var isKeyPresentInUserDefaults: Bool {
        return UserDefaults.standard.object(forKey: self) != nil
    }
}

extension UIViewController{
    // This global method returns a user that has been decoded and can be used in all view controller
    func getUser() -> User {
        var userArr: [User]!
        let decodedUserArr = UserDefaults.standard.object(forKey: "user")
        userArr = NSKeyedUnarchiver.unarchiveObject(with: decodedUserArr as! Data) as! [User]
        return userArr[0]
    }
    
    func getTaskList() -> [Task] {
        var taskArr: [Task]!
        var emptyTask = [Task]()
        if "taskList".isKeyPresentInUserDefaults {
            let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
            taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
        } else {
            return emptyTask
        }
        
        return taskArr
    }
    
    func tasksForDate(date:Date)->[Task]
    {
        var daysTasks = [Task]()
        var taskArr: [Task]!
        if ("taskList".isKeyPresentInUserDefaults) {
            let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
            taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
            for task in tasklist
            {
                if(Calendar.current.isDate(task.startTime!, inSameDayAs:date))
                {
                    
                    daysTasks.append(task)
                }
            }
        }
        
        return daysTasks
    }
    
    func getProductivityList() -> [Double] {
        var taskArr: [Task]!
        var returnedArr : [Double] = [0,0,0,0,0]
        var emptyTask = [Double]()
        
        // Get current date
        var today = Date()
        var dateArray = [String]()
        for i in 1...5{
          let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: today)
          let date = DateFormatter()
          date.dateFormat = "dd-MM-yyyy"
          var stringDate : String = date.string(from: today)
          today = tomorrow!
          dateArray.append(stringDate)
        }
        
        
        let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
        taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
        
        if (taskArr.count == 0) {
            return emptyTask
        }
        
        for task in taskArr {
            let currDate = task.startTime!
            let date = DateFormatter()
            date.dateFormat = "dd-MM-yyyy"
            let currDateString : String = date.string(from: currDate)
            if dateArray.contains(currDateString) {
                if let i = dateArray.firstIndex(of: currDateString) {
                    returnedArr[i] += 1
                }
            }
            
        }
        
        return returnedArr
    }

}

extension ContentView {
    func getTaskList() -> [Task] {
        var taskArr: [Task]!
        var emptyTask = [Task]()
        let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
        taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
        if (taskArr.count == 0) {
            return emptyTask
        }
        return taskArr
    }
}

extension View {
    func getProductivityList() -> [Double] {
        var taskArr: [Task]!
        var returnedArr : [Double] = [0,0,0,0,0]
        var emptyTask = [Double]()
        
        // Get current date
        var today = Date()
        var dateArray = [String]()
        for i in 1...5{
          let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: today)
          let date = DateFormatter()
          date.dateFormat = "dd-MM-yyyy"
          var stringDate : String = date.string(from: today)
          today = tomorrow!
          dateArray.append(stringDate)
        }
        
        if ("taskList".isKeyPresentInUserDefaults) {
            let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
            taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
            
            if (taskArr.count == 0) {
                return emptyTask
            }
            
            for task in taskArr {
                let currDate = task.startTime!
                let date = DateFormatter()
                date.dateFormat = "dd-MM-yyyy"
                let currDateString : String = date.string(from: currDate)
                if dateArray.contains(currDateString) {
                    if let i = dateArray.firstIndex(of: currDateString) {
                        returnedArr[i] += 1
                    }
                }
                
            }
        }
       
        
        return returnedArr
    }
    
    func getCompletionList() -> [Double] {
        var taskArr: [Task]!
        var returnedArr : [Double] = [0,0,0,0,0]
        var emptyTask = [Double]()
        
        // Get current date
        var today = Date()
        var dateArray = [String]()
        for i in 1...5{
          let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: today)
          let date = DateFormatter()
          date.dateFormat = "dd-MM-yyyy"
          var stringDate : String = date.string(from: today)
          today = tomorrow!
          dateArray.append(stringDate)
        }
        print(dateArray)
        
        
        let decodedTaskArr = UserDefaults.standard.object(forKey: "taskList")
        taskArr = NSKeyedUnarchiver.unarchiveObject(with: decodedTaskArr as! Data) as! [Task]
        
        if (taskArr.count == 0) {
            return emptyTask
        }
        
        for task in taskArr {
            let currDate = task.startTime!
            let completed: Bool = task.completed!
            let date = DateFormatter()
            date.dateFormat = "dd-MM-yyyy"
            let currDateString : String = date.string(from: currDate)
            if (dateArray.contains(currDateString) && completed) {
                if let i = dateArray.firstIndex(of: currDateString) {
                    returnedArr[i] += 1
                }
            }
            
        }
        
        return returnedArr
    }

}


extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}


extension UIColor {
    static let paletteGreen: UIColor = UIColor(named: "palette-1")!
    static let paletteYellow: UIColor = UIColor(named: "palette-2")!
    static let paletteBlue: UIColor = UIColor(named: "palette-3")!
    static let palettePink: UIColor = UIColor(named: "palette-4")!
    
}

// This extension allows specific text to be highlighted in different colors
extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}


