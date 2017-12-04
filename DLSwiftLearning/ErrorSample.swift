//
//  ErrorSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 27/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

enum VendingMachineError:Error {
    case invaliSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)  // 抛错

class ErrorSample: NSObject {
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
        ]
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)  //用try继续传递错误
    }
    
    func testFunction() {
        //2.使用Do-Catch处理错误
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        } catch VendingMachineError.invaliSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock{
             print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded){
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch{
            print(error.localizedDescription)
        }
    }
}


//1.使用抛出函数传递错误
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invaliSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
        
    }
    

}

//3.转换错误为可选项
/*
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {return data}
    if let data = try? fetchDataFromServer() { return data }
    return nil;
}
 */

//4.取消错误传递
//let photo = try! loadImage("./Resources/John Appleseed.jpg")

//5.指定清理操作
//使用 defer语句来在代码离开当前代码块前执行语句合集。这个语句允许你在以任何方式离开当前代码块前执行必须要的清理工作——无论是因为抛出了错误还是因为 return或者 break这样的语句。比如，你可以使用 defer语句来保证文件描述符都关闭并且手动指定的内存到被释放。
/*
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
 */

