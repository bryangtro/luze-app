//
//  UserRegistrationThreeViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 12/5/21.
//

import UIKit

class UserRegistrationThreeViewController: UIViewController {
    
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    var name: String = ""
    var dateOfBirthString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Prepare Segue and pass the data to the corresponding vairables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateOfBirthToDefaultTimeSegue" {
            let destVC = segue.destination as! UserRegistrationFourViewController
            dateOfBirthString = formatDate(dateOfBirth)
            destVC.name = name
            destVC.dateOfBirth = dateOfBirthString
        }
      

    }

    private func formatDate(_ date: UIDatePicker) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date.date)
        
    }
}
