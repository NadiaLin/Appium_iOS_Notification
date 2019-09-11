//
//  ViewController.swift
//  test2
//
//  Created by Nadia.Lin on 2019/8/13.
//  Copyright © 2019 Nadia.Lin. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBAction func Start(_ sender: UIButton) {
    }
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userAge: UITextField!
    
    
    @IBAction func clickStart(_ sender: Any) {
        let QG = QGSdk.getSharedInstance()

        QG.setName(userName.text!)
        print("Name = ", userName.text!)
        QG.setCustomKey("Age", withValue: userAge.text!)
        print("Age = ", userAge.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let localContent = UNMutableNotificationContent()
//        localContent.title = "This is Local Notification !"
//        localContent.body = "Enjoy ABC ~"
//        localContent.sound = UNNotificationSound.default
//        
//        let localTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        
//        let localRequest = UNNotificationRequest(identifier: "LocalNotification", content: localContent, trigger: localTrigger)
//        
//        UNUserNotificationCenter.current().add(localRequest, withCompletionHandler: nil)
        
        userInfoTextField()
    }
    
    private func userInfoTextField() {
        userName.delegate = self
        userAge.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userAge.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
