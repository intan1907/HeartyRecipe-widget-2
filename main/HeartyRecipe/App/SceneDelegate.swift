//
//  SceneDelegate.swift
//  HeartyRecipe
//
//  Created by Intan Nurjanah on 03/06/21.
//

import UIKit
import SwiftUI
import HeartyRecipeHelper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            if let url = connectionOptions.urlContexts.first?.url {
                self.handleURL(url: url)
            }
        }
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
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return NSLog("No URL passed to open the app")
        }
        
        handleURL(url: url)
    }
    
}

extension SceneDelegate {
    
    func handleURL(url: URL) {
        guard let recipe = recipeData?.first(where: { $0.widgetURL == url }) else {
            let message = "Sorry, we can't find the recipe named \'\(url.host?.removingPercentEncoding ?? "")\'"
            let alertController = UIAlertController(title: "Incoming Message", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            
            window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let nc = window?.rootViewController?.children.first?.children.first as? UINavigationController {
            // if the view currently being displayed is DetailRecipeView, go back to the root view controller
            if nc.title == "Detail Recipe" {
                nc.popToRootViewController(animated: true)
            }
            // push the DetailRecipeView
            nc.pushViewController(HostingController(rootView: DetailRecipeView(recipe: recipe)), animated: true)
        } else {
            window?.rootViewController?.present(HostingController(rootView: DetailRecipeView(recipe: recipe)), animated: true, completion: nil)
        }
    }
    
}

extension UIApplication {
    
    // Function that we can call via `UIApplication.setStatusBarStyle(...)`
    class func setStatusBarStyle(_ style: UIStatusBarStyle) {
        // Get the root view controller, which we've set to be `HostingController`
        if let vc = UIApplication.getKeyWindow()?.rootViewController as? HostingController<ContentView> {
            // Call the method we've defined
            vc.changeStatusBarStyle(style)
        }
    }
    // Helper function to get the key window
    private class func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.windows.first{ $0.isKeyWindow }
    }
}
