//
//  InheritSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 22/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class InheritSample: NSObject {
    func test() {
        //1.定一个基类
        let someVehicle = Vehicle()
    
        //2.子类
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        
        //3.重写
        let train = Train()
        train.makeNoise()
        
        //3.1重写属性的GETTER和SETTER
        let car = Car()
        
        car.currentSpeed = 25.0
        
        car.gear = 3
        
        print("Car: \(car.description)")
        
        //3.2 重写属性观察器
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        
        //4.阻止重写
        /*
         你可以通过标记为终点来阻止一个方法、属性或者下标脚本被重写。通过在方法、属性或者下标脚本的关键字前写 final 修饰符(比如 final var ， final func ， final class func ， fianl subscript )。
         
         你可以通过在类定义中在 class 关键字前面写 final 修饰符( final class )标记一整个类为终点。任何想要从终点类创建子类的行为都会被报告一个编译时错误。
         */
    }
}


//1.定义一个基类
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

//2.子类
class Bicycle: Vehicle {
    var hasBasket = false
    func test() {
        print(super.currentSpeed)  //使用super访问父类的方法
    }
}

//3.重写
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

//3.1重写属性的GETTER和SETTER
class Car: Vehicle {
    var gear = 1
    override var description: String{
        return super.description + " in gear \(gear)"
    }
}

//3.2 重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double{
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
