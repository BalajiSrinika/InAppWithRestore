//
//  ViewController.swift
//  InAppWithRestore
//
//  Created by Sabari on 04/04/20.
//  Copyright © 2020 Sabari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var notifLbl:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.InAppintiate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        
        print("appear")
    }
    
    @IBAction func inAppActn(_ sender : UIButton){
        self.inAppPurchaseActions()
    }
}

extension ViewController {
    
    func InAppintiate(){

      NotificationCenter.default.addObserver(self, selector: #selector(PurchasedNotification(notfication:)), name: NSNotification.Name(InAppPurchase.sharedInstance.kInAppProductPurchasedNotification), object: nil)
      //comment below line
     // UserDefaults.standard.set(true, forKey:inAppMode)
      UserDefaults.standard.synchronize()
      print(InAppStatus())

      if InAppStatus() == false {
        InAppPurchase.sharedInstance.buyUnlockInAppPurchase()
      }
    }
    
    @objc func PurchasedNotification(notfication: NSNotification) {
      UserDefaults.standard.setValue(true, forKey: inAppMode)
      UserDefaults.standard.synchronize()
      notifLbl.text = "Purschased succesfully"
        
    }
}
