//
//  PlayerTableViewController.swift
//  pt1
//
//  Created by Jin on 9/1/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController {
    var playerList = [Player]()

    struct Constant {
        static let PlayerCellIdentifier:String = "PlayerCell"
        static let AddPlayerSegueIdentifier = "addPlayer"
        static let editPlayerSegueIdentifier = "editPlayer"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playerList.count
    }
    
    @IBAction func addEditPlayer(from segue:UIStoryboardSegue){
        if let detail = segue.source as? DetailTableViewController, let player = detail.player{
            if playerList.index(of: player) == nil {
                playerList.append(player)
            }
            tableView.reloadData()
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.PlayerCellIdentifier, for: indexPath)
        cell.textLabel?.text = playerList[indexPath.row].name
        cell.detailTextLabel?.text = String(playerList[indexPath.row].age)
        cell.imageView?.image = UIImage(named: playerList[indexPath.row].country)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            playerList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.editPlayerSegueIdentifier, let detail = segue.destination as? DetailTableViewController, let cell = sender as? UITableViewCell{
            detail.player = playerList[(tableView.indexPath(for: cell)?.row)!]
        }
    }
    

}
