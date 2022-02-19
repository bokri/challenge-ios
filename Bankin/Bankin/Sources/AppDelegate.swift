//
//  AppDelegate.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window?.backgroundColor = Assets.ColorAssets.white.color
        
        // Theme settings
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Assets.ColorAssets.blue.color
        navBarAppearance.titleTextAttributes = [.foregroundColor: Assets.ColorAssets.itemColor.color]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = Assets.ColorAssets.blue.color
        UINavigationBar.appearance().tintColor = Assets.ColorAssets.itemColor.color
        
        self.initViewControllers()

        return true
    }

    // MARK: Other method

    func initViewControllers() {
        let homeViewController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
    }
}
