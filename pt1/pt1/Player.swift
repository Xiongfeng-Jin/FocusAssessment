//
//  Player.swift
//  pt1
//
//  Created by Jin on 9/1/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import Foundation

class Player: NSObject {
    init(name: String, Country country:String, Height height:Double,
         Weight weight:Double,Age age:Int) {
        self.name = name
        self.country = country
        self.height = height
        self.weight = weight
        self.age = age
    }
    
    init(player: Player) {
        self.name = player.name
        self.country = player.country
        self.height = player.height
        self.weight = player.weight
        self.age = player.age
    }
    
    static func getCountryAt(Index index:Int) -> String{
        return countries[index]
    }
    
    static func indexFor(Country c:String) -> Int{
        return countries.index(of: c) ?? 0
    }
    
    var name:String
    var country:String
    var height:Double
    var weight:Double
    var age:Int
    
    private static var countries = ["France","Germany","USA","Spain","Australia"]
    override var description:String {
        return "name: \(name), country: \(country), height: \(height), weight: \(weight), age: \(age)"
    }
}
