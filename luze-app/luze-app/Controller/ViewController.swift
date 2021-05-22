//
//  ViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 5/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {self.animate()})
    }
    
    private func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // This function animates the view and transition it to another view (derived from a storyboard)
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            self.imageView!.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    if ("user".isKeyPresentInUserDefaults){
                        // Show the MainViewController Screen
                        let welcomeViewControllerSB = UIStoryboard(name:"Main", bundle: nil)
                        let welcomeController = welcomeViewControllerSB.instantiateViewController(identifier: "welcomeView")
                        welcomeController.modalTransitionStyle = .crossDissolve
                        welcomeController.modalPresentationStyle = .fullScreen
                        self.present(welcomeController, animated: true)
                        
                        
                    } else {
                        // Show New UserRegistrationOneViewController Screen
                        let navigationControllerSB = UIStoryboard(name:"Main", bundle: nil)
                        let navigationController = navigationControllerSB.instantiateViewController(identifier: "navigationUserRegistration")
                        navigationController.modalTransitionStyle = .crossDissolve
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true)
                        
                    }

                })
            }
        })
    }
    

}

