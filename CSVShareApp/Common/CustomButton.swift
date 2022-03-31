
import UIKit
import Foundation

@IBDesignable
class CustomButton : UIButton {
    //    var gradientlayer : CAGradientLayer!
    let selectedColor = UIColor(displayP3Red: 35 / 255, green: 85 / 255, blue: 140 / 255, alpha: 1)
    
    static override var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
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
    @IBInspectable var gradientLeftColor: UIColor = .clear {
        didSet {
            setGradientColor()
        }
    }
    @IBInspectable var gradientRightColor: UIColor = .clear {
        didSet {
            setGradientColor()
        }
    }
    override open var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? selectedColor : UIColor.clear
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder decoder:NSCoder) {
        super.init(coder: decoder)
        imageView?.contentMode = .scaleAspectFit
        self.setTitleColor(.black, for: .highlighted)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
        //        self.drawShadow(shadowColor: .black, opacity: 2, offset: CGSize(width: 0, height: 2), radius: 2, shouldRasterize: false)
    }
    
//    @objc func touchDown(){
//        UIButton.animate(withDuration: 0.2) {
//            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        }
//    }
//    @objc func touchUp(){
//        UIButton.animate(withDuration: 0.2) {
//            self.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
//    }
    override func awakeFromNib() {
        
        
    }

    // 設定漸層用storyboard時用到
    func setCornerRadius(){
        
        layer.cornerRadius = self.frame.height / 2
        drawShadow(shadowColor: .lightGray, opacity: 2, offset: CGSize(width: 2, height: 2), radius: 5, shouldRasterize: false)
//        let left = (self.frame.width - self.titleLabel!.frame.width ) / 2 - self.imageView!.frame.width
//        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 0)
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    func setGradientColor(){
        (layer as! CAGradientLayer).colors = [gradientLeftColor.cgColor,gradientRightColor.cgColor]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0, y: 0.5)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    func setStyleBlue(){
        self.setTitleColor(.white, for: .normal)
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.bounds.width , height: self.bounds.height))
        layer.cornerRadius = self.bounds.height / 2
        layer.colors = [UIColor(displayP3Red: 30 / 255, green: 1, blue: 1, alpha: 1).cgColor,UIColor(displayP3Red: 30 / 255, green: 0.5, blue: 1, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(layer, at: 0)
    }
    func setStyleRed(){
        self.setTitleColor(.white, for: .normal)
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.bounds.width , height: self.bounds.height))
        layer.cornerRadius = self.bounds.height / 2
        layer.colors = [UIColor(displayP3Red: 1, green: 0.3, blue: 0.1, alpha: 1).cgColor,UIColor(displayP3Red: 1, green: 0.3, blue: 0.9, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(layer, at: 0)
    }
    func setStyleClear(){
        
        self.layer.borderColor = UIColor.blue.cgColor
        self.setTitleColor(.blue, for: .normal)
        self.layer.borderWidth = 1
    }
    func drawShadow(shadowColor: UIColor = UIColor.black, opacity: Float , offset: CGSize, radius: CGFloat , shouldRasterize : Bool) {
//        self.layer.cornerRadius = 5
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = shouldRasterize
        self.clipsToBounds = false
    }
}

class BackUIButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.contentMode = .scaleAspectFit
        
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
}
class CustomUIButton : UIButton {
    var customlayer : CAGradientLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
//        print("layoutSubviews")
        if customlayer == nil {
            self.setGaryGradual()
        }
        
        self.setClick()
    }
    func setCLickGradual(){
        if customlayer != nil {
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }
        customlayer = CAGradientLayer()
        customlayer?.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.frame.width , height: self.frame.height))
//        customlayer?.colors = styleList[currentUIStyleIndex].buttonGradualColors
        customlayer?.startPoint = CGPoint(x: 0.5, y: 0)
        customlayer?.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(customlayer!, at: 0)
        
    }
    func setGaryGradual(){
        if customlayer != nil {
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }
        customlayer = CAGradientLayer()
        customlayer?.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.frame.width , height: self.frame.height))
        
        customlayer?.colors = UIColor.grayGradualColor
        customlayer?.startPoint = CGPoint(x: 0.5, y: 0)
        customlayer?.endPoint = CGPoint(x: 0.5, y: 1)
        customlayer?.locations = [0.0,0.3]
        
