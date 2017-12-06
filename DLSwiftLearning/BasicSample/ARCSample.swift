//
//  ARCSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 24/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  自动引用计数

import UIKit

class ARCSample: NSObject {
    func testFunction() {
        //1.ARC
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        reference1 = Person(name: "John Appleseed")
        reference2 = reference1
        reference3 = reference1
        
        reference1 = nil
        reference2 = nil
        
        reference3 = nil  //到这里才会销毁实例
        // prints "John Appleseed is being deinitialized"
        
        //2.类实例之间的循环强引用
        var john: Person2?
        var unit4A: Apartment?
        
        john = Person2(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        
        //互相引用
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        
        //3.1无主引用
        var john2: Customer?
        john2 = Customer(name: "John Appleseed")
        john2?.card = CrediCard(number: 1234_5678_9012_3456, customer: john2!)
        
        john2 = nil //最后的代码片段展示了在 john 变量被设为 nil 后 Customer 实例和 CreditCard 实例的反初始化器都打印出了“被释放”的信息。
        
        //4.无主引用和隐式展开的可选属性
        var country = Country(name: "Canada", capitalName: "Ottawa")
        
        
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
        
        
        //5.闭包的循环强引用
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = { //重新赋值闭包
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        
        print(heading.asHTML())//执行闭包
        
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        print(paragraph!.asHTML)
    }
}

//1.ARC
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//2.类实例之间的循环强引用
//解决循环强引用问题，可以通过定义类之间的关系为弱引用( weak )或无主引用( unowned )来代替强引用。
class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person2?  //使用弱引用，解决循环引用问题
    deinit { print("Apartment \(unit) is being deinitialized") }
}

//3.解决实例之间的循环强引用

//Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（ weak reference ）和无主引用（ unowned reference )。


//对于生命周期中会变为 nil 的实例使用弱引用。相反，对于初始化赋值后再也不会被赋值为 nil 的实例，使用无主引用。


//3.1无主引用
//无主引用假定是永远有值的。
//在这个数据模型中，一个客户可能有或者没有信用卡，但是一张信用卡总是关联着一个客户。为了表示这种关系， Customer 类有一个可选类型的 card 属性，但是 CreditCard 类有一个非可选类型的 customer 属性。

class Customer {
    let name: String
    var card: CrediCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CrediCard {
    let number: UInt64
    unowned let customer: Customer  //无主引用，解决强引用问题
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

//4.无主引用和隐式展开的可选属性
//还有第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil 。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式展开的可选属性。
class Country {
    let name: String
    var capitalCity: City! //首都  隐式展开的可选属性
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country //所属国
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//5.闭包的循环强引用
//Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（ closuer capture list ）

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in  //无主引用  self不可能为nil的时候，就要用无主引用
        if let text = self.text{
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//5.1 定义捕获列表
/*
 把捕获列表放在形式参数和返回类型前边，如果它们存在的话：
 lazy var someClosure: (Int, String) -> String = {
 [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 // closure body goes here
 }
 如果闭包没有指明形式参数列表或者返回类型，是因为它们会通过上下文推断，那么就把捕获列表放在关键字 in 前边，闭包最开始的地方：
 lazy var someClosure: () -> String = {
 [unowned self, weak delegate = self.delegate!] in
 // closure body goes here
 }
 */

//5.2 弱引用和无主引用
//在闭包和捕获的实例总是互相引用并且总是同时释放时，将闭包内的捕获定义为无主引用。

//相反，在被捕获的引用可能会变为 nil 时，定义一个弱引用的捕获。弱引用总是可选项，当实例的引用释放时会自动变为 nil 。这使我们可以在闭包体内检查它们是否存在。

//如果被捕获的引用永远不会变为 nil ，应该用无主引用而不是弱引用。











