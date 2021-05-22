//
//  DateJumpViewController.swift
//  luze-app
//
//  Created by Geraldo Gosal on 16/5/21.
//

import UIKit

class DateJumpViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.layer.cornerRadius = 15;
        datePickerView.layer.masksToBounds = true;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func selectDate(_ sender: UIButton) {
        if let presenter = presentingViewController as? HomeViewController {
            presenter.datePickerDate = datePicker.date
        }
        
        print("Home date: \(HomeViewController().datePickerDate)")
        print("date picker: \(datePicker.date)")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
