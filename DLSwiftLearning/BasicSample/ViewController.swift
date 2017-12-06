//
//  ViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 2017/10/26.
//  Copyright © 2017年 ubtrobot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.basicTest();//基础测试1
        
        ARCSample().testFunction();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //基础内容
    func basicTest() {
        //1.常量与变量
        let maxTimeout = 30;//常量：超时时长
        var isCurrentConnecting: Bool = false;//变量  兼顾了类型标注
        isCurrentConnecting = true;
        print(maxTimeout,isCurrentConnecting);
        
        //2.类型标注
        var welcomeMessage:String = "欢迎观临";
        welcomeMessage = "欢迎时间";
        print(welcomeMessage);
        
        var red,green,blue:Double; //多个类型同时标注
        
        //3.打印变量和常量
        print("The current value of welcomeMessage is \(welcomeMessage)");//在字符串里面嵌套变量
        
        //4.类型的最大值 最小值
        let maxValue = UInt8.max;
        let minValue = UInt8.min;
        
        
        //5.类型推断：自动推断类型，无须指明类型  （类型安全：会在编译阶段进行类型检查）
        let meaningOfLife = 20;
        let pi = 3.14159
        let anotherPi = 3 + 0.14159
        
        //6.数值型字面量
        let decimalInteger = 17
        let binaryInteger = 0b10001 //二进制的17
        let octalInteger = 0o21 //八进制的17
        let hexadecimalInteger = 0x11 //十六进制的17
        
        //7.整数转换
        let twoThousand: UInt16 = 2_000;
        let one :UInt8 = 1;
        let twoThousandAndOne = twoThousand + UInt16(one)
        
        //8.整数和浮点数的转换
        let three = 3;
        let pointOneFourOneFiveNine = 0.14159;
        let piThree = Double(three) + pointOneFourOneFiveNine;//不转换，我如何知道你要什么类型
        
        //9.布尔值  true false
        let orangesAreOrange = true
        let turnipsAreDelicious = false
        
        if turnipsAreDelicious {
            print("Mmm, tasty turnips!")
        }else{
            print("Eww, turnips are horrible")
        }
        
        //Swift 的类型安全机制会阻止你用一个非布尔量的值替换掉 Bool
        let i = 1
        if i == 1 {
            print("tue");
        }
        
        //10.元组
        let http404Error = (404,"Not Found")
        let http404ErrorType = (statusCode:404,description:"OK")//构造元组
        print("code:\(http404ErrorType.statusCode) message:\(http404ErrorType.description)")//解析元组
        
        //11.可选项  可以利用可选项来处理值可能缺失的情况。
        //这里有一个值，他等于x    或者     这里根本没有值
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        
        
        //12.nil
        /*Swift 中的 nil 和Objective-C 中的 nil 不同，在 Objective-C 中 nil 是一个指向不存在对象的指针。
         在 Swift中， nil 不是指针，他是值缺失的一种特殊类型，任何类型的可选项都可以设置成 nil 而不仅仅是对象类型。*/
        var serverResponseCode: Int? = 404  //如果没有设置默认值，默认值为nil
        serverResponseCode = nil  //可选的变量才能置为nil
        
        //13.If 语句以及强制展开
        if convertedNumber != nil{
            print("converedNumber contains some integer value:\(convertedNumber!).")//叹号的作用是强制展开，表示我确定它有值
        }
        
        //14.可选项绑定
        /*可以使用可选项绑定来判断可选项是否包含值，如果包含就把值赋给一个临时的常量或者变量。可选绑定可以与 if 和 while 的语句使用来检查可选项内部的值，并赋值给一个变量或常量。*/
        if let actualNumber = Int(possibleNumber){
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        }else{
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }
        
        //你可以在同一个 if 语句中包含多可选项绑定，用逗号分隔即可。如果任一可选绑定结果是 nil 或者布尔值为 false ，那么整个 if 判断会被看作 false
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100{
            print("\(firstNumber) < \(secondNumber) < 100")
        }
        
        //上面的条件判断等效于下面的代码
        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }
        // Prints "4 < 42 < 100"
        
        
        //15.隐式展开可选项
        
        //显式展开可选项
        let possibleString: String? = "An optinal string."
        let forceString:String = possibleString! // requires an exclamation mark  要求一个显式的叹号
        
        //隐式展开可选项
        let asumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = asumedString //no need for an exclamation mark 无需强制叹号
        
        //16.错误处理
        do{
            try makeASandwich()
        }catch{
            //发生了错误
        }
        
        //17.断言和先决条件
        let age = -3
        assert(age >= 0,"A person's age cannot be less than zero")
        //标明断言失败
        if age > 10{
            print("You can ride the roller-coaster of the ferris wheel")
        }else if age > 0{
            print("You can ride the ferris wheel.")
        }else{
            assertionFailure("A person's age can't be less the zero.")
        }
        
        //18.强制先决条件
        /*在你代码中任何条件可能潜在为假但必须肯定为真才能继续执行的地方使用先决条件。比如说，使用先决条件来检测下标没有越界，或者检测函数是否收到了一个合法的值。*/
        let index = 1
        precondition(index > 0,"Index must be greater than zero.")
    }
    
    
    //错误处理演示
    func makeASandwich() throws {
        
    }
    
    
    //基本运算符
    func basicdOperator() {
        //1.赋值运算符
        let b = 10
        var a = 5
        a = b
        
        let (x,y) = (1,2) //x = 1,  y = 2
        
        //2.算术运算符
        1 + 2
        5 - 3
        2 * 3
        10.0 / 2.5
        //拼接字符串
        "hello," + "world"
        
        //3.余数运算符
        //余数运算符（ a % b ）可以求出多少个 b  的倍数能够刚好放进 a  中并且返回剩下的值（就是我们所谓的余数）。
        9 % 4 //equals 1
        
        //4.一元减号运算符
        let three = 3
        let minusThree = -three  //-3
        let plusThree = -minusThree  //3
        
        //5.一元加号运算符
        //一元加号运算符 （ + ）直接返回它操作的值，不会对其进行任何的修改：
        let minusSix = -6
        let alsoMinusSix = +minusSix
        
        //6.组合赋值符号
         a = 1
        a += 2
        
        //7.比较运算符
        1 == 1
        2 != 1
        2 > 1
        1 < 2
        1 >= 1
        2 <= 1
        
        let name = "world"
        if name == "world" {//用于条件判断
            print("hello, world")
        }else{
            print("I'm sorry \(name), but I don't recognize you")
        }
        
        //元组的比较
        (1,"zebra") < (2,"apple")
        (3,"apple") < (3,"bird")
        (4,"dog") == (4,"dog")
        
        //8.三元条件运算符
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)//必须要有空格，防止与可选项串起来
        
        
        //9.合并空值运算符
        /*合并空值运算符 （ a ?? b ）如果可选项 a  有值则展开，如果没有值，是 nil  ，则返回默认值 b 。*/
        //表达式 a 必须是一个可选类型。表达式 b  必须与 a  的储存类型相同。
        let defaultColorName = "red"
        var userDefinedColorName:String?//defualts to nil
        var colorNameToUse = userDefinedColorName ?? defaultColorName
        
        //10.区间运算符
        //10.1闭区间运算符
        //闭区间运算符（ a...b ）定义了从 a  到 b  的一组范围，并且包含 a  和 b
        for index in 1...5{
            print("\(index) times 5 is \(index * 5)")
        }
        
        //10.2半开区间运算符
        //半开区间运算符（ a..<b ）定义了从 a  到 b  但不包括 b  的区间，即 半开 ，因为它只包含起始值但并不包含结束值。（
        let names = ["Anna","Alex","Brian","Jack"]
        let count = names.count
        for i in 0..<count {
            print("Person \(i + 1) is called \(names[i])")
        }
        
        //11.单侧区间
        //闭区间有另外一种形式来让区间朝一个方向尽可能的远
        for name in names {
            print(name)
        }
        
        for name in names[...2] {
            print(name)
        }
        
        for name in names[..<2] {
            print(name)
        }
        
        //12.逻辑运算符
        //逻辑非
        let allowedEntry = false
        if !allowedEntry {
            print("ACCESS DENIED")
        }
        
        //逻辑与
        let enteredDoorCode = true
        let passedRetinaScan = false
        if enteredDoorCode && passedRetinaScan{
            print("Welcome")
        }else{
            print("ACCESS DENIED")
        }
        
        //逻辑或
        let hasDoorKey = false
        let knowsOverridePassword = true
        if hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        
        //混合逻辑运算
        
        //13.显式括号
        if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        
        
    }
    
    //字符串和字符
    func stringOperate() {
        //1.字符串字面量
        let someString = "Some string literal value"
        
        //多行字符串字面量
        let quotationString = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Myjesty" he ascked.
"""
        
        //2.初始化一个空字符串
        var emptyString = ""
        var anotherEmptyString = String()
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        
        //3.字符串可变性
        //你可以通过把一个 String设置为变量（这里指可被修改），或者为常量（不能被修改）来指定它是否可以被修改（或者改变）：
        var variableString = "Horse"
        variableString += " and carriage"
        
        
        //4.字符串是值类型
        //如果你创建了一个新的 String值， String值在传递给方法或者函数的时候会被复制过去，还有赋值给常量或者变量的时候也是一样。每一次赋值和传递，现存的 String值都会被复制一次，传递走的是拷贝而不是原本。
        
        //5.操作字符串
        for character in "Dog!🐶".characters{
            print(character)
        }
        
        let catCharacters: [Character] = ["C","a","t","!","🐱"]
        let catString = String(catCharacters)
        print(catString)
        
        //6.连接字符串和字符
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2
        var instruction = "look over"
        instruction += string2
        
        //追加一个字符
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)
        
        //7.字符串插值
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        
        //8.Unicode标量
        //面板之下，Swift 的原生 String 类型建立于 Unicode 标量值之上。
        
        //9.字符串字面量中的特殊字符
        //转义特殊字符 \0 (空字符)， \\ (反斜杠)， \t (水平制表符)， \n (换行符)， \r(回车符)， \" (双引号) 以及 \' (单引号)；
        //任意的 Unicode 标量，写作 \u{n}，里边的 n是一个 1-8 个与合法 Unicode 码位相等的16进制数字。
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        let dollarSign = "\u{24}"
        
        //10.扩展字形集群
        let eAcute: Character = "\u{E9}"
        let combineEacute: Character = "\u{65}\u{301}"
        
        let precomposed: Character = "\u{D55C}"
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}" // ᄒ, ᅡ, ᆫ
        let enclosedEAcute: Character = "\u{E9}\u{20DD}"
        // enclosedEAcute is é⃝
        
        //11.字符统计
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print("UnusalMenagerie has \(unusualMenagerie.characters.count) characters")
        //print "UnusalMenageries has 40 characters"
        
        
        //12.访问和修改字符串
        //字符串索引
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex] // G
        greeting[greeting.index(before: greeting.endIndex)] //!
        greeting[greeting.index(after: greeting.startIndex)] //u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        greeting[index] //a
        
        greeting[greeting.endIndex]
        greeting.index(after: greeting.endIndex)
        
        //访问独立字符
        for index in greeting.characters.indices {
            print("\(greeting[index])", separator: " ", terminator: "")
            // Prints "G u t e n   T a g ! "
        }
        
        //插入和删除
//        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex) //插入字符
        welcome.insert(contentsOf: " there".characters, at: welcome.index(before: welcome.endIndex))//插入字符集
        
        
        welcome.remove(at: welcome.index(before: welcome.endIndex))//删除一个字符
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)//删除一段字符
        
        //你可以在任何遵循了 RangeReplaceableIndexable 协议的类型中使用 insert(_:at:) ， insert(contentsOf:at:) ， remove(at:) 方法。这包括了这里使用的 String ，同样还有集合类型比如 Array ， Dictionary 和 Set 。
        
        
        //13.字符串比较
        //13.1 字符串和字符相等性
        let quotation = "We're a lot alike, you and I."
        let sameQuatation = "We're a lot alike, you and I."
        if quotation == sameQuatation {
            print("These two string are considered equal")
        }
        
        //13.2前缀和后缀相等性
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 "){
                act1SceneCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion"){
                mansionCount += 1
            }else if scene.hasSuffix("Friar Lawrence's cell"){
                cellCount += 1
            }
        }
        
        //14.字符串的Unicode表示法
        //14.1 UTF-8表示法
        let dogString = "Dog‼🐶"
        for codeUnit in dogString.utf8 {
            print("\(codeUnit) ", terminator: "")
        }
        
        //14.2 UTF-16 表示法
        for codeUnit in dogString.utf16 {
            print("\(codeUnit) ", terminator: "")
        }
        
        //14.3 Unicode 标量表示法
        for scalar in dogString.unicodeScalars {
            print("\(scalar.value) ", terminator: "")
        }
        
        
        
    }
    
    //集合类型
    func numberSetAbout()  {
        //1.数组
        //1.1 创建一个空数组
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items")
        //置空
        someInts = []
        
        //1.2 使用默认值创建数组
        var threeDoubles = Array.init(repeating: 0.0, count: 3)
        
        //1.3通过链接两个数组来创建数组
        var anotherThreeDoubles = Array.init(repeating: 2.5, count: 3)
        
        var sixDoubles = threeDoubles + anotherThreeDoubles
        
        //1.4使用数组字面量创建数组
//        var shoppingList:[String] = ["Eggs","Milk"]
        var shoppingList = ["Eggs","Milk"]  //可以自动类型推断
        
        //1.5 访问和修改数组
        //数量
        print(shoppingList.count)
        //检查是否为空
        if shoppingList.isEmpty{
            print("empty")
        }
        
        //末尾追加
        shoppingList.append("Flour")
        shoppingList += ["Baking Powder"]
        shoppingList += ["Chocolate Spread","Cheese","Butter"]
        
        //取值
        var firstItem = shoppingList[0]
        
        //修改
        shoppingList[0] = "Six eggs"
        //范围替换  你同样可以使用下标脚本语法来一次改变一个范围的值，就算替换与范围长度不同的值的合集也行。
        shoppingList[4...6] = ["Bananas","Apples"]
        
        //元素插入
        shoppingList.insert("Maple Syrup", at: 0)
        
        //移除元素
        let mapleSyrup = shoppingList.remove(at: 0);
        
        //移除最后一个
        let apples = shoppingList.removeLast();
        
        //1.6 遍历一个数组
        for item in shoppingList {
            print(item)
        }
        
        //遍历数值以及索引值
        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        
        //2.合集  合集将同一类型且不重复的值无序地储存在一个集合当中。当元素的顺序不那么重要的时候你就可以使用合集来代替数组，或者你需要确保元素不会重复的时候。
        
        //所以必须计算哈希值
        
        //2.1 创建并初始化一个空合集
        var letters = Set<Character>()
        print(letters.count)
        
        //置空
        letters.insert("a")
        letters = []
        
        //2.2使用数组字面量创建合集
//        var favoriteGenres: Set<String> = ["Rock","Classical","Hip hop"]
        //自动推断
        var favoriteGenres: Set = ["Rock","Classical","Hip hop"]
        
        //2.3访问和修改合集
        print(favoriteGenres.count)
        
        if favoriteGenres.isEmpty {
            print("empty")
        }
        
        //插入
        favoriteGenres.insert("Jazz")
        //移除
        favoriteGenres.remove("Rock")//通过哈希值匹配
        //检查是否包含了某元素
        if favoriteGenres.contains("Funk") {
            print("yes")
        }
        
        //2.4遍历合集
        for gere in favoriteGenres {
            print("\(gere)")
        }
        
        //以有序遍历
        for genre in favoriteGenres.sorted() {
            print("\(genre)")
        }
        
        //2.5执行合集操作
        /*
         使用 intersection(_:)方法来创建一个只包含两个合集共有值的新合集；
         使用 symmetricDifference(_:)方法来创建一个只包含两个合集各自有的非共有值的新合集；
         使用 union(_:)方法来创建一个包含两个合集所有值的新合集；
         使用 subtracting(_:)方法来创建一个两个合集当中不包含某个合集值的新合集。
         */
        
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        oddDigits.union(evenDigits).sorted()
        oddDigits.intersection(evenDigits).sorted()
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        
        
        //2.6 合集成员关系和相等性
        /*
         使用“相等”运算符 ( == )来判断两个合集是否包含有相同的值；
         使用 isSubset(of:) 方法来确定一个合集的所有值是被某合集包含；
         使用 isSuperset(of:)方法来确定一个合集是否包含某个合集的所有值；
         使用 isStrictSubset(of:) 或者 isStrictSuperset(of:)方法来确定是个合集是否为某一个合集的子集或者超集，但并不相等；
         使用 isDisjoint(with:)方法来判断两个合集是否拥有完全不同的值。
         */
        
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubset(of: farmAnimals)
        farmAnimals.isSuperset(of: houseAnimals)
        farmAnimals.isDisjoint(with: cityAnimals)
        
        //3.字典
        //3.1创建一个空字典
        var namesOfIntegers = [Int: String]()
        //置空
        namesOfIntegers[16] = "sixteen"
        namesOfIntegers = [:]
        
        //3.2用字典字面量创建字典
        var airports:[String:String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        //3.3访问和修改字典
        print(airports.count)
        if airports.isEmpty {
            print("empty")
        }
        
        //添加新元素
        airports["LHR"] = "London"
        //修改
        airports["LHR"] = "London Heathrow"
        
        //updateValue返回一个可选项
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print(oldValue)
        }
        
        //取值
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        
        //移除一个键值对
        airports["APL"] = "Apple International"
        airports["APL"] = nil
        
        if let removeValue = airports.removeValue(forKey: "DUB") {
            print(removeValue)
        }
        
        //3.4 遍历字典
        for (airportCode,airportName) in airports {
            print("\(airportCode):\(airportName)")
        }
        
        //遍历keys或者values
        for airportCode in airports.keys {
            print(airportCode)
        }
        
        for airportName in airports.values {
            print(airportName)
        }
        
        //用keys或values创建数组
        let airpointCodes = [String].init(airports.keys)
        let airportNames =  [String].init(airports.values)
    }
    
    //控制流
    func controlFlow() {
        //1.For in 循环
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        
        
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        //省略遍历的值
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        
        //跳跃式遍历
        let minuteInterval = 5
        let minutes = 60
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
        }
        
        //跳跃式遍历 闭区间
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            // render the tick mark every 3 hours (3, 6, 9, 12)
        }
        
        //2.While循环
        /*
         while 在每次循环开始的时候计算它自己的条件；
         repeat-while 在每次循环结束的时候计算它自己的条件。
         */
        
        //农夫与蛇
        //游戏棋盘
        let finalSquare = 25
        var board = [Int].init(repeating: 0, count: finalSquare + 1)
        
        //有些方格随后设置为拥有更多特定的值比如蛇和梯子。有梯子的方格有一个正数来让你移动到棋盘的上方，因此有蛇的方格有一个负数来让你从棋盘上倒退：
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        
        //玩家从“零格”开始，它正好是棋盘的左下角。第一次扔色子总会让玩家上到棋盘上去：
        var square = 0 //农夫走的步数
        var diceRoll = 0 //骰子
        while square < finalSquare {
            //roll the dice
            diceRoll += 1
            if diceRoll == 7{
                diceRoll = 1
            }
            square += diceRoll
            if square < board.count{
                square += board[square]
            }
        }
        
        //2.Repeat-While
        //在判断循环条件之前会执行一次循环代码块。然后会继续重复循环直到条件为 false
        repeat{
            // move up or down for a snake or ladder
            square += board[square]
            // roll the dice
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            // move by the rolled amount
            square += diceRoll
        }while square < finalSquare
        
        //3.条件语句
        var temperatureInFahrenheit = 30
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        }
        
        //4.Swith 没有隐式贯穿
        let someCharacter:Character = "z"
        switch someCharacter {
        case "a","b"://可以匹配多个值
             print("The first letter of the alphabet")
        case "z":
             print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        
        //4.1区间匹配
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "NO"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        
        //4.2 元组
        let somePoint = (1,1)
        switch somePoint {
        case (0,0):
            print("(0, 0) is at the origin")
        case (_,0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0,_):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2,-2...2):
         print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        
        //4.3 值绑定
        /*
         switch 情况可以将匹配到的值临时绑定为一个常量或者变量，来给情况的函数体使用。这就是所谓的值绑定，因为值是在情况的函数体里“绑定”到临时的常量或者变量的。
         */
        let anotherPoint = (2,0)
        switch anotherPoint {
        case (let x,0)://匹配X轴
            print("on the x-axis with an x value of \(x)")
        case (0, let y)://匹配Y轴
            print("on the y-axis with a y value of \(y)")
        case let (x, y):// 坐标轴上的其它点
            print("somewhere else at (\(x), \(y))")
        }
        
        //4.4 Where 检查额外的情况
        let yetAnotherPoint = (1,-1)
        switch yetAnotherPoint {
        case let (x,y) where x == y:  //设置额外条件
            print("(\(x), \(y)) is on the line x == y")
        case let (x,y) where x == -y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        //4.5 复合情况
//        someCharacter = "e"
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        
        //复合情况同样可以包含值绑定
        /*(let distance, 0)  匹配 x 轴的点以及 (0, let distance) 匹配 y 轴的点。两个模式都包含一个 distance 的绑定并且 distance 在两个模式中都是整形——也就是说这个 case 函数体的代码一定可以访问 distance 的值。*/
        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        
        //5.控制转移语句
        //5.1 Continue
        /*continue 语句告诉循环停止正在做的事情并且再次从头开始循环的下一次遍历。*/
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput.characters {
            switch character {
            case "a", "e", "i", "o", "u", " "://不会打印到这些字符
                continue
            default:
                puzzleOutput.append(character)
            }
        }
        print(puzzleOutput)
        
        
        //5.2 Break
        /*
         break 语句会立即结束整个控制流语句。当你想要提前结束 switch 或者循环语句或者其他情况时可以在 switch 语句或者循环语句中使用 break 语句。
         */
        
        let numberSymbol: Character = "三"
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        }else{
            print("An integer value could not be found for \(numberSymbol).")
        }
        
        
        //5.3 Fallthrough
        //提供了贯穿switch case的能力  fallthrough 关键字不会为switch情况检查贯穿入情况的条件。
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2,3,5,7,11,13,17,19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        
        //6 给语句打标签
        gameLoop: while square != finalSquare{
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // diceRoll will move us to the final square, so the game is over
                break gameLoop  //终止游戏
            case let newSquare where newSquare > finalSquare: //值绑定 + 条件
                // diceRoll will move us beyond the final square, so roll again
                continue gameLoop  //重新游戏
            default:
                // this is a valid move, so find out its effect
                square += diceRoll
                square += board[square]
            }
        }
        
        //7 提前退出
        /*
         guard 语句，类似于 if 语句，基于布尔值表达式来执行语句。使用 guard 语句来要求一个条件必须是真才能执行 guard 之后的语句。与 if 语句不同， guard 语句总是有一个 else 分句—— else 分句里的代码会在条件不为真的时候执行。
         */
        
        greet(person: ["name":"John"])
        // prints "Hello John!"
        // prints "I hope the weather is nice near you."
        
        greet(person: ["name" : "Jane","location":"Cupertino"])
        // prints "Hello Jane!"
        // prints "I hope the weather is nice in Cupertino."
        
        //8 检查API的可用性
        if #available(iOS 10, macOS 10.12, *) {
            
        }else{
            
        }
    }
    
    func greet(person:[String : String]) {//guard  作用是可以防止else的多层套用
        guard let name = person["name"] else{
            return
        }
        
        print("Hello \(name)")
        
        guard let location = person["location"] else{
            print("I hope the weather is nice near you ")
            return
        }
        
        print("I hope the weather is nice in \(location)")
    }
    
    
    //函数
    func functionTest() {
        //1.定义和调用函数
        print(greet(person: "Anna"))
        print(greet(person: "Brian"))
        print(greetAgain(person: "Anna"))
        
        //2.函数的形式参数和返回值
        //2.1多形式参数的函数
        print(greet(person: "Tim", alreadyGreeted: true))
        
        //2.2无返回值的函数
        greetWithoudResponse(person: "Dave")
        
        //忽略返回值
        printWithoutCounting(string: "hello, world")
        
        //2.3多返回值的函数
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds?.min) and max is \(bounds?.max)")//需要強制解包
        
        //2.4可选元组返回类型
        //minMax(array:[Int]) -> (min: Int,max: Int)?
        
        //3.函数实际参数标签和形式参数名
        print(greetFormParameter(person: "Bill", from: "Cupertino"))
        
        //3.1省略实际参数标签
        print(someFunction(1, secondParameterName: 2))
        
        //3.2默认形式参数值
        someFunction2(parameterDefault: 6)
        someFunction2()
        
        
        //3.3可变形式参数
        arithmeticMean(numbers: 1,2,3,4,5)
        
        
        //3.4输入输出形式参数
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        //5.函數類型 每一个函数都有一个特定的函数类型，它由形式参数类型，返回类型组成。
        var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)
        print("Result: \(mathFunction(2,3))")  //加法
        
        mathFunction = multiplyTwoInts(_:_:)
        print("Result: \(mathFunction(2,3))")  //乘法
        
        let anotherMathFunction = addTwoInts  //自動進行類型推斷
        
        //5.1 函數類型作為形式參數類型
        printMathResult(addTwoInts, 3, 5)
        
        //5.2 函數類型作為返回類型
        var currentValue = 3
        let moveNearerToZero = chooseStepFunction(backwards: currentValue > 0)
        
        print("Counting to zero:")
        
        //Counting to zero:
        while currentValue != 0 {
            print("\(currentValue)....")
            currentValue = moveNearerToZero(currentValue)
        }
        
        //5.3內嵌函數
        currentValue = -4
        let moveNearerToZero2 = chooseStepFunction(backwards: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero2(currentValue)
        }
    }
    
    //函數類型作為返回類型  內嵌函數
    func chooseStepFunction(backwards:Bool) -> (Int) -> Int {
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        return backwards ? stepForward : stepBackward
    }
    

    

    
    
    
    func printMathResult(_ mathFunction: (Int,Int) -> Int, _ a: Int, _ b: Int ) {
        print("Result: \(mathFunction(a,b))")
    }
    
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    //輸入輸出形式參數
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let tempraryA = a
        a = b
        b = tempraryA
    }
    
    //可变形式参数
    func arithmeticMean(numbers:Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    
    //默认形式参数值
    func someFunction2(parameterDefault: Int = 12) {
        
    }
    
    
    //省略实际参数标签
    func someFunction(_ firstPrameterName:Int, secondParameterName:Int) {
        
    }
    
    //形式参数名 实际参数名
    func greetFormParameter(person:String, from hometown:String) -> String {
        return "Hello \(person)! Glad you could visit from \(hometown)"
    }
    
    func minMax(array:[Int]) -> (min: Int,max: Int)? {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin{
                currentMin = value
            }else if value > currentMax{
                currentMax = value
            }
        }
        return (currentMin,currentMax)
    }
    
    func printAndCount(string: String) -> Int {
        print(string)
        return string.characters.count
    }
    
    func printWithoutCounting(string:String) {
        let _ = printAndCount(string: string)
    }
    
    func greet(person:String) -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
    
    
    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }
    
    func greet(person:String,alreadyGreeted:Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        }else{
            return greet(person: person)
        }
    }
    
    func greetWithoudResponse(person:String){
         print("Hello, \(person)!")
    }
    
    
    
    
    
    
    //閉包
    func closerFunction(){
        //1.閉包表達式
        //1.1 Sorted方法
        let names = ["Chris","Alex","Ewa","Barry","Daniella"]
        
        var reverseNames = names.sorted(by: backward)
        
        //1.2 閉包表達式語法
        reverseNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        
        //1.2 從語境中推斷類型
        reverseNames = names.sorted(by: {s1, s2 in return s1 > s2})
        
        //1.3 從單表達式閉包隱式返回
        reverseNames = names.sorted(by: {s1, s2 in s1 > s2})
        
        //1.4 簡寫的實際參數名
        reverseNames = names.sorted(by: {$0 > $1})
        
        //1.5 運算符函數
        reverseNames = names.sorted(by: >)
        
        //2.尾隨閉包
        //使用方式一
        someFunctionThatTakesAClosure(closure:{
            
        })
        //使用方式4二
        someFunctionThatTakesAClosure(){
            
        }
        reverseNames = names.sorted(){
            $0 > $1
        }
        
        //如果閉包作為唯一參數
        reverseNames = names.sorted{
            $0 > $1
        }
        
        let digitNames = [
            0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
            5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
        ]
        
        let numbers = [16,58,510]
        
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat{
                output = digitNames[number % 10]! + output
                number /= 10
            }while number > 0
            return output
        }
        
        //3.捕獲值
        let incrementByTen = makeIncrementer(forIncrement: 10)
        incrementByTen()  //10
        incrementByTen()  //20
        
        
        //4.閉包是引用類型
        let alsoIncremntByTen = incrementByTen
        alsoIncremntByTen() //30
        

        //5.隱式閉包
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        
        completionHandlers.first?()
        print(instance.x)
        
        //6.自動閉包 self-motion  允許你延遲處理
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count) //Prints "5"
        
        let customerProvider = {
            customersInLine.remove(at: 0)
        }
        
        print(customersInLine.count) //Prints "5"
        
        print("Now serving \(customerProvider())")// Prints "Now serving Chris!"
        print(customersInLine.count) //Prints "4"
        
        
        //自動閉包調用  invoking
        serve(customer: customersInLine.remove(at: 0))
        
        //自動閉包允許逃逸
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")//不會馬上調用
        // Prints "Collected 2 closures."
        
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // Prints "Now serving Barry!"
        // Prints "Now serving Daniella!"
    }

    var customerProviders: [() -> String] = []
    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
    }
    
    //自動閉包  @autoclosure會導致代碼難以讀懂
    func serve(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
    }
    

    
    
    //捕獲值
    func makeIncrementer(forIncrement amout:Int) -> () -> Int {//() -> Int  函數類型作為返回值
        var runningTotal = 0
        func increment() -> Int {//注意循環引用的問題
            runningTotal += amout
            return runningTotal
        }
        return increment
    }
    
    
    //閉包處理  定義尾隨閉包
    func someFunctionThatTakesAClosure(closure:() -> Void) {
        
    }
    
    //排序的條件
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    
    
    

}

//非逃逸閉包
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFuctionEscapingClosure {//逃逸閉包需要引用self
            self.x = 100
        }
        someFunctionWithNonescapingClosure {//非逃逸閉包 可以隐式地引用 self
            x = 100
        }
    }
}

//5.逃逸閉包  啟動異步任務  escape closure  AsyncTask
var completionHandlers:[() -> Void] = []
func someFuctionEscapingClosure(completionHandler:@escaping () -> Void){
    completionHandlers.append(completionHandler)
}

