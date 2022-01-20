//
//  SceneDelegate.swift
//  FindCoronaCenterRxSwift
//
//  Created by skillist on 2022/01/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var selectRegionViewModel = SelectRegionViewModel()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootVC = SelectRegionView()
        rootVC.bind(selectRegionViewModel)
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        window?.makeKeyAndVisible()
    }
}
