import MLYSDK
import UIKit

@objcMembers
class DemoConfig: NSObject { 
    static var ll_uat = DemoConfig(
        "cgsangrvdp42j9d4c4v0",
        "vsp.mlytics.co",
        "https://lowlatencydemo.mlytics.co/app/stream/llhls.m3u8"
    )
    static var uat = DemoConfig(
        "celv6v3lj0nerkd2m3pg",
        "vsp.mlytics.co",
        "https://1001659593134-cloudfront-esmydvcw.xpmon.com/hls/f3c3c1c6-37a3-4c32-af77-ef67ce4656ea.mp4/f3c3c1c6-37a3-4c32-af77-ef67ce4656ea.m3u8"
    )
    static var sit = DemoConfig(
        "ceg84gesandb7rct0ke0",
        "vsp.mlytics.us",
        "https://1001635905572-cloudfront-6uqpagm4.svcradar.com/hls/25e6a651-ec4d-4d1f-9664-3cda54acacd9.mp4/25e6a651-ec4d-4d1f-9664-3cda54acacd9.m3u8"
    )

    static var spx1 = DemoConfig(
        "cehcdiphseaa0coe0c10",
        "vsp.mlytics.co",
        "https://1001642588942-cloudfront-z6frgspx.d-apm.com/hls/44372468-f0c5-479e-944c-9ee3e460d40d.mp4/44372468-f0c5-479e-944c-9ee3e460d40d.m3u8"
    )

    static var cdn_error = DemoConfig(
        "cgrr1l3vdp42j9d4c4c0",
        "vsp.mlytics.co",
        "https://1001681370890-cloudfront-tnsqfrda.xpmon.com/hls/dbd5a975-f7e9-4d37-82dc-0875cad677cf.mp4/dbd5a975-f7e9-4d37-82dc-0875cad677cf.m3u8"
    )

    @objc
    static var defaultConfig = ll_uat

    var id: String
    var server: String
    var url: String

    init(_ id: String, _ server: String, _ url: String) {
        self.id = id
        self.server = server
        self.url = url
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let homeNav = UINavigationController(rootViewController: HomeNavViewController())
        window?.rootViewController = homeNav
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}
}

extension UIDevice {
    static func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    static func navigationBarHeight() -> CGFloat {
        return 44.0
    }

    static func navigationFullHeight() -> CGFloat {
        return UIDevice.statusBarHeight() + UIDevice.navigationBarHeight()
    }

    static func tabBarHeight() -> CGFloat {
        return 49.0
    }
}

extension UIImageView {
    func loadFrom(url: String) {
        guard let url = URL(string: url) else {
            return
        }

        if let imageData = try? Data(contentsOf: url),
           let loadedImage = UIImage(data: imageData)
        {
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }
}
