//
//  MenuViewController.swift
//  luze-app
//
//  Created by Geraldo Gosal on 8/5/21.
//

import UIKit

enum MenuSelection: Int {
    case home 
    case statistics
    case modifySchedule
    case donateUs
    case help
}

class MenuViewController: UITableViewController {
    var user: User!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    var didTapMenuSelection: ((MenuSelection) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = getUser()
        
        nameLabel.text = user.name!
        dateOfBirth.text = user.dateOfBirth!
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuSelection = MenuSelection(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuSelection)")
            self?.didTapMenuSelection?(menuSelection)
        }
    }
    
    @IBAction func exit () {
            dismiss(animated: true, completion: nil)
        }
}
