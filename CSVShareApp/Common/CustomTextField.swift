import UIKit
import Foundation

@IBDesignable
class CustomTextField: UITextField {
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
            
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .blue {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    private var _isRightViewVisible: Bool = true
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    func updateView() {
        setLeftImage()
        setRightImage()

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: tintColor!])
    }
    func setLeftImage() {
        leftViewMode = .always
        var view: UIView

        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor

            var width = imageView.frame.width + leftPadding

            if borderStyle == .none || borderStyle == .line {
                width += 5
            }

            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }

        leftView = view
    }

    func setRightImage() {
        rightViewMode = UITextField.ViewMode.always

        var view: UIView

        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor

            var width = imageView.frame.width + rightPadding

            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }

            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)

        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }

        rightView = view
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder : decoder)
        
        //        self.layer.shadowColor = UIColor.gray.cgColor
        //        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        //        self.layer.shadowOpacity = 1.0
        //        self.layer.shadowRadius = 0.0
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderStyle = .none
        //        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = true
        self.setToolbar()
    }
//    func setToolbar(){
//        let toolBarHeight:CGFloat = 150
//        //製作鍵盤上方幫手
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: superview?.bounds.width ?? 150, height: toolBarHeight))
//        //左邊空白處
//        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        //想製作的按鈕及用途
//        let doneBotton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneButtonAction))
//        toolBar.setItems([flexSpace,doneBotton], animated: false)
//        toolBar.sizeToFit()
//        self.inputAccessoryView = toolBar
//    }
//    @objc func doneButtonAction() {
//        superview?.endEditing(true)
//    }
    
    func settextField(imageNamed: String){
        self.contentMode = .scaleToFill
        let imageView = UIImageView(frame: CGRect(x: 20, y: ( self.bounds.height - 30 ) / 2, width: 30, height: 30));
        let image = UIImage(named: imageNamed)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.height + 10, height: self.bounds.height))
        leftView.addSubview(imageView)
        self.leftView = leftView
        self.leftViewMode = .always
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        
    }
    
}
class LeftUITextField: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        if #available(iOS 13.0, *) {
//            self.setLeftImage(leftImage: UIImage(systemName: "magnifyingglass")!)
//
//
//        } else {
//            // Fallback on earlier versions
//        }
        self.setLeftImage(leftImage: UIImage(named: "search64")!)
        self.underlinedLogin()
        self.placeHolderTextColor(color:UIColor.lightGrayColor)
    }
    override func layoutSubviews() {
        
    }
}
class SearchUITextField: UITextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setBottomBorder()
//        self.placeHolderTextColor(color:UIColor.white)
//        if #available(iOS 13.0, *) {
//            UIImage(systemName: "magnifyingglass")!
//
//        } else {
//
//        }
//        self.setLeftImage(leftImage: UIImage(named: "search64")!)
//        self.switchEntry()
    }
//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//
//    }
}
class CustomUITextField: UITextField {
    
    var border : CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        print("layoutSubviews")
        self.underlined()
    }
    func underlined()
    {
        if border == nil {
            border = CAGradientLayer()

            let width = CGFloat(1.0)

            border?.borderColor = UIColor.white.cgColor
            border?.frame = CGRect(x: 0, y: self.bounds.size.height - width, width:  self.bounds.size.width, height: width)
            border?.borderWidth = width
            self.layer.addSublayer(border!)
            self.layer.masksToBounds = true
            
            let placeHolderText = self.placeholder ?? ""
            let str = NSAttributedString(string:placeHolderText, attributes: [NSAttributedString.Key.foregroundColor :UIColor.white])
            self.attributedPlaceholder = str
        }
        

        
    }
}

class NoLineUITextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let placeHolderText = self.placeholder ?? ""
        let str = NSAttributedString(string:placeHolderText, attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGrayColor])
        self.attributedPlaceholder = str
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class CustomPassWordTextField: UITextField{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.switchTextEntry()
    }
}

extension UITextField {
    func placeHolderTextColor(color:UIColor){
        let placeHolderText = self.placeholder ?? ""
        let str = NSAttributedString(string:placeHolderText, attributes: [NSAttributedString.Key.foregroundColor :color])
        self.attributedPlaceholder = str
    }
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func underlinedLogin()
    {
        let border = CAGradientLayer()

        let width = CGFloat(1.0)

        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        let placeHolderText = self.placeholder ?? ""
        let str = NSAttributedString(string:placeHolderText, attributes: [NSAttributedString.Key.foregroundColor :UIColor.white])
        self.attributedPlaceholder = str
    }
    func setLeftImage(leftImage:UIImage) {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = leftImage
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit

        var width = imageView.frame.width

//        if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
//            width += 5
//        }
        width += 5
        view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.addSubview(imageView)

        leftView = view
    }
    func setRightImage(rightImage:UIImage) {
        rightViewMode = UITextField.ViewMode.always

        var view: UIView

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = rightImage
        // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        var width = imageView.frame.width 

        if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
            width += 5
        }

        view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.addSubview(imageView)

        rightView = view
    }
    func setToolbar(){
        let toolBarHeight:CGFloat = 150
        //製作鍵盤上方幫手
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: toolBarHeight))
        //左邊空白處
        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //想製作的按鈕及用途
        let doneBotton: UIBarButtonItem = UIBarButtonItem(title: "ok", style: .done, target: self, action: #selector(doneButtonAction))
        toolBar.setItems([flexSpace,doneBotton], animated: false)
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    @objc func doneButtonAction() {
        self.endEditing(true)
    }
    func switchTextEntry() {
        let bt = UIButton(type: .custom)
        bt.addTarget(self, action: #selector(self.switchEntry), for: .touchUpInside)
        bt.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        bt.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        bt.setImage(UIImage(named: "view"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(bt)
        rightViewMode = .always
        rightView = view
    }
    @objc func switchEntry() {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
    
    func setClickRight(image:String){
        let bt = UIButton(type: .custom)
        bt.addTarget(self, action: #selector(textRightClick), for: .touchUpInside)
        bt.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        bt.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        bt.setImage(UIImage(named: image), for: .normal)
//        bt.setBackgroundImage(UIImage(named: image), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(bt)
        rightViewMode = .always
        rightView = view
    }
    @objc func textRightClick() {
        becomeFirstResponder()
    }

}
