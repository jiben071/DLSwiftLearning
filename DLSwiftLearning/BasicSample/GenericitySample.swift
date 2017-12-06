//
//  GenericitySample.swift
//  DLSwiftLearning
//
//  Created by denglong on 29/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  泛型

import UIKit

class GenericitySample: NSObject {
    func testFunction() {
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        //1.泛型函数
        swapTwoValues(&someInt, &anotherInt)
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        
        
        //3.泛型类型
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        
        let fromTheTop = stackOfStrings.pop()
        
        //4.扩展一个泛型类型
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
        
        //非泛型函数
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findIndex(ofString: "llama", in: strings) {
            print("The index of llama is \(foundIndex)")
        }
        
        //6.类型约束的应用
        let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
        // doubleIndex is an optional Int with no value, because 9.3 is not in the array
        let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
        // stringIndex is an optional Int containing a value of 2
        
        
        //8.泛型Where分句
        var stackOfStrings2 = Stack2<String>()
        stackOfStrings2.push("uno")
        stackOfStrings2.push("dos")
        stackOfStrings2.push("tres")
        
        var arrayOfStrings = ["uno", "dos", "tres"]
        
//        if allItemsMatch(stackOfStrings2, arrayOfStrings) {
//            print("All items match.")
//        }else{
//            print("Not all items match.")
//        }
        
        if stackOfStrings2.isTop("tres") {
            print("Top element is tres.")
        } else {
            print("Top element is something else.")
        }
        
        if [9, 9, 9].startsWith(42) {
            print("Starts with 42.")
        } else {
            print("Starts with something else.")
        }
        
    }
    
    
    //标准非泛型函数
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //写一个可以交换任意类型值的函数会更实用、更灵活。泛型代码让你能写出这样的函数。
    //泛型函数
    //T 是一个 swapTwoValues(_:_:) 函数定义里的占位符类型名。因为 T 是一个占位符，Swift 不会查找真的叫 T 的类型。
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {//2.类型形式参数  T
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //6.类型约束的应用
    //非泛型函数
    func findIndex(ofString valueOfFind: String, in array: [String]) -> Int? {
        for (index,value) in array.enumerated() {
            if value == valueOfFind {
                return index
            }
        }
        return nil
    }
    
    //泛型函数
    //任何 Equatable 的类型都能安全地用于 findIndex(of:in:) 函数，因为可以保证那些类型支持相等操作符。
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind  {
                return index
            }
        }
        return nil
    }
    
    //8.泛型Where分句
    func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable{
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        //Check each pair of items to see if they are equivalent
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true
        return true
    }
}

//3.泛型类型
//非泛型版本
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int){//mutating为啥要用，因为他们需要修改（或者说改变）结构体的 items 数组
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//泛型版本
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//4.扩展一个泛型类型
extension Stack {
    var topItem: Element? {  //只读计算属性
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

//5.类型约束
/*
 语法
 func someFunction<T: SomeClass(约束的类类型), U: SomeProtocol（约束的需遵守的协议）>(someT: T, someU: U) {
 // function body goes here
 }
 */


//6.关联类型
protocol Container {
    associatedtype ItemType  //声明了一个关联类型
    mutating func append(_ item: ItemType) //必须能够通过 append(_:) 方法向容器中添加新元素；
    var count: Int {get} //必须能够通过一个返回 Int 值的 count 属性获取容器中的元素数量；
    subscript(i: Int) -> ItemType {get} //必须能够通过 Int 索引值的下标取出容器中每个元素。
    
    //9.关联类型的泛型Where分句 做一个包含遍历器的 Container
    associatedtype Iterator: IteratorProtocol where Iterator.Element == ItemType
    //Iterator 中的泛型 where 分句要求遍历器以相同的类型遍历容器内的所有元素，无论遍历器是什么类型。
    //makeIterator() 函数提供了容器的遍历器的访问。
    func makeIterator() -> Iterator
}

struct IntStack2 {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    //conformance to the Container protocol
    typealias ItemType = Int // 把 ItemType 抽象类型转换为了具体的 Int 类型。也可以不用，因为类型推断已经推断出来了
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
    
//    func makeIterator() -> IntStack2.Iterator {
//
//    }
}


struct Stack2<Element> {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        return items.append(item)
    }
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Element{
        return items[i]
    }
    
//    func makeIterator() -> Stack2<Element>.Iterator {
//
//    }
}

//7.扩展现有类型来指定关联类型
extension Array: Container {
    
}

//8.带有泛型Where分句
extension Stack2 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {//守卫栈顶的元素都不能为空
            return false
        }
        return topItem == item
    }
}


extension Container where ItemType: Equatable {
    //首先确保容器拥有至少一个元素，然后它检查第一个元素是否与给定元素相同。
    func startsWith(_ item: ItemType) -> Bool {
        return count >= 1 && self[0] == item
    }
}

//写一个泛型 where 分句来要求 Item 为特定类型
//在 Item 是 Double 时给容器添加了 average()  方法
extension Container where ItemType == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}


//对于一个继承自其他协议的协议来说，你可以通过在协议的声明中包含泛型 where 分句来给继承的协议中关联类型添加限定
//protocol ComparableContainer: Container where ItemType: Conparable {
//
//}


//10.泛型下标  还有疑问
extension Container {
    //在 subscript 后用尖括号来写类型占位符，你还可以在下标代码块花括号前写泛型 where 分句
    subscript<Indices: Sequence>(indices: Indices) -> [ItemType] where Indices.Iterator.Element == Int {
        var result = [ItemType]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}
