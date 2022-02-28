//
//  GoogleLoginOptionApp.swift
//  GoogleLoginOption
//
//  Created by Estepa, Kaily on 2/15/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct GoogleLoginOptionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup{
            ContentView()
             .environmentObject(LoginViewModel())
        }
    }
}


 class AppDelegate: NSObject, UIApplicationDelegate{
     
     //Connect Firebase when application starts up
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
 
        FirebaseApp.configure()
        return true
    }
 
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool{
 
        return GIDSignIn.sharedInstance.handle(url)
 
    }
    
 }
 
 
