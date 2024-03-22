//
//  SceneDelegate.swift
//  OpenWeather
//
//  Created by MEGA_Mac on 2024/03/20.
//

import UIKit

import CombineModule
import ReactorKitModule

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: WeatherCombineViewController(viewModel: WeatherCombineViewModel(weatherService: WeatherService())))
        window?.makeKeyAndVisible()
    }
}

