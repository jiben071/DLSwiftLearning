//
//  SubscriptSample.swift
//  DLSwiftLearning
//
//  Created by denglong on 21/11/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class SubscriptSample: NSObject {
    func test() {
        //1.下标的语法
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        
        //2.下标用法
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        
        //3.下标选项
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0,1] = 1.5
        matrix[1,0] = 3.2
        
        let somevalue = matrix[2,2]  //会造成下标越界
        print(somevalue)
    }
}

//1.下标的语法
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int{
        return multiplier * index
    }
}

//3.下标选项
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.columns = columns
        self.rows = rows
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            return grid[(row * columns) + column]
        }
        
        set{
            assert(indexIsValid(row: row, column: column),"Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
