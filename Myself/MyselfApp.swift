//
//  MyselfApp.swift
//  Myself
//
//  Created by Maicol Cabreja on 10/2/22.
//

import SwiftUI
import GoogleMobileAds
import FirebaseCore
import AppTrackingTransparency
import AdSupport
import StoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("TRACKING ENABLED")
                        
                        //init firebase
                        FirebaseApp.configure()
                        //init ads giving true IDFA
                        GADMobileAds.sharedInstance().start(completionHandler: nil)
                        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                        
                        
                    case .denied:
                        print("TRACKING DISABLED")
                        //init ads but since its denied the IDFA is 0000 which means user information wont be tracked
                        FirebaseApp.configure()
                        GADMobileAds.sharedInstance().start(completionHandler: nil)
                        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
                    default:
                        print("DEFAULT TRACKING")
                    }
                }
            }
            else{
                FirebaseApp.configure()
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
        })
        return true
    }
}


@main
struct TippingAppApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(store)
        }
    }
}
