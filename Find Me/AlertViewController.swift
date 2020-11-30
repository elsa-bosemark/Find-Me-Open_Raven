//
//  AlertViewController.swift
//  Find Me
//
//  Created by Elsa B on 11/3/20.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    var alertTitle = String()
    var alertBody = String()
    var alertButtonTitle = String()
    
    
    func setupView(){
        titleLabel.text = alertTitle
        bodyLabel.text = alertBody
        actionButton.setTitle(alertButtonTitle, for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true
        
        popupView.layer.cornerRadius = 20
        popupView.layer.masksToBounds = true
        

        
    }
    
    @IBAction func didTapAction(_ sender: Any) {
      print("i was tapped")
        self.dismiss(animated: true, completion: nil)
     
    }
    
}
