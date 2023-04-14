
import AVFoundation
import AVKit
import MLYSDK
import SnapKit
import UIKit

class ScrollViewController: UIViewController {
   lazy var playerViewController: AVPlayerViewController = {
       let playerController = AVPlayerViewController()
//        playerController.player = AVPlayer()
       return playerController
   }()
   
   var arr: [String] = []
   lazy var btnHeight: CGFloat = 75
   lazy var cellHeight: CGFloat = UIScreen.main.bounds.height - self.btnHeight - 64
    
   var currentIndex: Int = 1
   
   weak var lastCell: VideoCell?
   
   lazy var tableView: UITableView = {
       var _tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
       _tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       _tableView.backgroundColor = .black
       _tableView.rowHeight = self.cellHeight
       _tableView.bounces = false
       _tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
       _tableView.delegate = self
       _tableView.dataSource = self
       return _tableView
   }()
   
   lazy var playBtn: UIButton = {
       var button = UIButton()
       button.setTitle("Play Video", for: .normal)
       button.setTitleColor(.black, for: .normal)
       button.backgroundColor = .white
       return button
   }()
       
   override func viewDidLoad() {
       super.viewDidLoad()
       self.setupUI()
   }
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.playVideoAction()
   }
   
   func setupUI() {
       self.view.backgroundColor = .black
       self.view.addSubview(self.tableView)
       self.view.addSubview(self.playBtn)
       self.playBtn.snp.makeConstraints { make in
           make.left.right.bottom.equalToSuperview()
           make.height.equalTo(self.btnHeight)
       }
       
       self.playBtn.addTarget(self, action: #selector(self.playVideoAction), for: .touchUpInside)
   }
    
   @objc func playVideoAction() {
       debugPrint("click playVideoAction")
       self.getData()
   }
   
   override func viewDidDisappear(_ animated: Bool) {
       super.viewDidDisappear(animated)
       self.lastCell?.pause()
   }
}

extension ScrollViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.arr.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
           return UITableViewCell()
       }
       let index = indexPath.row
       let url = self.arr[index]
       cell.playerViewController = self.playerViewController
       cell.contentView.tag = index
       cell.urlStr = url
       if index == 0, self.lastCell == nil {
           cell.play()
           self.lastCell = cell
       }
       return cell
   }
}

extension ScrollViewController: UITableViewDelegate {
   func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       DispatchQueue.main.async {
           let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
           scrollView.panGestureRecognizer.isEnabled = false
           let index = IndexPath(row: self.currentIndex, section: 0)
           let cell = self.tableView.cellForRow(at: index) as? VideoCell
           let y = (cell?.contentView.frame.height)! / 3
            
           if translatedPoint.y < -y, self.currentIndex < (self.arr.count - 1) {
               self.currentIndex += 1
           }
           if translatedPoint.y > y, self.currentIndex > 0 {
               self.currentIndex -= 1
           }
           UIView.animate(withDuration: 0.15, delay: 0) {
               self.tableView.scrollToRow(at: index, at: .top, animated: false)
               if cell == self.lastCell {
                   return
               }
               self.lastCell?.pause()
               self.lastCell?.destory()
               cell?.play()
               self.lastCell = cell
           } completion: { _ in
               scrollView.panGestureRecognizer.isEnabled = true
           }
       }
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}

class VideoCell: UITableViewCell {
//    var plugin: MLYAVPlayerPlugin = .init()
   var playerViewController: AVPlayerViewController!
   
   lazy var label: UILabel = .init(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 25))
   var urlStr: String?
    
   deinit {
       debugPrint("TableViewCell deinit")
       self.destory()
       self.playerViewController.player = nil
       self.playerViewController = nil
   }
   
   func destory() {
       debugPrint("TableViewCell destory")
       self.playerViewController.view.removeFromSuperview()
       self.playerViewController.removeFromParent()
       self.playerViewController.player?.replaceCurrentItem(with: nil)
   }
   
   override func awakeFromNib() {
       super.awakeFromNib()
   }
     
   func setupPlayer() {
       debugPrint("setupPlayer")
       if let url = self.urlStr {
           do {
//                self.plugin.adapt(self.playerViewController)
               let videoUrl = try ProxyURLModifier.replace(url)
               let playerItem = AVPlayerItem(url: videoUrl)
               self.playerViewController.player = .init(playerItem: playerItem)
                
               self.playerViewController.showsPlaybackControls = false
               self.playerViewController.view.frame = self.contentView.bounds
               
               let index = self.contentView.tag + 1
               self.label.textColor = .white
               self.label.font = UIFont.boldSystemFont(ofSize: 18)
               self.label.text = "  \(index)"
               
               self.contentView.backgroundColor = .black
               self.selectedBackgroundView?.backgroundColor = .black
               self.contentView.addSubview(self.playerViewController.view)
               self.contentView.addSubview(self.label)
           } catch {
               debugPrint("setupPlayer err: \(error)")
           }
       }
   }
   
   func play() {
       self.setupPlayer()
       self.playerViewController.player?.play()
   }

   func pause() {
       self.playerViewController.player?.pause()
   }
}

extension ScrollViewController {
   func getData() {
       self.lastCell = nil
       self.arr.removeAll()
       for _ in 0 ... 100 {
           self.arr.append("https://vsp-stream.s3.ap-northeast-1.amazonaws.com/HLS/raw/SpaceX.m3u8")
       }
       self.tableView.reloadData()
   }
}
