//
//  ExtensionSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  扩展
//  跟OC的分类类似，区别在于扩展没有名字

/*
 Swift 中的扩展可以：
 
 添加计算实例属性和计算类型属性；
 定义实例方法和类型方法；
 提供新初始化器；
 定义下标；
 定义和使用新内嵌类型；
 使现有的类型遵循某协议
 */

import UIKit

class ExtensionSample: NSObject {
    func testFunction() {
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        
        //2.初始化器
        let centerRect = Rect4(center: Point4(x: 4.0, y: 4.0),
                              size: Size4(width: 3.0, height: 3.0))
        
        //3.方法
        3.repetitions {
            print("Hello!")
        }
        
        //3.异变实例方法
        var someInt = 3
        someInt.square()//9
    }
}

//1.计算属性
extension Double {
    var km: Double {
        return self * 1_000.0
    }
    
    var m: Double {
        return self
    }
    
    var cm: Double {
        return self / 100.0
    }
    
    var mm: Double {
        return self / 1_000.0
    }
    
    var ft: Double {
        return self / 3.28084
    }
}

//2.初始化器
struct Size4 {
    var width = 0.0, height = 0.0
}
struct Point4 {
    var x = 0.0, y = 0.0
}
struct Rect4 {
    var origin = Point4()
    var size = Size4()
}

//扩展 Rect 结构体以额外提供一个接收特定原点和大小的初始化器：
extension Rect4 {
    init(center: Point4, size: Size4) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point4(x: originX, y: originY), size: size)
    }
}

//3.方法
extension Int {
    //epetitions(task:) 方法接收一个 () -> Void 类型的单一实际参数，它表示一个没有参数且无返回值的函数。
    func repetitions(task: () -> Void) -> Void {
        for _ in 0..<self {
            task()
        }
    }
}

//4.异变实例方法
extension Int{
    //结构体和枚举类型方法在修改 self 或本身的属性时必须标记实例方法为 mutating
    mutating func square() {
        self = self * self
    }
}

//5.下标
/*
 扩展能为已有的类型添加新的下标。下面的例子为 Swift 内建的 Int 类型添加了一个整型下标。这个下标 [n] 返回了从右开始第 n 位的十进制数字：
 
 123456789[0] 返回 9
 123456789[1] 返回 8
 */

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
