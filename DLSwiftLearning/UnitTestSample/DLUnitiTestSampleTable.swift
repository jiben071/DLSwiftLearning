//
//  DLUnitiTestSampleTable.swift
//  DLSwiftLearning
//
//  Created by denglong on 25/01/2018.
//  Copyright © 2018 ubtrobot. All rights reserved.
//

import UIKit

class DLUnitiTestSampleTable: UITableViewController {

    var dataSource: [Minion]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMinions()
    }
    
    func fetchMinions(minionService: MinionService = MinionService()) {
        minionService.getTheMinions { [unowned self](minionDataResult) -> Void in
            switch (minionDataResult) {
            case .Success(let minionsData):
                self.dataSource = minionsData
                self.tableView.reloadData()
            case .Failure(let error):
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "minionCell") as! UITableViewCell
        
        if let minion = dataSource?[indexPath.row] {
            cell.textLabel?.text = minion.name
            cell.imageView?.image = UIImage(named: minion.name)
        }
        
        return cell
    }

}
