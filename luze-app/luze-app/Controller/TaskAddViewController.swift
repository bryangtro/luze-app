import Foundation
import UIKit

var category: String?

class TaskAddViewController: UIViewController
{

    @IBOutlet weak var taskTitleField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var durationSlider: UISlider!
    
    @IBOutlet weak var durationTextField: UILabel!
    
    var taskDescription: String = ""
    var startTime: Date = Date()
    var duration: Int = 0
    var imgIcon: Int = 1
    var completed: Bool = false
    var newTask: Task!
    
    var taskArray = [Task]()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        datePicker.date = selectedDate
        //The SelectedData output in the console is different with the viewprint("SelectedData +\(selectedDate)"
        durationTextField.text = String(Int(durationSlider.value)) + " min"
        
        
    }
    
    
    @IBAction func updateDuration(_ sender: Any) {
        durationTextField.text = String(Int(durationSlider.value)) + " min"
    }
    func requiredName() {
        
        let alert = UIAlertController(title: "Task name required", message: "Please enter a task name", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction (title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addTask(_ sender: Any) {
        if (taskTitleField.text == "") {
            requiredName()
        }else {

        if !("taskList".isKeyPresentInUserDefaults) {
            if taskTitleField.text != ""
            {
                taskDescription = taskTitleField.text!
                startTime = datePicker.date
                duration = Int(durationSlider.value)
                completed = false
                newTask = Task(taskDescription,startTime,duration,imgIcon,completed)
                tasklist.append(newTask)
                let taskEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: tasklist)
                UserDefaults.standard.set(taskEncodedData, forKey: "taskList")
                UserDefaults.standard.synchronize()
            }

        } else {
            if taskTitleField.text != ""
            {
                taskDescription = taskTitleField.text!
                startTime = datePicker.date
                duration = Int(durationSlider.value)
                completed = false
                newTask = Task(taskDescription,startTime,duration,imgIcon,completed)
                tasklist.append(newTask)
                let taskEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: tasklist)
                UserDefaults.standard.set(taskEncodedData, forKey: "taskList")
                UserDefaults.standard.synchronize()

            }
        }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindAddViewController(segue: UIStoryboardSegue){} // Going Back to Home View Controller
}
