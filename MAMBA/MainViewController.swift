//
//  MainViewController.swift
//  MAMBA
//
//  Created by Navdeep on 21/07/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainPageHeader: UIView!
    @IBOutlet var mainPageTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MamBA"
        let header = mainPageHeader
        mainPageTable.tableHeaderView = header
        
    }
    

}
