//
//  FirstViewController.swift
//  ViewControllerChangerUITest
//
//  Created by 김광수 on 2020/12/11.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.accessibilityIdentifier = "Button"

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        secondViewController.view.accessibilityIdentifier = "SecondViewController"
        present(secondViewController, animated: true, completion: nil)
        
    }
    
}

