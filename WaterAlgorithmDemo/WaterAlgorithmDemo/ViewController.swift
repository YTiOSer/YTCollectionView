//
//  ViewController.swift
//  WaterAlgorithmDemo
//
//  Created by 杨涛 on 2021/3/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveWater(array: [[1,2,2],[3,4,3],[5,8,1],[9,10,2]])
    }

    func saveWater(array: [[Int]]) -> Int {
        
        var water = 0
        
        /// 0或1个装不了水
        if (array.count == 0 || array.count == 1) {
            return water
        }
        
        var leftMax = 0
        var rightMax = 0
        var rightArray = [Int]()
        for (index, item) in array.enumerated() {
            rightMax = item > rightMax ? item : rightMax
            
        }
        
        return water
    }
}

