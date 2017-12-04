//
//  InternalStorageSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 02/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class InternalStorageSample: NSObject {

    //1.输入输出形式参数的访问冲突
    var stepSize = 1 //全局变量
    func incretment(_ number: inout Int) {
        number += stepSize  //导致了stopSize同时被读写，造成了内存冲突
    }
    
    //1.1 输入输出形式参数的长时写入访问的另一个后果是传入一个单独的变量作为实际形式参数给同一个函数的多个输入输出形式参数产生冲突。
    func balance(_ x: inout Int, _ y: inout Int) {
        let sum = x + y
        x = sum / 2
        y = sum - x  //如果x 与 y是同一个变量，就会导致访问同一份内存，导致内存泄露
    }
    
    func testFunction() {
        //1.输入输出形式参数的访问冲突
        incretment(&stepSize) //导致stepSize 的读取访问与 number 的写入访问重叠了
        
        //解决这种冲突的办法
        //显式地做一个stepSize的拷贝：  其实就是复制一份内存，避免同时访问同一块内存
        var copyOfStepSize = stepSize
        incretment(&copyOfStepSize)
        
        //Update the original
        stepSize = copyOfStepSize
        
        //1.1 输入输出形式参数的长时写入访问的另一个后果是传入一个单独的变量作为实际形式参数给同一个函数的多个输入输出形式参数产生冲突。
        
        var playerOneScore = 42
        var playerTwoScore = 30
//        balance(&playerOneScore, &playerOneScore)  //导致内存泄露
        balance(&playerOneScore, &playerTwoScore)  //OK
        
    }
}

//2.在方法中对self的访问冲突
//结构体中的异变方法可以在方法调用时对 self 进行写入访问。比如说想象一个每个玩家都有生命值的游戏，当玩家受伤时降低生命值，以及一个能量值，它在使用技能时降低

struct Player2 {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth(){
        health = Player2.maxHealth  //此方法没有内存泄露
    }
    
    mutating func balance(_ x: inout Int, _ y: inout Int ){
        let sum = x + y
        x = sum / 2
        y = sum - x  //如果x 与 y是同一个变量，就会导致访问同一份内存，导致内存泄露
    }
}

extension Player2 {
    mutating func shareHealth(with teammate: inout Player2) {
//        self.balance(&teammate.health, &health)
    }
}

//3.属性的访问冲突
//对元组的元素进行重叠写入访问就会产生冲突：
/*
 var playerInformation = (health: 10, energy: 20)
 balance(&playerInformation.health, &playerInformation.energy)
 */

//对全局变量结构体属性的重叠写入访问
/*
 var holly = Player(name: "Holly", health: 10, energy: 10)
 balance(&holly.health, &holly.energy)  // Error
 */

/*
 具体来说，如果下面的条件可以满足就说明重叠访问结构体的属性是安全的：
 
 你只访问实例的存储属性，不是计算属性或者类属性；
 结构体是局部变量而非全局变量；
 结构体要么没有被闭包捕获要么只被非逃逸闭包捕获。
 如果编译器不能保证访问是安全的，它就不允许访问。
 */
