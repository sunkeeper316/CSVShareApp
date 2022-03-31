//
//  SceneDelegate.swift
//  CSVShareApp
//
//  Created by Sun Huang on 2022/3/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        if let data = UserDefaults(suiteName: "group.com.charder.CSVShareApp")?.value(forKey: "file") as? Data {
//            analysisData(data: data)
//        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            print("URLContexts \(url)")
            print("URLContexts \(url.host)")
            print("URLContexts \(url.scheme)")
            if let data = UserDefaults(suiteName: "group.com.charder.CSVShareApp")?.value(forKey: "file") as? Data {
                analysisData(data: data)
                UserDefaults(suiteName: "group.com.charder.CSVShareApp")?.removeObject(forKey: "file")
                
            }
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            
            if let rootVC = sceneDelegate?.window?.rootViewController as? MeasuredPersonListViewController {
                print("rootVC")
                
                print("rootVC presentedViewController \(rootVC.presentedViewController)")
                if let presentedViewController = rootVC.presentedViewController {
                    presentedViewController.dismiss(animated: true)
                }
                rootVC.measuredPersons = CoreDataManage.shared.loadAllMeasuredPerson()
                print("count \(rootVC.measuredPersons.count)")
                
                if rootVC.measuredPersons.count == 0 {
        //            tableView.isHidden = true
                    rootVC.setNodata()
                    rootVC.tableView.reloadData()
                }else{
        //            tableView.isHidden = false
                    rootVC.setHaveData()
                    rootVC.tableView.reloadData()
                }
            }
            
        }
    }
    
    
        
    func handleIncomingURL(_ url: URL) {
        if let scheme = url.scheme,
           scheme.caseInsensitiveCompare("ShareExportApp") == .orderedSame,
           let page = url.host {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            print("redirect(to: \(page), with: \(parameters))")
            
            for parameter in parameters where parameter.key.caseInsensitiveCompare("url") == .orderedSame {
                UserDefaults().set(parameter.value, forKey: "incomingURL")
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

