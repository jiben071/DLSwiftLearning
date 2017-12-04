//
//  ClassAndStruct.swift
//  DLSwiftLearning
//
//  Created by denglong on 14/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  类和结构体示例

/*
 类与结构体的对比
 
 在 Swift 中类和结构体有很多共同之处，它们都能：
 
 定义属性用来存储值；
 定义方法用于提供功能；
 定义下标脚本用来允许使用下标语法访问值；
 定义初始化器用于初始化状态；
 可以被扩展来默认所没有的功能；
 遵循协议来针对特定类型提供标准功能。
 
 类有而结构体没有的额外功能：
 
 继承允许一个类继承另一个类的特征;
 类型转换允许你在运行检查和解释一个类实例的类型；
 反初始化器允许一个类实例释放任何其所被分配的资源；
 引用计数允许不止一个对类实例的引用。
 */

import UIKit

class ClassAndStruct: NSObject {
    func instantiationSample() {
        //2.类与结构体实例
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        //3.访问属性
        print("The width of someResolution is \(someResolution.width)")
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        
        //你亦可以用点语法来指定一个新值到一个变量属性中：
        someVideoMode.resolution.width = 1280
        
        //4.结构体类型的成员初始化器
        let vga = Resolution(width: 640, height: 480)
        
        //5.结构体和枚举h是值类型
        //值类型是一种当它被指定到常量或者变量，或者被传递给函数时会被拷贝的类型。
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd  //尽管 hd和 cinema有相同的像素宽和像素高，但是在后台中他们是两个完全不同的实例。
        
        //枚举也是值类型
        enum CompassPoint {
            case North, South, East, West
        }
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection //当 rememberedDirection被赋予了 currentDirection中的值，实际上是值的拷贝。
        currentDirection = .East
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
        
        
        //6.类是引用类型
        //不同于值类型，在引用类型被赋值到一个常量，变量或者本身被传递到一个函数的时候它是不会被拷贝的。相对于拷贝，这里使用的是同一个对现存实例的引用。
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        //7. 特征运算符
        //相同于 ( ===)
        //不相同于( !==)
        //利用这两个恒等运算符来检查两个常量或者变量是否引用相同的实例：
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
        
        /*
         “相同于”意味着两个类类型常量或者变量引用自相同的实例；
         “等于”意味着两个实例的在值上被视作“相等”或者“等价”，某种意义上的“相等”，就如同类设计者定义的那样。
         */
        
        //8.指针
        /*
         如果你有过 C，C++ 或者 Objective-C 的经验，你可能知道这些语言使用可指针来引用内存中的地址。一个 Swift 的常量或者变量指向某个实例的引用类型和 C 中的指针类似，但是这并不是直接指向内存地址的指针，也不需要你书写星号( *)来明确你建立了一个引用。相反，这些引用被定义得就像 Swift 中其他常量或者变量一样。
         */
        
        //9.类和机构体之间的选择
        //结构体实例总是通过值来传递，而类实例总是通过引用来传递。
        /*
         按照通用准则，当符合以下一条或多条情形时应考虑创建一个结构体：
         
         结构体的主要目的是为了封装一些相关的简单数据值；
         当你在赋予或者传递结构实例时，有理由需要封装的数据值被拷贝而不是引用；
         任何存储在结构体中的属性是值类型，也将被拷贝而不是被引用；
         结构体不需要从一个已存在类型继承属性或者行为。
         
         合适的结构体候选者包括：
         
         几何形状的大小，可能封装了一个 width属性和 height属性，两者都为 double类型；
         一定范围的路径，可能封装了一个 start属性和 length属性，两者为 Int类型；
         三维坐标系的一个点，可能封装了 x , y 和 z属性，他们都是 double类型。
         */
        
        
        //10.字符串，数组和字典的赋值与拷贝行为
        /*
         Swift 的 String , Array 和 Dictionary类型是作为结构体来实现的，这意味着字符串，数组和字典在它们被赋值到一个新的常量或者变量，亦或者它们本身被传递到一个函数或方法中的时候，其实是传递了拷贝。
         
         这种行为不同于基础库中的 NSString, NSArray和 NSDictionary，它们是作为类来实现的，而不是结构体。 NSString , NSArray 和 NSDictionary实例总是作为一个已存在实例的引用而不是拷贝来赋值和传递。
         */
        
        
    }
}

//1.定义语法
struct Resolution {//用来描述一个基于像素的显示器分辨率
    var width = 0
    var height = 0
}

class VideoMode {//用来描述一个视频显示的特定视频模式
    var resolution = Resolution()//分辨率
    var interlaced = false //非隔行扫描视频
    var frameRate = 0.0 //回放帧率
    var name: String?
}
