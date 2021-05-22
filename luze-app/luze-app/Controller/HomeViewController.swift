//
//  HomeViewController.swift
//  luze-app
//
//  Created by Geraldo Gosal on 7/5/21.
//
//Gloabl Variable
var selectedDate = Date()
var selectedTask: Task!

import UIKit


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource{

 
    let transition = SlideInTransision()
    var topView: UIView?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var monthLabel: UIButton!
    
    let cellSpacingHeight: CGFloat = 40
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var totalSquares = [Date]()
    var datePickerDate = Date()
    var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    
    //Table Variables
    @IBOutlet weak var tableView: UITableView!
    let uncheckmark = UIImage(systemName: "square")
    let checkmark = UIImage(systemName: "checkmark.square.fill")
    var taskCategory: String?
   
    @IBOutlet var datePickerPopUp: UIView!
    var effect:UIVisualEffect!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tasklist = getTaskList()
//        effect = visualEffectView.effect
//        visualEffectView.effect = nil
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = CGFloat(screenWidth) / 31.25 / 6
        //layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
        
        print("\(layout.minimumInteritemSpacing)")
        
        datePickerPopUp.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20)!]
        datePickerPopUp.layer.shadowOffset = CGSize(width: 10,
                                          height: 10)
        datePickerPopUp.layer.shadowRadius = 5
        datePickerPopUp.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        datePickerPopUp.layer.shadowOffset = CGSize(width: 10,
                                                  height: 10)
                datePickerPopUp.layer.shadowRadius = 5
                datePickerPopUp.layer.shadowOpacity = 0.3
        
        setCellsView()
        setMonthView()
        
        // Create the Table with the Table View
        self.registerTableViewCells()
        tableView.reloadData() //update the Data
        
    }
    
    
    func animateIn() {
        self.view.addSubview(datePickerPopUp)
        datePickerPopUp.center = self.view.center
        
        datePickerPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        datePickerPopUp.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
//            self.visualEffectView.effect = self.effect
//            self.visualEffectView.alpha = 0.4
            self.datePickerPopUp.alpha = 1
            self.datePickerPopUp.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut () {
        UIView.animate(withDuration: 0.3, animations: {
            self.datePickerPopUp.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.datePickerPopUp.alpha = 0
//            self.visualEffectView.effect = nil
//            self.visualEffectView.alpha = 0.4
        }) { (success:Bool) in
            self.datePickerPopUp.removeFromSuperview()
        }
    }
    
    @IBAction func jumpToDate(_ sender: Any) {
        animateIn()
    }

    @IBAction func dismissDatePicker(_ sender: Any) {
        selectedDate = datePicker.date
        setMonthView()
        animateOut()
    }
    //    @IBAction func test(_ sender: Any) {
//        popUpView.isHidden = false
//        let overlay = UIVisualEffectView()
//        UIView.animate(withDuration: 0.5) {
//            overlay.effect = UIBlurEffect(style: .light)
//        }
//
//
//    }
    
//    @IBAction func setDate(_ sender: Any) {
//        selectedDate = datePicker.date
//        setMonthView()
//        popUpView.isHidden = true
//
//    }
    
    
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuSelection = { menuSelection in self.transitionToNew(menuSelection)}
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    func transitionToNew(_ menuSelection: MenuSelection) {
        
        topView?.removeFromSuperview()
        switch menuSelection {
        
        case .statistics:
            performSegue(withIdentifier: "statisticsSegue", sender: nil)
            
        default:
            break
        }
        
    }
}


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    
    //calendar
    
    func setMonthView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        monthLabel.setTitle(CalendarHelper().monthString(date: selectedDate)
                                + " " + CalendarHelper().yearString(date: selectedDate), for: .normal)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().daysOfMonth(date: date))
        
        if (date == selectedDate) {
            cell.backgroundColor = UIColor.palettePink
            monthLabel.setTitle(CalendarHelper().monthString(date: selectedDate)
                                    + " " + CalendarHelper().yearString(date: selectedDate), for: .normal)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8 //8 since 7 days in a week
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }


    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        print(datePickerDate)
        setMonthView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    //task table function

    
    private func registerTableViewCells()
    {
        let taskCell = UINib(nibName: "TaskTableViewCell",
                                  bundle: nil)
        self.tableView.register(taskCell,
                                forCellReuseIdentifier: "TaskTableViewCell")
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tasksForDate(date: selectedDate).count
    }
    
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return cellSpacingHeight
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if ("taskList".isKeyPresentInUserDefaults) {
            tasklist = getTaskList()
        }
        let sortedTasks =  tasksForDate(date: selectedDate).sorted(by: { $0.startTime! < $1.startTime! })

        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell
        {
            let task = sortedTasks[indexPath.row]
            cell.taskDescriptionLabel.text = task.taskDescription
            cell.timeLabel.text = "" + CalendarHelper().timeString(date: task.startTime!)
            cell.iconView.image = UIImage(named: String(task.imgIcon!))
            cell.completedBtn.tag = indexPath.row
            cell.completedBtn.addTarget(self, action: #selector(completeBtnTapped(sender:)), for: .touchUpInside)
            if (task.completed!) {
                cell.completedBtn.setImage(checkmark, for: .normal)
            } else {
                cell.completedBtn.setImage(uncheckmark, for: .normal)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
 
    
    @objc func completeBtnTapped(sender: UIButton)
    {
        let sortedTasks =  tasksForDate(date: selectedDate).sorted(by: { $0.startTime! < $1.startTime! })
        let rowIndex : Int = sender.tag
        selectedTask = sortedTasks[rowIndex]
        print("row index is :  \(rowIndex)")
        print(selectedTask.startTime!)
        print("\(rowIndex)")
        if selectedTask.completed == false
        {
            sender.setImage(checkmark, for: .normal)
            
            for task in tasklist {
                if task.startTime! == selectedTask.startTime! {
                    task.completed = true
                }
            }
//            selectedTask.completed = true
            print("\(selectedTask.completed!)")
        }
        else
        {
            for task in tasklist {
                if task.startTime! == selectedTask.startTime! {
                    task.completed = false
                }
            }
            sender.setImage(uncheckmark, for: .normal)
//            selectedTask.completed = false
            print("\(selectedTask.completed!)")
        }
        
        let taskEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: tasklist)
        UserDefaults.standard.set(taskEncodedData, forKey: "taskList")
        UserDefaults.standard.synchronize()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
        {
            let spacingValue: CGFloat = 12

            let maskLayer = CALayer()
            maskLayer.cornerRadius = 10
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: spacingValue/2)

            maskLayer.shadowOffset = CGSize(width: 5, height: 5)
            maskLayer.shadowColor = UIColor.black.cgColor
            maskLayer.shadowRadius = 20
            maskLayer.shadowOpacity = 1
            cell.layer.mask = maskLayer
        }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
        var sortedTasks =  tasksForDate(date: selectedDate).sorted(by: { $0.startTime! < $1.startTime! })
        selectedTask = sortedTasks[indexPath.row]
        let taskEditView = self.storyboard?.instantiateViewController(withIdentifier: "TaskEditViewController") as! TaskEditViewController
            present(taskEditView, animated: true, completion: nil)
        }
    
    @IBAction func unwindHomeViewController(segue: UIStoryboardSegue){} // Going Back to Home View Controller
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

}
