//
//  UserRegistrationTwoViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 12/5/21.
//

import UIKit

class UserRegistrationTwoViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "nameToDateOfBirthSegue" {
            if checkTextField(nameTextField) {
                // Create Alert
                let alert = UIAlertController(title: "Oops!", message: "Name cannot be empty.", preferredStyle: UIAlertController.Style.alert)
                
                // Add Alert action
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                // Return false if text field empty
                return false
            }
            
        }
        
        // By default return true if name text field is not empty
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nameToDateOfBirthSegue" {
            let destVC = segue.destination as! UserRegistrationThreeViewController
            // No need to check if text field is null as it has been validated throught the performSegue
            destVC.name = nameTextField.text!
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func checkTextField(_ textField: UITextField) -> Bool {
        if (textField.text == "") {
            return true
        }
        
        return false
    }


}
