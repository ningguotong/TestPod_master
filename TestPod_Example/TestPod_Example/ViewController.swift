
import MLYSDK
import UIKit

class ViewController: UIViewController {
    lazy var goScrollBtn: UIButton = {
        var button = UIButton()
        button.setTitle("Scroll Video", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDriver()
        self.setupUI()
    }

    let m3u8_id = "cegh8d9j11u91ba1u600"
    let m3u8_url = "https://vsp-stream.s3.ap-northeast-1.amazonaws.com/HLS/raw/SpaceX.m3u8"
    let m3u8_server = "vsp.mlytics.com"

    func setupDriver() {
        debugPrint("setupDriver")

        do {
            try MLYDriver.initialize { options in
                options.client.id = m3u8_id
                options.server.host.fqdn = m3u8_server
                options.debug = true
            }
        } catch {
            print(error)
        }
    }

    @objc func goScrollBtnAction() {
        print("click goScrollBtnAction")
        let scrollController = ScrollViewController()
        scrollController.view.frame = self.view.frame
        self.present(scrollController, animated: true)
    }
}

extension ViewController {
    func setupUI() {
        self.view.backgroundColor = .black
        let btn_width = self.view.bounds.width / 3 - (2 + 5)
        let view_height = 55

        self.view.addSubview(self.goScrollBtn)
        self.goScrollBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(view_height)
        }
    }
}
