//
//  ViewController.swift
//  Project28SecretSwift
//
//  Created by Joshua on 8/13/19.
//  Copyright © 2019 JHC Dev. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var secret: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Nothing to see here"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    
    
    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authentificationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Authentification failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
                
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authemtification.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: enterByPassword))
            ac.addAction(UIAlertAction(title: "Give up", style: .cancel))
            self.present(ac, animated: true)
        }
    }
}


fileprivate let secreteMessageKey = "SecretMessage"
fileprivate let passwordKey = "NewPassword"

extension ViewController {
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        if let text = KeychainWrapper.standard.string(forKey: secreteMessageKey) { secret.text = text }
    }
    
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: secreteMessageKey)
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
    }
    
    
    func enterByPassword(_ alertAction: UIAlertAction) {
        if let password = KeychainWrapper.standard.string(forKey: passwordKey) {
            let ac = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [unowned ac, weak self] _ in
                if ac.textFields![0].text == password { self?.unlockSecretMessage() }
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            // no password is stored, yet
            let ac = UIAlertController(title: "Enter new password", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [unowned ac] _ in
                if let password = ac.textFields![0].text { KeychainWrapper.standard.set(password, forKey: passwordKey) }
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        
        if true { KeychainWrapper.standard.set("password", forKey: passwordKey) }
    }
    
}
