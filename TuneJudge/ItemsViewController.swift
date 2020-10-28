//
//  ItemsViewController.swift
//  TuneJudge
//
//  Created by Jandir Porta on 10/19/20.
//  Copyright © 2020 Jandir Porta. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    var itemStore : ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 240
        tableView.rowHeight = 240
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        
        //Figure out where that item in in the array
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            //insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command...
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            //remove the item from the store
            itemStore.removeItem(item)
            
            //also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int{
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //Set the text on the cell with the description of the song item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let item = itemStore.allItems[indexPath.row]
        
        //configure the cell with the item
        
        cell.songNameLabel.text = item.songName
        cell.authorNameLabel.text = item.author
        cell.ratingLabel.text = "\(item.rating)"
        cell.reviewLabel.text = item.review
        if item.recommended == true{
            cell.recommendedImage.image = UIImage(systemName: "hand.thumbsup.fill")
        }
        else{
            cell.recommendedImage.image = UIImage(systemName: "hand.thumbsdown.fill")
        }
        
        //let thumbs_up = UIImage(systemName: "hand.thumbsup.fill")
        //cell.imageView?.image = thumbs_up
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if the "showItem" identifier is triggered
        switch segue.identifier {
        case "showItem":
            //figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}
