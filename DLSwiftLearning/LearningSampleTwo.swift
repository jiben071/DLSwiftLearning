//
//  LearningSampleTwo.swift
//  DLSwiftLearning
//
//  Created by denglong on 08/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

//枚舉語法
enum SomeEnumeration{
    
}

enum CompassPoint: String {
    case north //隱式字符串
    case south
    case east
    case west
}

//隱式指定的原始值
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//關聯值
enum Barcode {
    case upc(Int,Int,Int,Int) //條形碼
    case qrCode(String) //二維碼
}

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//遞歸枚舉
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression,ArithmeticExpression)
    case multiplication(ArithmeticExpression,ArithmeticExpression)
}


class LearningSampleTwo: NSObject {
    //枚舉
    func enumeration(){
        //1.枚舉語法
        var directionToHead = CompassPoint.west
        //可以被推導出來
        directionToHead = .east
        
        //2.使用Switch語句來匹配枚舉值
        directionToHead = .south
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        
        //要麼全部列舉  要麼放個default
        let somePlanet = Planet.earth
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
        
        
        //2.關聯值
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCSDFSFSFSSD")
        
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode)")
        }
        
        //簡化類型
        switch productBarcode {
        case let .upc( numberSystem,  manufacturer,  product,  check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode( productCode):
            print("QR code: \(productCode)")
        }
        
        //3.原始值
        let asciiChara = ASCIIControlCharacter.lineFeed
        
        //4.隱式指定的原始值
        let planet = Planet.venus
        
        //防偽原始值
        let earthsOrder = Planet.earth.rawValue
        
        //5.從原始值初始化
        let possiblePlanet = Planet(rawValue: 7)
        
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind){
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        }else{
            print("There isn't a planet at position \(positionToFind)")
        }
        
        //6.遞歸枚舉  recursion
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        print(evaluate(product))
    }
    
    
    
    
    //遞歸枚舉的具體計算方法
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left,right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
}
