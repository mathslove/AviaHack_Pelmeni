//
//  AlertManager.swift
//  Lykke
//
//  Created by Даниил Храповицкий on 04.02.2021.
//

import UIKit

final class AlertManager {
    
    // MARK: - Typealiases
    typealias TextFieldHandler = ((UITextField) -> Void)?
    
    // MARK: - Properties
    static let shared = AlertManager()
    var alert: UIAlertController?
    let tap = UITapGestureRecognizer()
    
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Methods
    func showNotification(title: String,
                          message: String? = nil,
                          textFieldHandlers: [TextFieldHandler]? = nil,
                          actions: [UIAlertAction]? = nil) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert!.view.tintColor = .blue
        
        if let textFieldHandlers = textFieldHandlers {
            for textFieldHandler in textFieldHandlers {
                alert!.addTextField(configurationHandler: textFieldHandler)
            }
        }
        
        if let actions = actions {
            for (index, action) in actions.enumerated() {
                alert!.addAction(action)
                
                if index == actions.count - 1 && actions.count > 1 {
                    alert!.preferredAction = action
                }
            }
        }
        
        show(viewController: alert!)
    }
    
    func showBottomSheet(title: String?, message: String? = nil, actions: [UIAlertAction]?) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if let actions = actions {
            for action in actions {
                alert!.addAction(action)
            }
        }
        
        show(viewController: alert!)
    }
    
    func show(viewController: UIViewController, completion: (() -> Void)? = nil) {
        if var controller = UIApplication.shared.windows[0].rootViewController {
            while let presentedViewController = controller.presentedViewController {
                controller = presentedViewController
            }
            controller.present(viewController, animated: true, completion: completion)
        }
    }
}
