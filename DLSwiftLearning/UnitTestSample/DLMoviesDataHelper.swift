//
//  MoviesDataHelper.swift
//  DLSwiftLearning
//
//  Created by denglong on 19/01/2018.
//  Copyright © 2018 ubtrobot. All rights reserved.
//

import UIKit

class DLMoviesDataHelper: NSObject {
    static func getMovies() -> [UnitMovie] {
        return [
            UnitMovie(title: "The Emoji Movie", genre: .Animation),
            UnitMovie(title: "Logan", genre: .Action),
            UnitMovie(title: "Wonder Woman", genre: .Action),
            UnitMovie(title: "Zootopia", genre: .Animation),
            UnitMovie(title: "The Baby Boss", genre: .Animation),
            UnitMovie(title: "Despicable Me 3", genre: .Animation),
            UnitMovie(title: "Spiderman: Homecoming", genre: .Action),
            UnitMovie(title: "Dunkirk", genre: .Animation)
        ]
    }
}
