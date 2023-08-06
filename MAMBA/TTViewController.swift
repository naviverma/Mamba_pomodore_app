import UIKit

class TTViewController: UIViewController, DataPass {
    func data(object: [String: String], index: Int, isEdit: Bool) {
        task.text = object["task"]
        category.text = object["category"]
        importance.text = object["importance"]
        deadline.text = object["deadline"]
        i = index
        isUpdate = isEdit
    }
    
    @IBOutlet var deadline: UITextField!
    @IBOutlet var importance: UITextField!
    @IBOutlet var category: UITextField!
    @IBOutlet var task: UITextField!
    var i = Int ()
    var isUpdate:Bool = false
    
    @IBAction func listshow(_ sender: Any) {
        performSegue(withIdentifier: "savetoprofile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savetoprofile",
           let dataViewController = segue.destination as? DataViewController {
            dataViewController.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task Entry"
        
    }

    @IBAction func save(_ sender: Any) {
        let dict = ["task":task.text ?? "N/A","category":category.text ?? "N/A","importance":importance.text ?? "N/A","deadline":deadline.text ?? "N/A"]
        let alert = UIAlertController(title: "Caution", message: "Your data is saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
        if isUpdate{
            DataBaseHelper.sharedIntance.editData(object: dict, i: self.i)
            isUpdate = false
        } else {
            DataBaseHelper.sharedIntance.save(object: dict)
        }
    }
}
