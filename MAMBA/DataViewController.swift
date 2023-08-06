import UIKit

protocol DataPass {
    func data(object: [String: String], index: Int, isEdit: Bool)
}

class DataViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var dataTable: UITableView!
    
    var tasks = [Task]()
    var delegate: DataPass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTable.dataSource = self
        dataTable.delegate = self
        tasks = DataBaseHelper.sharedInstance.get()
        self.title = "Tasks"
    }
}

extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.task = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks = DataBaseHelper.sharedInstance.delete(index: indexPath.row)
            self.dataTable.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ["task": tasks[indexPath.row].task ?? "N/A",
                    "category": tasks[indexPath.row].category ?? "N/A",
                    "importance": tasks[indexPath.row].importance ?? "N/A",
                    "deadline": tasks[indexPath.row].deadline ?? "N/A"]
        self.delegate.data(object: dict, index: indexPath.row, isEdit: true)
        let alert = UIAlertController(title: "Caution", message: "Do u want to edit your data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            //do Nothing
        }))
        present(alert, animated: true)
    }
}
