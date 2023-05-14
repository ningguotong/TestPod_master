
import MLYSDK
import UIKit

class HomeNavViewController: UIViewController {
    
    var copyLab: UICopyLabel!

    var chartButton: UIButton!

    var goScrollButton: UIButton!

    var playerButton: UIButton!

    var restartButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupDriver()
    }

    @objc func goChartAction() {
        debugPrint("Chart Group") 
    }

    @objc func goScrollBtnAction() {
        print("click goScrollBtnAction")
    }

    @objc func goPlayerVideoBtnAction() {
        print("click goPlayerVideoBtnAction")
        let playerController = PlayerViewController()
        self.navigationController?.pushViewController(playerController, animated: true)
    }

    @objc func setupDriver() {
        debugPrint("setupDriver")

        do {
            try MLYDriver.initialize { options in
                options.client.id = DemoConfig.defaultConfig.id
                options.server.host.fqdn = DemoConfig.defaultConfig.server
                options.debug = true
            }
        } catch {
            print(error)
        }
    }
}

extension HomeNavViewController {
    func setupUI() {
        self.view.backgroundColor = .black
        let btnHeight = 50.0

        self.chartButton = UIButton(frame: CGRect(x: 0, y: 75, width: self.view.frame.width, height: btnHeight))
        self.chartButton.setTitle("Chart Group", for: .normal)
        self.chartButton.setTitleColor(.white, for: .normal)

        self.goScrollButton = UIButton(frame: CGRect(x: 0, y: self.chartButton.frame.maxY, width: self.view.frame.width, height: btnHeight))
        self.goScrollButton.setTitle("Scroll Video", for: .normal)
        self.goScrollButton.setTitleColor(.white, for: .normal)

        self.playerButton = UIButton(frame: CGRect(x: 0, y: self.goScrollButton.frame.maxY, width: self.view.frame.width, height: btnHeight))
        self.playerButton.setTitle("Player Video", for: .normal)
        self.playerButton.setTitleColor(.white, for: .normal)

        self.restartButton = UIButton(frame: CGRect(x: 0, y: self.playerButton.frame.maxY, width: self.view.frame.width, height: btnHeight))
        self.restartButton.setTitle("Restart Driver", for: .normal)
        self.restartButton.setTitleColor(.white, for: .normal)

        self.copyLab = UICopyLabel(frame: CGRect(x: 0, y: self.restartButton.frame.maxY + 20.0, width: self.view.frame.width, height: 200))
        self.copyLab.textColor = .white
        self.copyLab.text = "Getting #peer_id"

        self.goScrollButton.addTarget(self, action: #selector(self.goScrollBtnAction), for: .touchUpInside)
        self.chartButton.addTarget(self, action: #selector(self.goChartAction), for: .touchUpInside)
        self.playerButton.addTarget(self, action: #selector(self.goPlayerVideoBtnAction), for: .touchUpInside)
        self.restartButton.addTarget(self, action: #selector(self.setupDriver), for: .touchUpInside)

        self.view.addSubview(self.copyLab)
        self.view.addSubview(self.chartButton)
        self.view.addSubview(self.goScrollButton)
        self.view.addSubview(self.playerButton)
        self.view.addSubview(self.restartButton)

        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            var text = "Peer: \(MLYData.instance.peerID ?? "") \n"
            self.copyLab.text = text
        }
    }
}
