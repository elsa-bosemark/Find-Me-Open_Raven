//
//  AlertService.swift
//  Find Me
//
//  Created by Elsa B on 11/3/20.
//

import UIKit

class AlertService{
    func alert(title: String, body: String, buttonTitle: String)-> AlertViewController{
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier:"AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.alertButtonTitle = buttonTitle
        
        return alertVC
    }
}
