import Foundation
import CoreData
import UIKit

class DataBaseHelper {
    
    static var sharedInstance = DataBaseHelper() // We have made shared Instance
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(object: [String: String]) { // We have made a dictionary here
        
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
        task.task = object["task"]
        task.category = object["category"]
        task.importance = object["importance"]
        task.deadline = object["deadline"]
        do {
            try context.save()
        } catch {
            print("data is not saved")
        }
    }
    
    func get() -> [Task] {
        var tasks = [Task]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        do {
            tasks = try context.fetch(fetchRequest) as! [Task]
        } catch {
            print("cannot return data")
        }
        return tasks
    }
    
    func delete(index: Int) -> [Task] {
        var tasks = get()
        context.delete(tasks[index])
        tasks.remove(at: index)
        do {
            try context.save()
        } catch {
            print("Cannot delete data")
        }
        return tasks
    }
    
    func editData(object: [String: String], i: Int) {
        let tasks = get()
        tasks[i].task = object["task"]
        tasks[i].category = object["category"]
        tasks[i].importance = object["importance"]
        tasks[i].deadline = object["deadline"]
        do {
            try context.save()
        } catch {
            print("data is not saved")
        }
    }
}
