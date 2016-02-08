//
//  SnagAMessageViewController.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import UIKit

class SnagAMessageViewController: UIViewController {

    var userService: UserService = UserService.sharedService
    var collectionViewDelegate: MessageCollectionDelegate!
    var collectionViewDataSource: MessageCollectionDataSource!
    
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    
    @IBOutlet weak var mainBlurEffectView: UIVisualEffectView!
    
    @IBOutlet weak var addPersonButton: PlusButton!
    
    @IBOutlet weak var personNameLabel: UILabel!
    
    @IBOutlet weak var messageInputTextField: UITextField!
    
    @IBOutlet weak var messageCollectionView: UICollectionView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewDelegate = MessageCollectionDelegate()
        self.collectionViewDataSource = MessageCollectionDataSource()
        self.messageCollectionView.delegate = self.collectionViewDelegate
        self.messageCollectionView.dataSource = self.collectionViewDataSource
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doEncrypt(sender: UIButton) {
      
//        let message = "This is a simple message to P.o.P"
//        let user = userService.currentSnagUser
//        let bytes: [UInt8] = userService.encryptMessage(user, message: message)
//        let encryptedMessage = String(bytes)
//        self.clearTextLabel.text = encryptedMessage
//        
//        let decrypted = userService.decryptMessage(user, encryptedBytes: bytes)
//        self.decryptedTextLabel.text = decrypted
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
