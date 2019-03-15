import UIKit

import Fabric
import Crashlytics

import Localize

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])

        Localize.update(provider: .json)
        Localize.update(fileName: "lang")
        Localize.update(defaultLanguage: "en")

        let navigationController = UINavigationController()

        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
