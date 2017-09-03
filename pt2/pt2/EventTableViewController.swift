//
//  EventTableViewController.swift
//  pt2
//
//  Created by Jin on 9/2/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController,EventDataDelegate{

    var events = [Event]()
    struct Constant {
        static let EventCellIdentifier = "EventCell"
        static let editEventSegueIdentifier = "editEvent"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Event.delegate = self
    }
    
    func eventAdded(event: Event) {
        if events.first(where: { $0 == event}) == nil {
            events.append(event)
        }
        tableView.reloadData()
    }
    
    func eventChanged(event: Event) {
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.EventCellIdentifier, for: indexPath)
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = "date: \(event.dateToString()), price: \(event.price!)"
        if let image = event.image{
            cell.imageView?.image = image
        }
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let event = events[indexPath.row]
            events.remove(at: indexPath.row)
            event.removeFromDataBase()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addEditEvent(from segue:UIStoryboardSegue){
        if let detail = segue.source as? DetailTableViewController{
            if events.first(where: { $0 == detail.event!}) == nil {
                events.append(detail.event!)
            }
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.editEventSegueIdentifier, let detail = segue.destination as? DetailTableViewController,
            let cell = sender as? UITableViewCell{
            var index = tableView.indexPath(for: cell)
            detail.event = events[(index?.row)!]
        }
    }
    

}
