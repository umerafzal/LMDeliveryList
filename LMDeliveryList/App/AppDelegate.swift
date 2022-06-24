//
//  AppDelegate.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 23/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    window?.rootViewController = UINavigationController(
      rootViewController: DependencyContainer.instance.buildDeliveryListScreen()
    )
    window?.makeKeyAndVisible()
    return true
  }

}

