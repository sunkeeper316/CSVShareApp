
import UIKit
import Foundation

extension UIColor {
    
    //buttonStyleColor
    public static let blueStyleGradualColor : [CGColor] = [UIColor(hex: "#67BA9Fff")!.cgColor,UIColor(hex: "#033994ff")!.cgColor]
    public static let redGradualColor : [CGColor] = [UIColor(hex: "#ff0d23ff")!.cgColor,UIColor(hex: "#231815ff")!.cgColor]
    
    //AnalysisButton
    public static let redAnalysisGradualColor : [CGColor] = [UIColor(hex: "#ff0d23ff")!.cgColor,UIColor(hex: "#23181500")!.cgColor]
    public static let blueAnalysisGradualColor : [CGColor] = [UIColor(hex: "#67BA9Fff")!.cgColor,UIColor(hex: "#03399400")!.cgColor]
    
    
    public static let blackColor = UIColor(hex: "#383636ff")!
    public static let darkGrayColor = UIColor(hex: "#444344FF")!
    public static let blueGradualColor : [CGColor] = [UIColor(hex: "#003595ff")!.cgColor,UIColor(hex: "#00c1deff")!.cgColor]
    public static let grayGradualColor : [CGColor] = [UIColor(hex: "#b3b3b4ff")!.cgColor,UIColor(hex: "#595757ff")!.cgColor]
    public static let grayGradualColor2 : [CGColor] = [UIColor(hex: "#b3b3b4ff")!.cgColor,UIColor(hex: "#595757ff")!.cgColor,UIColor(hex: "#b3b3b4ff")!.cgColor]
    
    
    public static let lightGrayColor = UIColor(hex: "#9fa0a0ff")! //word
    public static let backColor = UIColor(hex: "#555455FF")! //word
        
    public static let grayColor = UIColor(hex: "#4c4b4cff")!
    
    public static let greenColor = UIColor(hex: "#00c08bff")!
    public static let orangeColor = UIColor(hex: "#e68f12ff")!
    public static let blueColor = UIColor(hex: "#808fbdff")!
    
    public static let highColor = UIColor(hex: "#dc2527ff")!
    public static let normalColor = UIColor(hex: "#00c08bff")!
    public static let lowColor = UIColor(hex: "#00c1deff")!
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
//                    print("r\(CGFloat((hexNumber & 0xff000000) >> 24))")
//                    print("g\(CGFloat((hexNumber & 0x00ff0000) >> 16))")
//                    print("b\(CGFloat((hexNumber & 0x0000ff00) >> 8))")
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format:"#%06x", rgb)
        }
}
