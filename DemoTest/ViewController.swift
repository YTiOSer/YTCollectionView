//
//  ViewController.swift
//  DemoTest
//
//  Created by 杨涛 on 2020/3/3.
//  Copyright © 2020 杨涛. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let array = slidMedianAlg(array: [1, 2, 7, 8, 5], k: 3)
        print(array)
    }

}

//字符串翻转 负责度O(1)
extension ViewController {
    
    func reverseString(_ string: String) -> String {
        return String(string.reversed())
    }
}

// 滑动窗口中位数 时间复杂度O(n-2)
extension ViewController {
    
    func slidMedianAlg(array: [Int], k: Int) -> [Int] {
           
           var list = [Int]()
           
           if k == 0 { //窗口大小为0则返回空
               return list
           }
           
           //创建存储滑动窗口数组
           var arrayTemp = [Int]()
           var left = 0 //滑动窗口的左边
           var right = k - 1 //滑动窗口的右边
           
           //开始滑动
           while right < array.count {
               arrayTemp = getTempArray(array: array, left: left, right: right)
               list.append(sortArrayReturnMid(array: arrayTemp, k: k))
               left += 1
               right += 1
           }
           
           return list
       }
       
       func getTempArray(array: [Int], left: Int, right: Int) -> [Int] {
           var temp = [Int]()
           for element in array[left...right] {
               temp.append(element)
           }
           return temp
       }

       //数组排序并返回中位数
       func sortArrayReturnMid(array: [Int], k: Int) -> Int {
           let temp = array.sorted()
           return temp[(k - 1) / 2]
       }
}

// 打印螺旋矩阵 时间负责度 O(n)
extension ViewController {
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        
        var array: [Int] = [Int]()
        
        if matrix.count == 0 {
            return array
        }
        
        //层级
        var row1 = 0, row2 = matrix.count - 1
        var line1 = 0, line2 = matrix[0].count - 1
        
        while row1 <= row2, line1 <= line2 {
            
            //top
            for index in line1...line2 {
                array.append(matrix[row1][index])
            }
            
            //right
            var rowTemp = row1 + 1
            while row2 >= rowTemp {
                array.append(matrix[rowTemp][line2])
                rowTemp += 1
            }
            
            //这里要控制下最后的中间元素
            while row1 < row2 && line1 < line2 {
                //bottom
                var lineTemp = line2 - 1
                while lineTemp > line1 {
                    array.append(matrix[row2][lineTemp])
                    lineTemp -= 1
                }
                
                //left
                var rowTemp2 = row2
                while rowTemp2 > row1 {
                    array.append(matrix[rowTemp2][line1])
                    rowTemp2 -= 1
                }
            }
        }
        
        row1 += 1
        row2 -= 1
        line1 += 1
        line2 -= 1
        
        return array
    }
}

extension ViewController {
    
    //二分查找
    func findValueTwo(_ array: [Int], num: Int) -> Int {
        
        var left = 0
        var right = array.count - 1
        
        while left < right {
            let mid = (left + right) / 2
            if num == array[mid] {
                return mid
            }
            if num < array[mid] {
                right = mid - 1
            }
            if num > array[mid] {
                left = mid + 1
            }
        }
        
        return -1
    }
    
    // 冒泡
    func resetArray(_ array: [Int]) -> [Int] {
        
        var arrayTemp = array
        for i in 0..<array.count {
            for j in 0..<(array.count - i) {
                if arrayTemp[j] < arrayTemp[j + 1] {
                    let temp = arrayTemp[j]
                    arrayTemp[j] = arrayTemp[j + 1]
                    arrayTemp[j + 1] = temp
                }
            }
        }
        
        return arrayTemp
    }
    
    func checkThree(str1: String, str2: String, str3: String) -> String {
        
        if str1.count < str2.count {
            return "-1"
        }
        
        for i in 0..<str1.count {
            
            let indeex1 = str1.index(str1.startIndex, offsetBy: i)
            let index2 = str1.index(str1.startIndex, offsetBy: i + 1)
            let subStr1 = str1[indeex1..<index2]
            if subStr1 == str2.prefix(1) {
                let index3 = str1.index(str1.startIndex, offsetBy: i + str2.count)
                let subStr2 = str1[indeex1..<index3]
                if subStr2 == str2 {
                    let subStr1LeftIndex = str1.index(str1.startIndex, offsetBy: i - 1)
//                    let subStr1Left = str1[0..<subStr1LeftIndex]
//                    let subStr2RightIndex = str1.endIndex
//                    let subStr2Right = str1[index3..<subStr2RightIndex]
//                    str1 = subStr1Left + str3 + subStr2Right
                }
            }
            
            RequestManager.getSMSCode(phone: "") { (model) in
                
            }
            UserDefaults.standard.object(forKey: "stopSeconds")
        }
        
        return str1
    }
    
   
    //实现一个min函数，返回两个元素x较小值
    func getMin<T: Comparable>(_ a: T, _ b: T) -> T {
        return a < b ? a : b
    }
    
    
}

