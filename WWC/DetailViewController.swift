import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showImageName: UIImageView!
    @IBOutlet weak var showDescription: UITextView!
    
    var tvShowName: String?
    var tvShowImageName: String?
    var tvShowDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup the label, image and textView with content on initial load
        setup()
        
    }
    func setup() {
        showName.text = tvShowName
        showImageName.image = UIImage(named: tvShowImageName!)
        showDescription.text = tvShowDescription
    }
    @IBAction func tappedOK(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
