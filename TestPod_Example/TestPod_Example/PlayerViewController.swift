import AVFoundation
import AVKit
import MLYSDK
import SnapKit
import UIKit

class PlayerViewController: UIViewController {
    var player = AVPlayer()
    var timer: Timer?
    var plugin = MLYAVPlayerPlugin()

    lazy var playerViewController: AVPlayerViewController = {
        var controller = AVPlayerViewController()
        controller.showsPlaybackControls = true
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .darkGray
        controller.player = player
        return controller
    }()

    lazy var playButton: UIButton = {
        var button = UIButton()
        button.setTitle("Play Video", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    lazy var info: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = .systemFont(ofSize: 18)
        text.textContainer.lineBreakMode = .byClipping
        return text
    }()

    lazy var test1Btn: UIButton = {
        var button = UIButton()
        button.setTitle("Test 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    lazy var test2Btn: UIButton = {
        var button = UIButton()
        button.setTitle("Test 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()

    lazy var testSupView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()

    func setInfo(_ text: String) {
        DispatchQueue.main.async {
            let attributedText = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byCharWrapping
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            self.info.attributedText = attributedText
            self.info.textColor = .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in

            let currentTime = self.player.currentTime()

            var text = ""

            text.append("\(TimeTool.makeNowFstring("HH:mm:ss")) \n")
            text.append(StringTool.format("Play Time: %.1f \n", currentTime.seconds))

            let status = self.player.currentItem?.status

            let buffer = AVPlayerTool.remainBufferedTime(self.player.currentItem, currentTime)
            text.append(StringTool.format("Buffered Time: %.1f \n", buffer))

            if status == .readyToPlay {
                text.append("Play Status: readyToPlay \n")
            } else if status == .failed {
                text.append("Play Status: failed \n")
            } else {
                text.append("Play Status: unknowed \n")
            }

            if let reason = self.player.reasonForWaitingToPlay {
                text.append("Reason: \(reason.rawValue) \n")
            }

            text.append("Peer: \(MLYData.instance.peerID ?? "") \n")
            text.append("SwarmID: \(MLYData.instance.swarmID ?? "") \n")
            text.append("OtherPeerID: \(MLYData.instance.otherPeerID ?? "") \n")
            text.append("SwarmUserCount: \(MLYData.instance.swarmUserCount ?? 0) \n")
            text.append("Cenrifuge state: \(MLYData.instance.centrifugeState) \n")
            text.append("WebRTC state: \(MLYData.instance.webrtcState) \n")
            self.setInfo(text)

            self.plugin.keepLatency(0)

        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plugin.adapt(self.playerViewController)
        self.playVideo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.plugin.deactivate()
        self.playerViewController.player?.replaceCurrentItem(with: nil)
        self.timer?.invalidate()
        self.timer = nil
    }

    @objc func playVideo() {
        debugPrint("Play Video")
        let url = URL(string: DemoConfig.defaultConfig.url)!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }

    @objc func test1Action() {
        print("click test1")
        MLYDriver.test1()
    }

    @objc func test2Action() {
        print("click test2")
        self.seekToEnd()
    }

    func seekToEnd() {
        let end = AVPlayerTool.maxLoadedTime(self.player.currentItem, self.player.currentTime())
        let target = CMTimeMakeWithSeconds(0.3, preferredTimescale: end.timescale)
        let to = end - target
        player.seek(to: to, toleranceBefore: .zero, toleranceAfter: .zero) { seek in
            if seek {
                self.player.play()
            }
        }
    }
}

extension PlayerViewController {
    func setupUI() {
        self.view.backgroundColor = .black
        let btn_width = self.view.bounds.width / 2 - 1
        let view_height = 55

        self.addChild(self.playerViewController)
        self.view.addSubview(self.playerViewController.view)
        self.playerViewController.view.snp.makeConstraints { make in
            make.height.equalTo(self.view.bounds.width / 16 * 9)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(UIDevice.navigationFullHeight())
        }

        self.view.addSubview(self.playButton)
        self.playButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-34)
            make.height.equalTo(view_height)
        }

        self.view.addSubview(self.testSupView)
        self.testSupView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(view_height)
            make.bottom.equalTo(self.playButton.snp.top).offset(-1)
        }

        self.testSupView.addSubview(self.test1Btn)
        self.test1Btn.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.width.equalTo(btn_width)
        }

        self.testSupView.addSubview(self.test2Btn)
        self.test2Btn.snp.makeConstraints { make in
            make.left.equalTo(self.test1Btn.snp.right).offset(1)
            make.bottom.height.equalToSuperview()
            make.width.equalTo(btn_width)
        }

        self.view.addSubview(self.info)
        self.info.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.playerViewController.view.snp.bottom).offset(10)
            make.bottom.equalTo(self.test1Btn.snp.top).offset(-10)
        }

        self.playButton.addTarget(self, action: #selector(self.playVideo), for: .touchUpInside)
        self.test1Btn.addTarget(self, action: #selector(self.test1Action), for: .touchUpInside)
        self.test2Btn.addTarget(self, action: #selector(self.test2Action), for: .touchUpInside)
    }
}
