//
//  TaskEditViewController.swift
//  luze-app
//
//  Created by Jiwon You on 17/5/21.
//

import Foundation
import UIKit

class TaskEditViewController: UIViewController
{

    @IBOutlet weak var updatetitleTextField: UITextField!
    @IBOutlet weak var updatedTimePicker: UIDatePicker!

    @IBOutlet weak var updatedDurationTextField: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updatetitleTextField.placeholder =
            selectedTask.taskDescription
        updatedTimePicker.date = selectedTask.startTime!
        durationSlider.value = Float(selectedTask.duration!)
        updatedDurationTextField.text = String(selectedTask.duration!) + " min"

    }

    @IBAction func updateTask(_ sender: Any)
    {
        
        if let index = tasksForDate(date: selectedDate).firstIndex(of: selectedTask!) {
            if updatetitleTextField.text != "" {
                selectedTask.taskDescription = updatetitleTextField.text
            }
            
            //selectedTask.taskTitle = updatetitleTextField.text
            selectedTask.startTime = updatedTimePicker.date
            selectedTask.duration = Int(durationSlider.value)
            
            //tasklist[index] = selectedTask
            
            let taskEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: tasklist)
            UserDefaults.standard.set(taskEncodedData, forKey: "taskList")
            UserDefaults.standard.synchronize()
            
        }

    }
    
    @IBAction func dismissEditTask(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteTask(_ sender: Any)
    {
        
        if let index = tasklist.firstIndex(of: selectedTask!) {
            tasklist.remove(at: index)
        }
        
        
        let taskEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: tasklist)
        UserDefaults.standard.set(taskEncodedData, forKey: "taskList")
        UserDefaults.standard.synchronize()
        
        
    }
    
    
    @IBAction func updateDuration(_ sender: Any)
    {
        updatedDurationTextField.text = String(Int(durationSlider.value)) + " min"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            if let destVC = segue.destination as? HomeViewController
            {
                destVC.tableView.reloadData()
            }
    }

}
