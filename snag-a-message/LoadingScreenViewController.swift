//
//  LoadingScreenViewController.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit
import Parse

class LoadingScreenViewController: UIViewController {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundBlurEffectView: UIVisualEffectView!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = PFUser.currentUser() {
            let service = UserService.sharedService
            service.currentUser = user
            
            var controller: UIViewController
            controller = (self.storyboard?.instantiateViewControllerWithIdentifier(snagAMessageScreenStoryboardId))! 
            self.presentViewController(controller, animated: true, completion: nil)
        }else{
            var controller: LoginViewController
            controller = self.storyboard?.instantiateViewControllerWithIdentifier(loginScreenStoryboardId) as! LoginViewController
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let login = segue.destinationViewController
//    }


}
