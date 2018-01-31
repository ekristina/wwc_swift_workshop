
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    func setup(labelName: String?, imageName: String?) {
        self.label.text = labelName
        
        guard let iconName = imageName else {return}
        
        self.cellImageView.image = UIImage(named: iconName)
    }
}
