
import Foundation
import UIKit

class CustomUILabel : UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = true
    }
    override func reloadInputViews() {
        
    }
    
}
