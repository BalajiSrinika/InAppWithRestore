//
//  Extension.swift
//  InAppWithRestore
//
//  Created by Sabari on 04/04/20.
//  Copyright © 2020 Sabari. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {

    func inAppPurchaseActions()
    {
      let reachability = Reachability()
      if reachability.currentReachabilityStatus == .notReachable
      {
        let alertController = UIAlertController(title: "No Internet Connectivity", message: "Need Access to Internet to Purchase this app.", preferredStyle: UIAlertController.Style.alert)
        let oKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(oKAction)
        present(alertController, animated: true, completion: nil)
      }
      else
      {
        let getPrice = InAppPurchase.sharedInstance.displayPrice
        let alertMessage = InAppPurchase.sharedInstance.purchaseAlertHeading + getPrice

        let alertController = UIAlertController(title: alertMessage , message: "", preferredStyle: UIAlertController.Style.alert)

        let purchaseAction = UIAlertAction(title: "Purchase", style: UIAlertAction.Style.default) { (action) -> Void in
          InAppPurchase.sharedInstance.buyProduct()
        }
        let restoreAction = UIAlertAction(title: "Restore", style: UIAlertAction.Style.default) { (action) -> Void in
          InAppPurchase.sharedInstance.restoreTransactions()
        }
        let notNowAction = UIAlertAction(title: "Not Now", style: UIAlertAction.Style.default) { (action) -> Void in

        }
        alertController.addAction(purchaseAction)
        alertController.addAction(restoreAction)
        alertController.addAction(notNowAction)
        present(alertController, animated: true, completion: nil)
      }
    }

}