//        customlayer?.colors = UIColor.grayGradualColor2
//        customlayer?.startPoint = CGPoint(x: 0.5, y: 0)
//        customlayer?.endPoint = CGPoint(x: 0.5, y: 1)
//        customlayer?.locations = [0.0,0.2,0.8]
        
        self.layer.insertSublayer(customlayer!, at: 0)
        
    }
    @objc override func touchDown(){
//        print("touchDown")
        setCLickGradual()
        super.touchDown()
        
    }
    @objc override func touchUp(){
        super.touchUp()
        setGaryGradual()
    }
}
class RedCustomUIButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setRedGradualGary()
        self.setClick()
    }
    @objc override func touchDown(){
        super.touchDown()
    }
    @objc override func touchUp(){
        super.touchUp()
    }
}
class AnalysisUIButton : UIButton {
    var customlayer : CAGradientLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setRedGradual(){
        if customlayer != nil {
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }

        customlayer = CAGradientLayer()
        customlayer?.type = .radial
        let d = self.frame.width - self.frame.height
        customlayer?.frame = CGRect(origin: CGPoint(x: self.bounds.origin.x + d / 2 - 5, y: self.bounds.origin.y), size: CGSize(width: self.frame.height + 10 , height: self.frame.height))
//        customlayer?.colors = styleList[currentUIStyleIndex].analysisGradualColors
        customlayer?.startPoint = CGPoint(x: 0.5, y: 0.5)
        customlayer?.endPoint = CGPoint(x: 1, y: 1)
        customlayer?.cornerRadius = self.frame.height / 2
        customlayer?.locations = [0.25 , 1]
        self.layer.insertSublayer(customlayer!, at: 0)
    }
    func clearlayer(){
        if customlayer != nil {
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }
    }
}
class TabUIButton : UIButton {
    var customlayer : CAGradientLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
//        setRedGradual()
    }
    
    func setRedGradual(){
//        print("sublayers\(self.layer.sublayers?.count)")
        if customlayer != nil {
//            print("add")
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }

        customlayer = CAGradientLayer()
        customlayer?.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.frame.width , height: self.frame.height))
//        customlayer?.colors = styleList[currentUIStyleIndex].buttonGradualColors
        customlayer?.startPoint = CGPoint(x: 0.5, y: 0)
        customlayer?.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(customlayer!, at: 0)
    }
    func clearlayer(){
        if customlayer != nil {
            customlayer?.removeFromSuperlayer()
            customlayer = nil
        }
    }
}
extension UIButton {
    func selected(){
        setClick()
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitleColor(UIColor.white, for: .normal)
        self.setImage(UIImage(named: "circularshape"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    func unselected(){
        setClick()
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitleColor(UIColor.lightGrayColor, for: .normal)
        self.setImage(UIImage(named: "empty"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
    func setClick(){
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }
    
    func setGradualGary(){
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.frame.width , height: self.frame.height))
        layer.colors = UIColor.grayGradualColor
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(layer, at: 0)
        
        
    }
    func setRedGradualGary(){
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.frame.width , height: self.frame.height))
        layer.colors = UIColor.redGradualColor
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(layer, at: 0)
    }
    
    
    func setGradualGary(width:CGFloat){
        print(self.bounds.width)
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: width , height: self.frame.height))
        layer.colors = UIColor.grayGradualColor
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(layer, at: 0)
        
    }
    @objc func touchDown(){
//        print("touchDown")
        UIButton.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    @objc func touchUp(){
//        print("touchUp")
        UIButton.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    func removelayer(){
        if let sublayers = self.layer.sublayers {
//            print(sublayers.count)
//            for s in sublayers {
//                s.removeFromSuperlayer()
//            }
        }
    }
}
