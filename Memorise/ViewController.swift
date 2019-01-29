//
//  ViewController.swift
//  Memorise
//
//  Created by Dan Korkelia on 29/01/2019.
//  Copyright © 2019 Dan Korkelia. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }
    
    // Left inside VC as it is delegate and usually delegate is part of user interaction!!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Unable to instatatioate Memory View Controller")
        }
        
//        let item = dataSource.items[indexPath.row] // Disgusting way to do it
        let item = dataSource.item(at: indexPath.row)
        vc.item = item
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
