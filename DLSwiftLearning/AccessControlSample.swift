//
//  AccessControlSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 02/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  访问控制
//  访问控制限制其他源文件和模块对你的代码的访问。这个特性允许你隐藏代码的实现细节，并指定一个偏好的接口让其他代码可以访问和使用。

import UIKit

class AccessControlSample: NSObject {

}

//1.模块和源文件
//Xcode 中的每个构建目标（例如应用程序包或框架）在 Swift 中被视为一个独立的模块。
//源文件是一个模块中的单个 Swift 源代码文件
//访问级别
/*
 1.Open 访问 和 public 访问 允许实体被定义模块中的任意源文件访问，同样可以被另一模块的源文件通过导入该定义模块来访问
 2.internal 访问 允许实体被定义模块中的任意源文件访问，但不能被该模块之外的任何源文件访问。  限制在 应用程序/模块内部使用
 3.File-private 访问 将实体的使用限制于当前定义源文件中。
 4.private 访问 将实体的使用限制于封闭声明中。
 */

/*
 open 访问仅适用于类和类成员，它与 public 访问区别如下：
 
 public 访问，或任何更严格的访问级别的类，只能在其定义模块中被继承。
 public 访问，或任何更严格访问级别的类成员，只能被其定义模块的子类重写。
 open 类可以在其定义模块中被继承，也可在任何导入定义模块的其他模块中被继承。
 open 类成员可以被其定义模块的子类重写，也可以被导入其定义模块的任何模块重写。
 */

//2.访问级别的指导准则
/*
 Swift 中的访问级别遵循一个总体指导准则：实体不可以被更低（限制更多）访问级别的实体定义。
 
 例如：
 
 一个 public 的变量其类型的访问级别不能是 internal, file-private 或是 private，因为在使用 public 变量的地方可能没有这些类型的访问权限。
 一个函数不能比它的参数类型和返回类型访问级别高，因为函数可以使用的环境而其参数和返回类型却不能使用。
 */

//3.默认访问级别——Inernal

//4.框架的访问级别  该框架的面向公众的接口标注为 open 或 public，这样它就能被其他的模块看到或访问

//5.单元测试目标的访问级别
// @testable  属性标注了导入的生产模块并且用使能测试的方式编译了这个模块，单元测试目标就能访问任何 internal 的实体

//6.访问控制语法
/*
 public class SomePublicClass {}
 internal class SomeInternalClass {}
 fileprivate class SomeFilePrivateClass {}
 private class SomePrivateClass {}
 
 public var somePublicVariable = 0
 internal let someInternalConstant = 0
 fileprivate func someFilePrivateFunction() {}
 private func somePrivateFunction() {}
 */

