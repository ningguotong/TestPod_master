import UIKit
 
class UICopyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
        self.setUp()
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
        self.setUp()
    }
    
    func setUp() {
        self.numberOfLines = 0
        self.lineBreakMode = .byCharWrapping
    }
     
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu(sender:))))
    }
     
    @objc func showMenu(sender: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }
       
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }
}
