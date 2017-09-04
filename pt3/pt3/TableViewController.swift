//
//  TableViewController.swift
//  pt3
//
//  Created by Jin on 9/3/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    struct Constant {
        static let CellIdentifier = "tempCell"
    }
    @IBOutlet weak var searchField: UITextField!{
        didSet{
            searchField.placeholder = "\u{2315}" + " Search messages"
            let border = CALayer()
            let width = CGFloat(0.3)
            border.borderColor = UIColor.gray.cgColor
            border.frame = CGRect(x: 0, y: searchField.frame.size.height - width, width:  searchField.frame.size.width, height: searchField.frame.size.height)
            
            border.borderWidth = width
            searchField.layer.addSublayer(border)
            searchField.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        let button = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "more")))
    
        navigationItem.leftBarButtonItem = button
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier, for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = "hello"
        cell.detailLabel?.text = String.randomString()
        cell.iconImage?.image = UIImage(named: "image")?.circleMask
        cell.timeLabel.text = Date(timeIntervalSinceNow: 0).toString()
    
        return cell
    }

}

extension String{
    static func randomString() -> String{
        let mask = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let arr = Array(mask.characters)
        var result = ""
        for _ in 0 ..< (arc4random() % 50){
            result += String(arr[(Int)(arc4random() % (UInt32)(mask.characters.count))])
        }
        return result
    }
}

extension Date{
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
