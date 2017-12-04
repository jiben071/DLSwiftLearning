//
//  TypeConvertSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  类型转换
// Swift 中类型转换的实现为 is 和 as 操作符。这两个操作符使用了一种简单传神的方式来检查一个值的类型或将某个值转换为另一种类型。

import UIKit

class TypeConvertSample: NSObject {
    func testFunction() {
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // "library" 的类型被推断为[MediaItem]
        
        //1.类型检查
        //使用类型检查操作符 （ is ）来检查一个实例是否属于一个特定的子类。
        var movieCount = 0
        var songCount = 0
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song{
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        
        //2.向下类型转换
        for item in library {
            if let movie = item as? Movie{
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song{
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        
        //3.Any和AnyObject的类型转换
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })//接收 String 值并返回 String 值的闭包表达式
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
                
            case is Double:
                print("some other double value that I don't want to print")
                
            case let someString as String:
                print("a string value of \"\(someString)\"")
                
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
                
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
                
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
                
            default:
                print("Something else")
                
                
            }
        }
        
        
        //Any类型表示了任意类型的值，包括可选类型。如果你给显式声明的Any类型使用可选项，Swift 就会发出警告。如果你真心需要在Any值中使用可选项，如下所示，你可以使用as运算符来显式地转换可选项为Any。
        
        let optionalNumber: Int? = 3
        things.append(optionalNumber) //此处应该会有警告
        things.append(optionalNumber as Any)
        
    }
}

//媒体项目
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
