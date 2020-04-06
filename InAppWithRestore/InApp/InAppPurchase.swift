//
//  InAppPurchase.swift
//  InAppWithRestore
//
//  Created by Sabari on 04/04/20.
//  Copyright © 2020 Sabari. All rights reserved.
//

import Foundation
import StoreKit

class InAppPurchase : NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {

  static let sharedInstance = InAppPurchase()

  /* Product identifier */
  let ProductIdentifier = appProductIdentifier
    
  let kInAppProductPurchasedNotification = "InAppProductPurchasedNotification"

  var displayPrice = String()
  var validProduct = SKProduct()

  var purchaseAlertHeading = "To Use the Full Version of ''\(appName)'', Buy Now for  "

  override init() {
    super.init()
  }

  deinit {
    SKPaymentQueue.default().remove(self)
  }

  func buyProduct() {
    print("Sending the Payment Request to Apple")
    SKPaymentQueue.default().add(self)
    let payment = SKPayment(product: validProduct)
    SKPaymentQueue.default().add(payment)
  }

  func restoreTransactions() {
    SKPaymentQueue.default().add(self)
    SKPaymentQueue.default().restoreCompletedTransactions()
  }

  func unlockProduct(_ productIdentifier: String!) {
    if SKPaymentQueue.canMakePayments() {
      let productID: NSSet = NSSet(object: productIdentifier!)
      let productsRequest: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
      productsRequest.delegate = self
      productsRequest.start()
    } else {
      self.showAlert(message: "Can't make purchases")
    }
  }

  func request(_ request: SKRequest, didFailWithError error: Error) {
    print("Error %@ \(error)")
    self.showAlert(message: error.localizedDescription)
  }

  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let count: Int = response.products.count
    if count > 0 {
      validProduct = response.products[0]

      // my code
      let formatter = NumberFormatter()
      formatter.formatterBehavior = .behavior10_4
      formatter.numberStyle = .currency
      formatter.locale = validProduct.priceLocale
      displayPrice = "\(formatter.string(from: validProduct.price) ?? "")"
      print("displayPrice => \(displayPrice)")
    } else {
      self.showAlert(message: "There are no products.")
    }
  }

  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
      case SKPaymentTransactionState.purchased:
        print("Transaction completed successfully.")
        SKPaymentQueue.default().finishTransaction(transaction)

        self.showAlert(message: "Purchase is completed succesfully")

        NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppProductPurchasedNotification), object: nil)

      case SKPaymentTransactionState.failed:
        print("Transaction Failed")
        SKPaymentQueue.default().finishTransaction(transaction)
      case SKPaymentTransactionState.restored:
        print("Restored completed successfully.")
        SKPaymentQueue.default().finishTransaction(transaction)

        self.showAlert(message: "Restore Completed SuccessFully")

        NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppProductPurchasedNotification), object: nil)

      default:
        print(transaction.transactionState.rawValue)
      }
    }
  }

  func showAlert(message: String) {
    let alertController = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertController.Style.alert)
    let oKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
    }
    alertController.addAction(oKAction)
    DispatchQueue.main.async {
         UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
   
  }

  func buyUnlockInAppPurchase() {
    unlockProduct(ProductIdentifier)
  }
}
