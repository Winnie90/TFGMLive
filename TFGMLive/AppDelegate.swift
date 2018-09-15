//
//  AppDelegate.swift
//  TFGMLive
//
//  Created by Christopher Winstanley on 21/12/2017.
//  Copyright © 2017 Winstanley. All rights reserved.
//

import UIKit
import StationRequest

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator.init(window: window!)
        appCoordinator?.dynamicLinksUpdated = { shortcutItems in
            DispatchQueue.main.async {
                application.shortcutItems = shortcutItems
            }
        }
        
        if let shortcutItem =
            launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem]
                as? UIApplicationShortcutItem {
            if let app = appCoordinator {
                let _ = app.handleShortcut(shortcutItem: shortcutItem)
            }
            return false
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
            if let app = appCoordinator {
                if #available(iOS 12.0, *) {
                    if let stationIntent = userActivity.interaction?.intent as? ViewStationIntent,
                        let identifier = stationIntent.station?.identifier {
                        return app.handle(identifier: identifier)
                    }
                }
                let _ = app.handleUserActivity(userActivity)
                return true
            }
        }
        return false
    }
    

    func application(_ application: UIApplication,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        if let app = appCoordinator {
            completionHandler(app.handleShortcut(shortcutItem: shortcutItem))
        } else {
            completionHandler(false)
        }
    }
}

