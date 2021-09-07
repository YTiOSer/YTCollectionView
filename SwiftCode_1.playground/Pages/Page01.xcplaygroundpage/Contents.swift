let a = 10
let b = 20
var c = a+b
c += 30

import UIKit
import PlaygroundSupport

let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view

let imageView = UIImageView(image: UIImage(named: "ehiPlacHold399_255_dark"))
PlaygroundPage.current.liveView = imageView

let age: Int
age = 20

/* 多行注释
 1. aaa
 /*2.bbb*/
 */


//:# markup写法（类似markdown）

/*:
 # 学习swift
 # 学习响应式编程
  - RxSwift
 # 学习面向协议编程
 */

func getAge() -> Int {
    return age
}

let ageTwo = getAge()
print(ageTwo)


func 🐂🍺() {
  print("牛批666")
}

struct AStruct {
    var year: UInt
    var month: Int
    var day: Int
}

print(UInt8.max)

for i in 0...3 {
    print(i)
}

let range = 1...3
for i in range {
    print(i)
}

for var i in 1...3 {
    i += 1
    print(i)
}

let names = ["a", "b", "c"]
for itemName in names[0...2] {
    print(itemName)
}

let rangeStr = "aa"..."ff"

let hours = 11
let hourInterval = 2
for tickMark in stride(from: 4, through: hours, by: hourInterval) {

}

// fallthrough switch贯穿效果
var number = 1
switch number {
case 1:
    print(1)
case 2:
    print(2)
default:
    break
}


