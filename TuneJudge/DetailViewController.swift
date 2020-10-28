//
//  DetailViewController.swift
//  TuneJudge
//
//  Created by Jandir Porta on 10/27/20.
//  Copyright © 2020 Jandir Porta. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate{
    //referencing the textFields
    @IBOutlet var songNameField: UITextField!
    @IBOutlet var authorNameField: UITextField!
    @IBOutlet var reviewField: UITextField!
    //referencing the labels
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var recommendedLabel: UILabel!
    //referencing the stepper to change the value
    @IBOutlet var stepperOutlet: UIStepper!
    //referencing the "like" and "dislike" buttons
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dislikeButton: UIButton!
    
    
    var item : Item!{
        didSet{
            navigationItem.title =
            "\(item.author)-\(item.songName)"
        }
    }
    
    var rating : Int?
    
    var recommended : Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        songNameField.text = item.songName
        authorNameField.text = item.author
        ratingLabel.text = String(item.rating)
        if item.recommended {
            recommendedLabel.text = "Recommended"
        }
        else{
            recommendedLabel.text = "Not Recommended"
        }
        reviewField.text = item.review
        stepperOutlet.value = Double(item.rating)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        //Saving the changes to item
        item.songName = songNameField.text ?? ""
        item.author = authorNameField.text ?? ""
        if (rating != nil){
            item.rating = rating ?? 0
        }
        
        if (recommended != nil){
            item.recommended = recommended ?? false
        }
        
        item.review = reviewField.text ?? ""
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //action to when the stepper value changes
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        ratingLabel.text = String(format: "%.0f", sender.value)
        rating = Int(sender.value)
        
    }
    
    //Action for when either of the buttons are pressed
    
    @IBAction func recommendedButtonPressed(_ sender: UIButton) {
        if sender == likeButton{
            recommended = true
            recommendedLabel.text = "Recommended"
        }
        else{
            recommended = false
            recommendedLabel.text = "Not Recommended"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
