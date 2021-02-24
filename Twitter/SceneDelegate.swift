//
//  SceneDelegate.swift
//  Twitter
//
//  Created by sunhyeok on 2021/02/24.
//  Copyright © 2021 Dan. All rights reserved.
//

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene

    self.loadBaseController()
}


func loadBaseController() {
   let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   guard let window = self.window else { return }
   window.makeKeyAndVisible()
   if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
       let loginVC: ViewController = storyboard.instantiateViewController(withIdentifier: "login") as! ViewController
       self.window?.rootViewController = loginVC
   } else {
       let homeVC: HomeViewController = storyboard.instantiateViewController(withIdentifier: "showData") as! HomeViewController
       let navigationHomeVC = UINavigationController(rootViewController: homeVC)
       self.window?.rootViewController = navigationHomeVC
   }
    self.window?.makeKeyAndVisible()
}
