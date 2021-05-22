//
//  TaskCategoryViewController.swift
//  luze-app
//
//  Created by Hazel Kim on 19/5/21.
//

import UIKit


class TaskCategoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    enum Category: Int {
            case wakeup = 1, sleep, study
            
            static var count: Int { return Category.study.rawValue}
            
            var toString: String{
                switch self {
                case .wakeup: return "wakeup"
                case .sleep: return "sleep"
                case .study: return "study"
                default: return ""
                }
            }
                
        /*func categoryIconImage () -> UIImage
            {
                switch self{
                case .wakeup:
                    return UIImage(named:"Alarm")!
                case .sleep:
                    return UIImage(named:"Sleep")!
                case .study:
                    return UIImage(named:"Study")!
                }
            }*/
    }
        
    var selectedValue: Int!
    var categories: [Category] = [Category]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        
        categories = [Category.wakeup, Category.sleep, Category.study]
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Category {
           return categories[row]
       }
    
    
    private func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           // This method is triggered whenever the user makes a change to the picker selection.
           // The parameter named row and component represents what was selected.
       }
    

    @IBAction func setCategory(_ sender: Any) {
        
        let selectedValue = categories[categoryPickerView.selectedRow(inComponent: 0)]
        
        /*if let presenter = presentingViewController as? TaskAddViewController {
            presenter.taskCategory = selectedValue
        }*/

        print(selectedValue)
        
        self.dismiss(animated: true, completion: nil)
        

    }

}



