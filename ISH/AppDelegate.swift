//
//  AppDelegate.swift
//  ISH
//
//  Created by Admin on 10/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


let defaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let apiKey = "NXqXAgFZA0jiWp5t6+=lGpgWJXEkbo"
    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        skipLogin()
        IQKeyboardManager.shared.enable = true

        //setInitialVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    
    private func skipLogin(){
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        if defaults.object(forKey: "skipSignIn") != nil{
            
            let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC")
            self.window?.rootViewController = initialViewController
            
            
        }else{
            setInitialVC()
        }
        
    }
    
    
    
    private func setInitialVC(){
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Assuming your storyboard is named "Main"
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if defaults.object(forKey: "userID") != nil{
            let loginSession = defaults.string(forKey: "userID")
            //            print(loginSession)
            if loginSession == ""{
                
                let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC")
                self.window?.rootViewController = initialViewController
            }else{
                
                let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC")
                self.window?.rootViewController = initialViewController
            }
        }else{
            let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC")
            self.window?.rootViewController = initialViewController
        }
        
        self.window?.makeKeyAndVisible()
    }

}

