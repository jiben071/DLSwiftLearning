//
//  PropertySample.swift
//  DLSwiftLearning
//
//  Created by denglong on 14/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class PropertySample: NSObject {
    func saveProperty() {
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // the range represents integer values 0, 1, and 2
        rangeOfThreeItems.firstValue = 6
        // the range now represents integer values 6, 7, and 8
        
        
        //2.常量结构体实例的存储属性
        /*
         如果你创建了一个结构体的实例并且把这个实例赋给常量，你不能修改这个实例的属性，即使是声明为变量的属性：
         */
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // this range represents integer values 0, 1, 2, and 3
//        rangeOfFourItems.firstValue = 6  //示例这是错误的写法
        // this will report an error, even though firstValue is a variable property
        
        //3.延迟存储属性
        //延迟存储属性的初始值在其第一次使用时才进行计算。你可以通过在其声明前标注 lazy 修饰语来表示一个延迟存储属性。
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        print(manager.importer.fileName) //到这里才初始化importer
        
        
        //4.计算属性
        struct Point{
            var x = 0.0, y = 0.0
        }
        struct Size{
            var width = 0.0, height = 0.0
        }
        struct Rect{
            var origin = Point()
            var size = Size()
            var center: Point{
                get{
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX,y: centerY)
                }
                set(newCenter){
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
        
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        //5.简写设置器（setter）声明
        struct AlternativeRect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set {//如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么他将被默认命名为 newValue 。
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        
        
        //6.只读计算属性
        //你可以通过去掉 get 关键字和他的大扩号来简化只读计算属性的声明：
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            var volume: Double{
                return width * height * depth
            }
        }
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        
        //9.查询和设置类型属性
        print(SomeStructure.storedTypeProperty)
        // prints "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // prints "Another value."
        print(SomeEnumeration2.computedTypeProperty)
        // prints "6"
        print(SomeClass2.computedTypeProperty)
        // prints "27"
        
        
        //10.数字音频信道音频测量表
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
        
    }
}

//1.存储属性
struct FixedLengthRange {//它描述了一个一旦被创建长度就不能改变的整型值域：
    var firstValue: Int
    let length: Int
}

class DataImporter {
    
    //DataImporter is a class to import data from an external file.
    //The class is assumed to take a non-trivial amount of time to initialize.
    
    var fileName = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    //延迟存储属性
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

//7.属性观察者
//willSet 会在该值被存储之前被调用。
//didSet 会在一个新值被存储后被调用。
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

//8.类型属性
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int{
        return 1
    }
}

enum SomeEnumeration2 {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int{
        return 6
    }
}

class SomeClass2 {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    //使用 class 关键字来允许子类重写父类的实现
    class var overrideComputedTypeProperty: Int{
        return 107
    }
}


struct AudioChannel {
    static let thresholdLevel = 10  //最大限度电平
    static var maxInputLevelForAllChannels = 0  //保持追踪任意AudioChannel实例接收到的最大输入值
    var currentLevel: Int = 0{
        didSet {//属性变化监测
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}


