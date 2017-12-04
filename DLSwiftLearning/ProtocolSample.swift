//
//  ProtocolSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  协议

import UIKit

class ProtocolSample: NSObject {
    func testFunction() {
        let john = Person4(fullName: "John Appleseed")
        
        var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        
        //2.方法要求
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // Prints "Here's a random number: 0.37464991998171"
        print("And another one: \(generator.random())")
        // Prints "And another one: 0.729023776863283"
        
        //3.异变方法要求
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        
        //6.将协议作为类型
        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        
        //7.委托
        let tracker = DiceGameTracker()
        let game = SnakeAndLadders()
        game.delegate = tracker
        game.play()
        
        //8.在扩展里添加协议遵循
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        
        
        //9.使用扩展声明采纳协议
        //注意类型不会因为满足需要就自动采纳协议。它们必须显式地声明采纳了哪个协议。
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
        
        //10.协议类型的集合
        let things: [TextRepresentable] = [d12, simonTheHamster]
        for thing in things {
            print(thing.textualDescription)
        }
        
        //13.协议遵循的检查
        let objects: [AnyObject] = [
            ProtocolCircle(radius: 2.0),
            ProtocolCountry(area: 243_610),
            ProtocolAnimal(legs: 4)
        ]
        
        for object in objects {
            if let objectWithArea = object as? ProtocolHasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that doesn't have an area")
            }
        }
        
        //14.可选协议要求
        let counter = ProtocolCounter()
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        
        counter.count = -4
        counter.dataSource = TowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }
        
        //15.协议扩展
        let progenerator = LinearCongruentialGenerator()
        print("Here's a random number: \(progenerator.random())")
        // Prints "Here's a random number: 0.37464991998171"
        print("And here's a random Boolean: \(progenerator.randomBool())")
        
        //17.给协议扩展添加限制
        let murrayTheHamster = Hamster(name: "Murray")
        let morganTheHamster = Hamster(name: "Morgan")
        let mauriceTheHamster = Hamster(name: "Maurice")
        let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
        print(hamsters.textualDescription)
        
    }
}

//1.语法
/*
 class SomeClass: SomeSuperclass（父类）, FirstProtocol（协议1）, AnotherProtocol {
 // class definition goes here
 }
 */

//2.属性要求
protocol SomeProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }//即使用了static
}

protocol FullyNamed {
    var fullName: String {get}
}

struct Person4: FullyNamed {
    var fullName: String
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

//2.方法要求
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

//3.异变方法要求
protocol Toggolable {
    mutating func toggle()
}

enum OnOffSwitch:Toggolable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

//4.初始化器要求
protocol SomeProtocol2 {
    init(someParameter: Int)
}
class SomeClass5: SomeProtocol2 {
    required init(someParameter: Int) {//需要用required关键字修饰
        // initializer implementation goes here
    }
}


//情况二
protocol SomeProtocol3 {
    init()
}
class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}
class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {//如果一个子类重写了父类指定的初始化器，并且遵循协议实现了初始化器要求，那么就要为这个初始化器的实现添加 required 和 override 两个修饰符：
        // initializer implementation goes here
    }
}

//5.可失败初始化器要求

//6.将协议作为类型
/*
 在函数、方法或者初始化器里作为形式参数类型或者返回类型；
 作为常量、变量或者属性的类型；
 作为数组、字典或者其他存储器的元素的类型。
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//7.委托
protocol DiceGame {//DiceGame 协议是一个给任何与骰子有关的游戏采纳的协议
    var dice: Dice {get}
    func play()
}

protocol DiceGameDelegate {//DiceGameDelegate 协议可以被任何追踪 DiceGame 进度的类型采纳
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakeAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
            
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakeAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

//8.在扩展里添加协议遵循
protocol TextRepresentable {
    var textualDescription: String{get}
}

extension Dice: TextRepresentable{
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

extension SnakeAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}




//9.使用扩展声明采纳协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}


//10.协议继承
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String{get}
}

//SnakesAndLadders 类可以通过扩展来采纳和遵循 PrettyTextRepresentable ：
extension SnakeAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}


//11.类专用的协议  关键核心：AnyObject
protocol SomeInheritedProtocol {
    
}
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
}

//12.协议组合
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person6: Named, Aged {
    var name: String
    var age: Int
}

/*
 func wishHappyBirthday(to celebrator: Named & Aged) { //关键：Named & Aged  标明只要遵循这个组合协议的类都可以传入
 print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
 }
 
 let birthdayPerson = Person(name: "Malcolm", age: 21)
 wishHappyBirthday(to: birthdayPerson)
 */

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City6: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
/*
 func beginConcert(in location: Location & Named) {//任何 Location 的子类且遵循 Named 协议的类型
 print("Hello, \(location.name)!")
 }
 
 let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
 beginConcert(in: seattle)
 */

//13.协议遵循的检查
//你可以使用类型转换中描述的 is 和 as 运算符来检查协议遵循，还能转换为特定的协议。
protocol ProtocolHasArea {
    var area: Double { get }
}

class ProtocolCircle: ProtocolHasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class ProtocolCountry: ProtocolHasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class ProtocolAnimal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

//14.可选协议要求
//注意 @objc 协议只能被继承自 Objective-C 类或其他 @objc 类采纳。它们不能被结构体或者枚举采纳。
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int {get}
}

class ProtocolCounter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amout = dataSource?.increment?(forCount: count){
            count += amout
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

@objc class TowardsZeroSource: NSObject, CounterDataSource{
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

//15.协议扩展
/*
 通过给协议创建扩展，所有的遵循类型自动获得这个方法的实现而不需要任何额外的修改。
 */
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//16.提供默认实现
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//17.给协议扩展添加限制
//你可以给 Collection 定义一个扩展来应用于任意元素遵循上面 TextRepresentable 协议的集合
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{$0.textualDescription}
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}





