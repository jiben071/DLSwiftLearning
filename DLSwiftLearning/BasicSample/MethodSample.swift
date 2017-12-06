//
//  MethodSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 21/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

/*
 事实上在 结构体和枚举中定义方法是 Swift 语言与 C 语言和 Objective-C 的主要区别。在 Objective-C 中，类是唯一能定义方法的类型。但是在 Swift ，你可以选择无论类，结构体还是方法，它们都拥有强大的灵活性来在你创建的类型中定义方法
 */
class MethodSample: NSObject {
    func test() {
        //1.实例方法
        let counter = Counter()
        counter.increment()
        counter.increment(by: 5)
        counter.reset()
        
        //2.self 属性
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOf(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        
        //3.在实例方法中修改值类型
        var somePoint2 = Point(x: 1.0, y: 1.0)
        somePoint2.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        
        //注意，如同 常量结构体实例的存储属性 里描述的那样，你不能在常量结构体类型里调用异变方法，因为自身属性不能被改变，就算它们是变量属性：
        let fixedPoint = Point(x: 3.0, y: 3.0)
//        fixedPoint.moveBy(x: 2.0, y: 3.0)
        
        //4.1 枚举的异变方法可以设置隐含的 self属性为相同枚举里的不同成员：
        var overLight = TriStateSwith.low
        overLight.next() // ovenLight is now equal to .high
        overLight.next() // ovenLight is now equal to .off
        
        //5.类型方法
        var player = Player(name: "Argyrios")
        player.completedLevel(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // Prints "highest unlocked level is now 2"
        
        //如果你创建了第二个玩家，当你让他尝试进入尚未被任何玩家在游戏中解锁的等级时， 设置玩家当前等级的尝试将会失败：
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
    }
}

//1.实例方法
class Counter {
    var count = 0
    func increment() {
//        count += 1
        //2.self属性
        self.count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

//2.self属性
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x  //区分形式参数与属性
    }
    
    //3.在实例方法中修改值类型
    //总之，如果你需要在特定的方法中修改结构体或者枚举的属性，你可以选择将这个方法异变。
    mutating func moveBy(x deltaX: Double, y deltaY: Double){
//        x += deltaX
//        y += deltaY
        
        //4.在异变方法里指定自身
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

//4.在异变方法里指定自身
//枚举的异变方法可以设置隐含的 self属性为相同枚举里的不同成员：
enum TriStateSwith {
    case off, low, high
    mutating func next(){
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

//5.类型方法
/*
 当游戏第一次开始的时候所有的的游戏等级（除了第一级）都是锁定的。每当一个玩家完成一个等级，那这个等级就对设备上的所有玩家解锁。 LevelTracker结构体使用类型属性和方法来追踪解锁的游戏等级。它同样追踪每一个独立玩家的当前等级。
 */
struct LevelTracker {//LevelTracker结构体持续追踪任意玩家解锁的最高等级。
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    //解锁玩家等级
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult  //表示可以忽略 advance(to:) 的返回值
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else{
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int){
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}





