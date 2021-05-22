//
//  UserRegistrationOneViewController.swift
//  luze-app
//
//  Created by Bryan Guntoro on 6/5/21.
//

import UIKit

class UserRegistrationOneViewController: UIViewController {

    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var hiSubtitleLabel: UILabel!
    
    override func viewDidLoad() {
        setHiLabel()
        super.viewDidLoad()


    

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setHiLabel() {
        let hiString = "Hey!"
        let hiAttributedString:NSMutableAttributedString = NSMutableAttributedString(string: hiString)
        hiAttributedString.setColorForText(textForAttribute: "H", withColor: UIColor.palettePink)
        hiAttributedString.setColorForText(textForAttribute: "e", withColor: UIColor.paletteYellow)
        hiAttributedString.setColorForText(textForAttribute: "y", withColor: UIColor.paletteBlue)
        hiAttributedString.setColorForText(textForAttribute: "!", withColor: UIColor.paletteGreen)
        hiLabel.attributedText = hiAttributedString
    }
}
