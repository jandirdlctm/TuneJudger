//
//  Item.swift
//  TuneJudge
//
//  Created by Jandir Porta on 10/19/20.
//  Copyright © 2020 Jandir Porta. All rights reserved.
//

import UIKit

class Item : Equatable, Codable {
    var songName : String
    var author : String
    var rating : Int
    var review : String
    var recommended : Bool
    
    init(songName : String, author : String, rating : Int, review : String, recommended : Bool) {
        self.songName = songName
        self.author = author
        self.rating = rating
        self.review = review
        self.recommended = recommended
    }
    
    convenience init(random : Bool = false) {
        if random {
            let songs : [String] = ["Corazon de Seda", "Mia", "La Nota", "Sandra's Rose", "Morado"]
            let authors : [String] = ["J. Balvin","Bad Bunny", "Drake", "Manuel Turizo", "Farruko", "Ozuna"]
            let ratings : [Int] =  [0,1,2,3,4,5,6,7,8,9,10]
            let reviews : [String] = ["I liked it", "Its not very good", "It is alright", "Not very good"]
            let recommended : [Bool] = [true,false]
            
            let randomSong = songs.randomElement()!
            let randomAuthor = authors.randomElement()!
            let randomRating = ratings.randomElement()!
            let randomReview = reviews.randomElement()!
            let randomRecommended = recommended.randomElement()!
            
            self.init(songName: randomSong, author : randomAuthor, rating: randomRating, review : randomReview, recommended : randomRecommended)
        }
        else{
            self.init(songName : "", author: "", rating : 0, review : "", recommended : false)
        }
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool{
        return lhs.songName == rhs.songName
            && lhs.author == rhs.author
            && lhs.rating == rhs.rating
            && lhs.review == rhs.review
            && lhs.recommended == rhs.recommended
    }
}
