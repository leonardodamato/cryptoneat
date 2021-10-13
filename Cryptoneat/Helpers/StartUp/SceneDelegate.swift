//
//  SceneDelegate.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 5/9/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func createHomeNavBar() -> UINavigationController {
        let nav = UINavigationController(rootViewController: HomeViewController())
        
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.view.backgroundColor = .clear
        nav.navigationBar.tintColor = Colors.tint
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.secondary]
        nav.navigationBar.titleTextAttributes = textAttributes
        
        let icon = UIImage(systemName: "house")
        let selectedIcon = UIImage(systemName: "house.fill")
        let tabBarItem = UITabBarItem(title: "", image: icon, selectedImage: selectedIcon)
        nav.tabBarItem = tabBarItem
        
        return nav
    }
    
    
    func createMarketNavBar() -> UINavigationController {
        let nav = UINavigationController(rootViewController: MarketListViewController())
        
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.view.backgroundColor = .clear
        nav.navigationBar.tintColor = Colors.tint
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.secondary]
        nav.navigationBar.titleTextAttributes = textAttributes
        
        let icon = UIImage(systemName: "chart.bar")
        let selectedIcon = UIImage(systemName: "chart.bar.fill")
        let tabBarItem = UITabBarItem(title: "", image: icon, selectedImage: selectedIcon)
        nav.tabBarItem = tabBarItem
        
        return nav
    }
    
    func createFavoritesNavBar() -> UINavigationController {
        let nav = UINavigationController(rootViewController: FavoritesViewController())
        
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        nav.view.backgroundColor = .clear
        nav.navigationBar.tintColor = Colors.tint
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.secondary]
        nav.navigationBar.titleTextAttributes = textAttributes
        
        let icon = UIImage(systemName: "star")
        let selectedIcon = UIImage(systemName: "star.fill")
        let tabBarItem = UITabBarItem(title: "", image: icon, selectedImage: selectedIcon)
        nav.tabBarItem = tabBarItem
        
        return nav
    }
    
    func createTabbar() -> UITabBarController {
        let viewControllers = [createHomeNavBar(), createMarketNavBar(), createFavoritesNavBar()]
        
        let tabbarController = UITabBarController()
        
        tabbarController.viewControllers = viewControllers
        
        tabbarController.tabBar.unselectedItemTintColor = Colors.secondary
        tabbarController.tabBar.tintColor = Colors.tint
        
        tabbarController.tabBar.backgroundImage = UIImage()
        tabbarController.tabBar.shadowImage = UIImage()
        tabbarController.tabBar.isTranslucent = true
        tabbarController.view.backgroundColor = .clear
        
        
        return tabbarController
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

