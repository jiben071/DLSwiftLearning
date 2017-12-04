//
//  OptionChainSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 27/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class OptionChainSample: NSObject {
    func testFunction() {
        //1.可选链代替强制展开
        let john = Person3()
        //触发运行时错误  因为没有john.residence可以给强制展开
        let roomCount = john.residence!.numberOfRooms
        
        //可选链的操作方式
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        }else{
            print("Unable to retrieve the number of rooms.")
        }
        
        //2.为可选链定义模型类
        
        //3.通过可选链访问属性
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street =  "Acacia Road"
        john.residence?.address = createAddress()
        
        //4.通过可选链调用方法
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        
        //5.通过可选链访问下标
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        
        //6.访问可选类型的下标
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        
        testScores["Dave"]?[0] = 91
        

    }
    
    func createAddress() -> Address {
        print("Function was called.")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }
}


class Person3 {
    var residence: Residence2?
}

class Residence {
    var numberOfRooms = 1
    var address: Address?
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}



//2.为可选链定义模型类

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get{
            return rooms[i]
        }
        set{
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil{
            return buildingName;
        } else if buildingNumber != nil && street != nil {
            return "\(String(describing: buildingNumber)) \(String(describing: street))"
        }else {
            return nil
        }
    }
}


