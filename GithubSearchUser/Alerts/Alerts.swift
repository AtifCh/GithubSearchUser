//
//  Alerts.swift
//  Anythingeek
//
//  Created by Ali Bin Tariq on 12/8/16.
//  Copyright © 2016 Anythingeek. All rights reserved.
//

import UIKit



enum AlertType: String {
    case Ok = "Ok"
    case Alert = "Alert"
    case Error = "Error"
    case Warning = "Warning"

}
//MARK:- UIAlertController extension
extension UIAlertController{
    
    func show() {
        present(animated: true, completion: nil)
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            self.presentFromController(controller: topController, animated: true, completion: nil)
            // topController should now be your topmost view controller
        }
        
//        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
//            presentFromController(controller: rootVC, animated: animated, completion: completion)
//        }
    }
    
    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(controller: visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(controller: selectedVC, animated: animated, completion: completion)
            }
//            else if let sideControler = controller as? ShirSideMenuViewController{
//                let centerController = sideControler.centerViewController
//                presentFromController(controller: centerController!, animated: animated, completion: completion)
//            }
            else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
    }
}

class Alerts: NSObject {
    
    
   
    class func showAlertWithError(_ error:Error){
        let alert = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
                alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(okAction)
        
        alert.show()
    }
    
    
    class func showOKAlertWithMessage(_ message: String, andTitle title: AlertType){
        let alert = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        
        alert.show()
    }
    
    class func showOKAlertWithMessage(_ message: String, andTitle title: AlertType, closure:@escaping ()->()){
        let alert = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
            closure()
        })
        alert.addAction(okAction)
        
        alert.show()
    }

    class func showOKAndCancelAlertWithMessage(_ message: String, andTitle title: AlertType, OkAction:(() -> Swift.Void)? = nil , cancelAction:(() -> Swift.Void)? = nil){
        
        let alert = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            if OkAction?() == nil {
            
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{(action) in
            
            print("Cancel Action call")
            if cancelAction?() != nil {
            
            }

        }))
        
        alert.show()
    }
    
    class func showOKAndCancelAlertWithMessage(_ message: String, andTitle title: AlertType,okButtonTitle:String, cancelButtonTitle:String, OkAction:(() -> Swift.Void)? = nil , cancelAction:(() -> Swift.Void)? = nil){
        
        let alert = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:okButtonTitle , style: .default, handler: { action in
            
            if OkAction?() == nil {
                
            }
        }))
        
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler:{(action) in
            
            print("Cancel Action call")
            if cancelAction?() != nil {
                
            }
            
        }))
        
        alert.show()
    }

    
    
    
    class func showOKAlertWithMessageWithCancelOption(_ message: String, andTitle title: AlertType, closure:@escaping ()->()){
        let alert = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
            closure()
        })
        
        alert.addAction(okAction)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        alert.show()
    }

    
    
    
    
    
    

}
