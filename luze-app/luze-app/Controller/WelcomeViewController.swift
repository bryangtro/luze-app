//
//  WelcomeViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 12/5/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // Get the user object / instance
    var user: User!
    
    // Local Variables
    var name: String?
    var dateOfBirth: String?
    var wakeUpTime: String?
    var sleepTime: String?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // getUser() global method located in helper.swift used.
        user = getUser()
        
        nameLabel.text = user.name!
        nameLabel.textColor = UIColor.palettePink
        
//        print(user.name!)
//        print(user.dateOfBirth!)
//       print(user.wakeTime!)
//     print(user.sleepTime!)
    }
    
    /*func addWakeupTask() {

        let newTask = Task("Wake Up", wakeTimeSetting!, 1, 1, false)
        tasklist.append(newTask)
    }
    
    func addSleepTask() {
        let newTask = Task("Sleep", sleepTimeSetting!, 1, 1, false)
        tasklist.append(newTask)
    }*/
}
