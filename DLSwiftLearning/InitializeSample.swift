//
//  InitializeSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 22/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class InitializeSample: NSObject {
    func test() {
        //1.初始化器
        var f = Fahrenherit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        
        //2.自定义初始化
        let boilingPointOfWater = Celsius(fromFahreheit: 33.0)
        // boilingPointOfWater.temperatureInCelsius is 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius is 0.0
        
        
        //3.形式参数名和实际参数标签
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halGray = Color(white: 0.5)
        
        //4.无实际参数标签
        let bodyTemperature = Celsius2(37.0)
        
        //5.可选属性类型
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        cheeseQuestion.response = "Yes, I do like cheese"
        
        //7.结构体类型的成员初始化器
        //不同于默认初始化器，结构体会接收成员初始化器即使它的存储属性没有默认值。
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        //11.2指定和便捷初始化器的操作
        var breakfastList = [
            ShoppingListItem2(),
            ShoppingListItem2(name: "Bacon"),
            ShoppingListItem2(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x Orange juice ✔
        // 1 x Bacon ✘
        // 6 x Eggs ✘
        
        //12.可失败初始化器
        //为了确保数字类型之间的转换保持值不变，使用 init(exactly:)  初始化器。如果类型转换不能保持值不变，初始化器失败。
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber){
            print("\(wholeNumber) conversion to int maintains value")
        }
        
        let valueChanged = Int(exactly: pi)
        if valueChanged == nil {
            print("\(pi) conversion to int does not maintain value")
        }
        
        let someCreature = Animal(species: "Giraffe")
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        
        //为空
        let anonymousCreature = Animal(species: "")
        // anonymousCreature is of type Animal?, not Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        
        //13 枚举的可失败初始化器
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // prints "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        
        //13.1 带有原始值枚举的可失败初始化器
        let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
        if fahrenheitUnit2 != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
    }
}

//1.初始化器
struct Fahrenherit {
    //var temperature = 32.0   //默认的属性值
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

//2.自定义初始化
struct Celsius {
    var temperatureInCelsius: Double
    //初始化形式参数
    init(fromFahreheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

//3.形式参数名和实际参数标签
struct Color {
    let red, green, blue:Double
    init(red: Double, green: Double, blue:Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

//4.无实际参数标签的初始化器形式参数
struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

//5.可选属性类型
class SurveyQuestion {
    //5.1 let text: String  //在初始化中分配常量属性
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}


//6.默认初始化器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

//7.结构体类型的成员初始化器
struct Size {//不同于默认初始化器，结构体会接收成员初始化器即使它的存储属性没有默认值。
    var width = 0.0, height = 0.0
}

//8.值类型的初始化器委托
struct Point2 {
    var x = 0.0, y = 0.0
}

struct Rect2 {
    var origin = Point2()
    var size = Size()
    init() {} //默认赋零初始化
    
    init(origin: Point2, size: Size) { //初始化器二
        self.origin = origin
        self.size = size
    }
    
    init(center: Point2, size: Size) {//初始化器三
        
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point2(x: originX, y: originY), size: size)
    }
}

//9.类的继承和初始化
//9.1指定初始化器和便捷初始化器
/*
 init(parameters) {//指定初始化器
    statements
 }
 */

/*
 convenience init(parameters) {//便捷初始化器
    statements
 }
 */

//10.两段式初始化

//11.初始化器的继承和重写
/*
 不像在 Objective-C 中的子类，Swift 的子类不会默认继承父类的初始化器。Swift 的这种机制防止父类的简单初始化器被一个更专用的子类继承并被用来创建一个没有完全或错误初始化的新实例的情况发生。
 */

class Vehicle2 {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle2: Vehicle2 {
    override init() {
        super.init()  //调用父类的初始化器
        numberOfWheels = 2
    }
}

//11.1自动初始化器的继承
/*
 规则1
 如果你的子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器。
 
 规则2
 如果你的子类提供了所有父类指定初始化器的实现——要么是通过规则1继承来的，要么通过在定义中提供自定义实现的——那么它自动继承所有的父类便捷初始化器。
 */

//11.2指定和便捷初始化器的操作
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem2: RecipeIngredient {//ShoppingListItem 会自动从父类继承所有的指定和便捷初始化器。
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

//12.可失败初始化器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

//13.枚举的可失败初始化器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
            
        default:
            return nil
        }
    }
}


//13.1 带有原始值枚举的可失败初始化器
/*
 带有原始值的枚举会自动获得一个可失败初始化器 init?(rawValue:) ，该可失败初始化器接收一个名为 rawValue 的合适的原始值类型形式参数如果找到了匹配的枚举情况就选择其一，或者没有找到匹配的值就触发初始化失败。
 */
enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}


//13.2 初始化失败的传递
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

//13.3 重写可失败初始化器
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a non-empty name value
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//在初始化器里使用强制展开来从父类调用一个可失败初始化器作为子类非可失败初始化器的一部分
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//13.4 可失败初始化器 init!  使用可失败初始化器创建一个隐式展开具有合适类型的可选项实例

//14 必要初始化器
class SomeClass3 {
    required init() {//在类的初始化器前添加 required  修饰符来表明所有该类的子类都必须实现该初始化器：
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass3 {
    required init() {//当子类重写父类的必要初始化器时，必须在子类的初始化器前同样添加 required
        // subclass implementation of the required initializer goes here
    }
}

//15.通过闭包和函数来设置属性的默认值
/*
 如果某个存储属性的默认值需要自定义或设置，你可以使用闭包或全局函数来为属性提供默认值。当这个属性属于的实例初始化时，闭包或函数就会被调用，并且它的返回值就会作为属性的默认值。
 */
class SomeClass4 {
    let someProperty: String = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return ""
    }()  //注意闭包花括号的结尾跟一个没有参数的圆括号。这是告诉 Swift 立即执行闭包。
}

struct Chessboard {
    let boardColors: [Bool] = {
       var temporatyBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8{
                temporatyBoard.append(isBlack)
                isBlack = !isBlack
            }
        }
        return temporatyBoard
    }() //无论何时，创建一个新的 Checkboard ，闭包就会执行，并且 boardColors 的默认值就会计算和返回。
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
