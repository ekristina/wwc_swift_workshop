import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBAction func editTapped(_ sender: Any) {
        // set the isEditing property to be the opposite of whatever it is already.
        // this allows us to toggle between editing and not editing
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var shows: [Show]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view properties
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // set the original state of the tableview to not be editing
        self.tableView.isEditing = false
 
        
        shows = getFakeData()
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // check to see if editing style is for deleting a row
        if editingStyle == .delete {
            // remove the show from the list
            shows?.remove(at: indexPath.row)
            
            // have the tableView delete the cell
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        /* In this function, we could check conditions on which rows are allowed to
         move, and which rows are not allowed to move. For example, to stop the user from
         moving the first row:
         }
         if indexPath.row == 0 {
         return false
         } else { return true}
         However, we're going to allow movement of all the rows, so we simply return true
         */
        return true
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update your model's reference to the moved object
        
        if let showToMove = shows?[sourceIndexPath.row] {
            shows?.remove(at: sourceIndexPath.row)
            shows?.insert(showToMove, at: destinationIndexPath.row)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        guard let shows = shows else { return 0 }
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let shows = shows else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
//        let tvShow = shows[indexPath.row] as Show
        
        let tvShow = shows[indexPath.row] as Show
        
        let tvShowName = tvShow.artistName
        let imageName = tvShow.imageName
        
        cell.setup(labelName: tvShowName, imageName: imageName)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //check if tv shows exist
        guard let shows = shows else {
            //if tv shows do not exist, deselect the row, don't display pop-up
        self.tableView.deselectRow(at: indexPath, animated: true)
        return
        }
        //find view Controller by its storyboard ID
        let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        //set tv show name, image and description using the selected tv show
        movieDetailVC?.tvShowName = shows[indexPath.row].artistName
        movieDetailVC?.tvShowImageName = shows[indexPath.row].imageName
        movieDetailVC?.tvShowDescription = shows[indexPath.row].longDescription
        
        //deselect row after selection
        self.tableView.deselectRow(at: indexPath, animated: true)
        //presentation style and action
        movieDetailVC?.modalPresentationStyle = .popover
        self.present(movieDetailVC!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Shows"
    }
}

