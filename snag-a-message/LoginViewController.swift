//
//  LoginViewController.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginAction(sender: UIButton) {
        
        if let username = usernameTextField.text{
            if let password = passwordTextField.text  {
                PFUser.logInWithUsernameInBackground(username, password: password, block: {
                (user, error) -> Void in
                    if error == nil {
                        let service = UserService.sharedService
                        service.currentUser = user
                        service.loadCurrentSnagUser()
                        self.performSegueWithIdentifier(snagAMessageScreenStoryboardId, sender: nil)
                    }else{
                        print("Error occurred while attempting to login. \n\(error)")
                        self.messageLabel.text = "Error occurred while attempting to login. \n\(error)"
                    }
                })
            }else{
                self.messageLabel.text = "Invalid password."
            }
        }else{
            self.messageLabel.text = "Invalid username."
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
