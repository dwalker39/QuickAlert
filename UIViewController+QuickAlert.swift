//
//  UIViewController+QuickAlert.swift
//  MTSR
//
//  Created by Derrick Walker on 2/19/15.
//
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: Defines
    
    typealias OptionalClosure = (() -> Void)?
    
    // MARK: UIAlert Methods
    
    func showMessage(message: String) {
        self.showMessage(message,
            title: nil,
            style: .Alert,
            buttonCancelText: "OK",
            button1Text: nil,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: nil,
            button1Action: nil,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: "OK",
            button1Text: nil,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: nil,
            button1Action: nil,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonText: String?, buttonAction: OptionalClosure) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: buttonText,
            button1Text: nil,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonAction,
            button1Action: nil,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, buttonText: String?, buttonCancelAction: OptionalClosure, buttonAction: OptionalClosure) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: buttonCancelText,
            button1Text: buttonText,
            button2Text: nil,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: buttonAction,
            button2Action: nil,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, buttonCancelAction: OptionalClosure, button1Action: OptionalClosure, button2Action: OptionalClosure) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: buttonCancelText,
            button1Text: button1Text,
            button2Text: button2Text,
            button3Text: nil,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: button1Action,
            button2Action: button2Action,
            button3Action: nil,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, button3Text: String?, buttonCancelAction: OptionalClosure, button1Action: OptionalClosure, button2Action: OptionalClosure, button3Action: OptionalClosure) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: buttonCancelText,
            button1Text: button1Text,
            button2Text: button2Text,
            button3Text: button3Text,
            button4Text: nil,
            cancelAction: buttonCancelAction,
            button1Action: button1Action,
            button2Action: button2Action,
            button3Action: button3Action,
            button4Action: nil)
    }
    
    func showMessage(message: String?, title: String?, buttonCancelText: String?, button1Text: String?, button2Text: String?, button3Text: String?, button4Text: String?, buttonCancelAction: OptionalClosure, button1Action : OptionalClosure, button2Action: OptionalClosure, button3Action: OptionalClosure, button4Action: OptionalClosure) {
        self.showMessage(message,
            title: title,
            style: .Alert,
            buttonCancelText: buttonCancelText,
            button1Text: button1Text,
            button2Text: button2Text,
            button3Text: button3Text,
            button4Text: button4Text,
            cancelAction: buttonCancelAction,
            button1Action: button1Action,
            button2Action: button2Action,
            button3Action: button3Action,
            button4Action: button4Action);
    }
    
    // MARK: Private Methods
    
    private func showMessage(message: String?, title: String?, style: UIAlertControllerStyle, buttonCancelText: String?, buttonDestructiveText: String? = nil, button1Text: String?, button2Text: String?, button3Text: String?, button4Text: String?, cancelAction: OptionalClosure, destructiveAction: OptionalClosure = nil, button1Action: OptionalClosure, button2Action: OptionalClosure, button3Action: OptionalClosure, button4Action: OptionalClosure) {
        let currentVersion = UIDevice.currentDevice().systemVersion as NSString
        
        if currentVersion.floatValue < 8 {
            QuickAlert.showMessage(message, withTitle: title, buttonCancel: buttonCancelText, button1: button1Text, button2: button2Text, button3: button3Text, button4: button4Text, cancelBlock: cancelAction, action1Block: button1Action, action2Block: button2Action, action3Block: button3Action, action4Block: button4Action)
        } else {
            func createAlertAction(title: String, style: UIAlertActionStyle, handler: OptionalClosure) -> UIAlertAction {
                func createAlertActionHandler(action: OptionalClosure) -> (UIAlertAction!) -> Void {
                    var alertAction: (UIAlertAction!) -> Void = {
                        (UIAlertAction) -> Void in
                        
                        if action != nil {
                            action!()
                        }
                    }
                    
                    return alertAction
                }
                
                return UIAlertAction(title: title, style: style, handler: createAlertActionHandler(handler))
            }
            
            var actionsArray = Array<UIAlertAction>()
            
            if buttonCancelText != nil {
                actionsArray.append(createAlertAction(buttonCancelText!, .Cancel, cancelAction))
            }
            
            if buttonDestructiveText != nil {
                actionsArray.append(createAlertAction(buttonDestructiveText!, .Destructive, destructiveAction))
            }
            
            if button1Text != nil {
                actionsArray.append(createAlertAction(button1Text!, .Default, button1Action))
            }
            
            if button2Text != nil {
                actionsArray.append(createAlertAction(button2Text!, .Default, button2Action))
            }
            
            if button3Text != nil {
                actionsArray.append(createAlertAction(button3Text!, .Default, button3Action))
            }
            
            if button4Text != nil {
                actionsArray.append(createAlertAction(button4Text!, .Default, button4Action))
            }
            
            self.showAlert(title, message: message, style: style, actions: actionsArray)
        }
    }
    
    private func showAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]) {
        self.showAlert(title: title, message: message, style: style, animated: true, completion: nil, actions: actions)
    }
    
    private func showAlert(#title: String?, message: String?, style: UIAlertControllerStyle, animated: Bool, completion: (() -> Void)?, actions: [UIAlertAction]) {
        if (title == nil && message == nil && style == .Alert) {
            return;
        }
        
        var alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        self.presentViewController(alertController, animated: animated, completion: completion)
    }
    
    private func showAlert(#title: String?, message: String?, animated: Bool, completion: (() -> Void)?, actions: UIAlertAction?...) {
        if (title == nil && message == nil) {
            return;
        }
        
        var alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        for action in actions {
            if let _action = action {
                alertController.addAction(_action)
            } else {
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            }
        }
        
        self.presentViewController(alertController, animated: animated, completion: completion)
    }
}