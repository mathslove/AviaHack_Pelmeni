//
//  AppDelegate.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 23.04.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let registration = RegistrationAssembly.module()
        let navigationController = UINavigationController(rootViewController: registration)
        window.rootViewController = navigationController

        FirebaseApp.configure()
        
//        try! Auth.auth().signOut()
        
//        window.rootViewController = UINavigationController(rootViewController: ExtraAssembly.module(type: .worker))
        
        configureNavigationBar()
//
        addListener(window)
//
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
    func addListener(_ window: UIWindow) {
        Auth.auth().addStateDidChangeListener { (_, user) in
            if user != nil {
                DatabaseManager.startListen()
                
                if user!.isEmailVerified {
                    let home = HomeAssembly.module()
                    let navigation = UINavigationController(rootViewController: home)
                    window.rootViewController = navigation
                } else {
                    let verification = VerificationAssembly.module()
                    let navigation = UINavigationController(rootViewController: verification)
                    window.rootViewController = navigation
                }
            }
        }
    }
}

extension AppDelegate {
    func pushVerification(_ window: UIWindow) {
        let verification = VerificationAssembly.module()
        (window.rootViewController as! UINavigationController).pushViewController(verification, animated: true)
    }
    
    func pushWhoAmI(_ window: UIWindow) {
        let whoami = WhoAmIAssembly.module()
        (window.rootViewController as! UINavigationController).pushViewController(whoami, animated: true)
    }
    
    func pushExtra(_ window: UIWindow, type: ExtraScreenType) {
        let extra = ExtraAssembly.module(type: type)
        (window.rootViewController as! UINavigationController).pushViewController(extra, animated: true)
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .blue
    }
}
