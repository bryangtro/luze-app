//
//  UserRegistrationFourViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 12/5/21.
//

import UIKit

var wakeTimeSetting: Date?
var sleepTimeSetting: Date?

class UserRegistrationFourViewController: UIViewController {
    
    @IBOutlet weak var wakeUpTimeDatePicker: UIDatePicker!
    @IBOutlet weak var sleepTimeDatePicker: UIDatePicker!
    
    var dateOfBirth: String = ""
    var name: String = ""
    var wakeUpTime: String = ""
    var sleepTime: String = ""
    var user: User!
    
    var userArray = [User]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishRegistrationSegue" {
            
            // Create a user instance and set the userdefaulet key
            wakeUpTime = formatTime(wakeUpTimeDatePicker) 
            sleepTime = formatTime(sleepTimeDatePicker)
            user = User(name, dateOfBirth, sleepTime, wakeUpTime)
            
            // Append the user to userArray
            userArray.append(user)
            
            wakeTimeSetting = wakeUpTimeDatePicker.date
            sleepTimeSetting = sleepTimeDatePicker.date
                                
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userArray)
            
            // Set the user default and synchronize
            UserDefaults.standard.set(encodedData, forKey: "user")
            UserDefaults.standard.synchronize()
            

        }
    }
    
    private func formatTime(_ time: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: time.date)
    }
    
}
