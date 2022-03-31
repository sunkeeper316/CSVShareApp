
import UIKit

class MeasuredPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var lbIdCode: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLastdate: UILabel!
    @IBOutlet weak var lbPosture: UILabel!
    
    @IBOutlet weak var viewPosture: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
